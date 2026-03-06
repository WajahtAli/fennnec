import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:fennac_app/app/app.dart';
import 'package:fennac_app/app/constants/app_enums.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/bloc/state/imagepicker_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:giphy_get/giphy_get.dart';
import 'package:permission_handler/permission_handler.dart';

class MediaItem {
  final String path;
  final MediaType type;
  final String id;

  MediaItem({required this.path, required this.type, required this.id});
}

enum MediaType { image, video }

class ImagePickerCubit extends Cubit<ImagePickerState> {
  static const int maxMediaItems = 6;

  ImagePickerCubit() : super(ImagePickerInitial());

  final ImagePicker _imagePicker = ImagePicker();
  final ImageCropper _imageCropper = ImageCropper();
  List<MediaItem> mediaList = [];
  File? selectedImage;

  /// Force square cropping for every image selection.
  Future<String?> cropImageWithRatio(
    String sourcePath,
    CropType cropType,
  ) async {
    try {
      final sourceFile = File(sourcePath);
      if (!await sourceFile.exists()) {
        debugPrint('Source file does not exist: $sourcePath');
        return null;
      }

      // Decide ratio dynamically
      CropAspectRatio aspectRatio;
      CropAspectRatioPreset preset;

      switch (cropType) {
        case CropType.square:
          aspectRatio = const CropAspectRatio(ratioX: 1, ratioY: 1);
          preset = CropAspectRatioPreset.square;
          break;

        case CropType.portrait:
          aspectRatio = const CropAspectRatio(ratioX: 9, ratioY: 16);
          preset = CropAspectRatioPreset.ratio16x9;
          break;
      }

      final croppedFile = await _imageCropper.cropImage(
        sourcePath: sourcePath,
        aspectRatio: aspectRatio,
        uiSettings: [
          AndroidUiSettings(
            backgroundColor: ColorPalette.secondary,
            toolbarColor: ColorPalette.secondary,
            toolbarTitle: 'Crop Image',
            lockAspectRatio: true,
            hideBottomControls: true,
            toolbarWidgetColor: Colors.white,
            statusBarLight: true,
            initAspectRatio: preset,
            aspectRatioPresets: [preset],
          ),
          IOSUiSettings(title: 'Crop Image', aspectRatioLockEnabled: true),
        ],
      );

      return croppedFile?.path;
    } catch (e) {
      debugPrint('Error while cropping image: $e');
      return null;
    }
  }

  /// Pick single image from gallery and add to specific index
  Future<void> pickImagesFromGallery({int? containerIndex}) async {
    final int remainingSlots = maxMediaItems - mediaList.length;
    containerIndex = remainingSlots > 1 ? null : containerIndex;
    log(
      'Container Index: $containerIndex, Remaining Slots: $remainingSlots mediaListLength: ${mediaList.length}',
    );

    if (containerIndex == null && remainingSlots <= 0) {
      emit(ImagePickerError('Maximum $maxMediaItems images allowed'));
      return;
    }

    emit(ImagePickerLoading());

    try {
      List<XFile> pickedFiles = [];

      if (containerIndex == null) {
        // multi picker
        final result = await _imagePicker.pickMultiImage(limit: remainingSlots);

        // ✅ enforce limit manually (IMPORTANT)
        pickedFiles = result.take(remainingSlots).toList();
      } else {
        // single picker
        final XFile? file = await _imagePicker.pickImage(
          source: ImageSource.gallery,
        );
        if (file != null) pickedFiles = [file];
      }

      if (pickedFiles.isEmpty) {
        emit(ImagePickerLoaded(mediaList: mediaList));
        return;
      }

      int currentIndex = containerIndex ?? mediaList.length;

      for (final file in pickedFiles) {
        // Show crop type selection dialog
        final cropType = await _showCropTypeSelectionDialog();
        final croppedPath = cropType != null
            ? (await cropImageWithRatio(file.path, cropType) ?? file.path)
            : file.path;

        final newItem = MediaItem(
          path: croppedPath,
          type: MediaType.image,
          id: DateTime.now().millisecondsSinceEpoch.toString(),
        );

        if (containerIndex != null) {
          if (containerIndex == -1) {
            selectedImage = File(newItem.path);
            break;
          }

          if (currentIndex < mediaList.length) {
            mediaList[currentIndex] = newItem;
          } else if (mediaList.length < maxMediaItems) {
            mediaList.add(newItem);
          }

          currentIndex++;
        } else {
          mediaList.add(newItem);
        }

        if (mediaList.length >= maxMediaItems) break;
      }

      // optional warning
      if (containerIndex == null && pickedFiles.length > remainingSlots) {
        emit(ImagePickerError('Only $remainingSlots images allowed'));
      }

      emit(ImagePickerLoaded(mediaList: mediaList));
    } catch (e) {
      debugPrint('Error picking images: $e');
      emit(ImagePickerError('Error picking images'));
    }
  }

  /// Pick video from gallery and add to specific index
  Future<void> pickVideoFromGallery({int? containerIndex}) async {
    if (mediaList.length >= maxMediaItems) {
      emit(ImagePickerError('Maximum $maxMediaItems media items allowed'));
      return;
    }

    emit(ImagePickerLoading());
    try {
      final XFile? pickedFile = await _imagePicker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(minutes: 5),
      );

      if (pickedFile != null) {
        final newItem = MediaItem(
          path: pickedFile.path,
          type: MediaType.video,
          id: DateTime.now().millisecondsSinceEpoch.toString(),
        );

        // Add to specific container if provided, otherwise append
        if (containerIndex != null &&
            containerIndex >= 0 &&
            containerIndex < maxMediaItems) {
          if (containerIndex < mediaList.length) {
            mediaList[containerIndex] = newItem;
          } else {
            mediaList.add(newItem);
          }
        } else {
          mediaList.add(newItem);
        }
        emit(ImagePickerLoaded(mediaList: mediaList));
      } else {
        emit(ImagePickerLoaded(mediaList: mediaList));
      }
    } catch (e) {
      emit(ImagePickerError('Error picking video: $e'));
      debugPrint('Error picking video from gallery: $e');
    }
  }

  /// Pick image from camera and add to specific index
  Future<void> pickImageFromCamera({int? containerIndex}) async {
    if (mediaList.length >= maxMediaItems) {
      emit(ImagePickerError('Maximum $maxMediaItems media items allowed'));
      return;
    }

    emit(ImagePickerLoading());

    try {
      // Just try to open camera - let image_picker request permission
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 80,
      );

      if (pickedFile == null) {
        emit(ImagePickerLoaded(mediaList: mediaList));
        return;
      }

      // Show crop type selection dialog
      final cropType = await _showCropTypeSelectionDialog();
      final croppedPath = cropType != null
          ? (await cropImageWithRatio(pickedFile.path, cropType) ??
                pickedFile.path)
          : pickedFile.path;

      final newItem = MediaItem(
        path: croppedPath,
        type: MediaType.image,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
      );

      // Insert into media list
      if (containerIndex != null &&
          containerIndex >= 0 &&
          containerIndex < maxMediaItems) {
        if (containerIndex < mediaList.length) {
          mediaList[containerIndex] = newItem;
        } else {
          mediaList.add(newItem);
        }
      } else {
        mediaList.add(newItem);
      }

      emit(ImagePickerLoaded(mediaList: mediaList));
    } on PlatformException catch (e) {
      debugPrint('Camera error: ${e.code} - ${e.message}');

      // Emit state FIRST
      emit(ImagePickerLoaded(mediaList: mediaList));

      // Handle permission denied - show dialog first
      if (e.code == 'camera_access_denied') {
        // Schedule dialog display for next microtask
        scheduleMicrotask(() {
          if (navigatorKey.currentContext != null) {
            _showPermissionDialog(navigatorKey.currentContext!);
          }
        });
      }
    } catch (e) {
      debugPrint('Camera error: $e');
      emit(ImagePickerLoaded(mediaList: mediaList));
    }
  }

  /// Show dialog for user to select crop type (square or portrait)
  Future<CropType?> _showCropTypeSelectionDialog() async {
    BuildContext? context = navigatorKey.currentContext;
    if (context == null) {
      return CropType.square; // Default to square if no context
    }

    return showDialog<CropType>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) => Dialog(
        backgroundColor: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              const Text(
                'Select Crop Format',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Choose how you want to crop your image',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 24),

              // Square Option
              _buildCropOptionTile(
                context: dialogContext,
                icon: Icons.crop_square_rounded,
                title: 'Square',
                subtitle: '1:1 Aspect Ratio',
                cropType: CropType.square,
              ),
              const SizedBox(height: 12),

              // Portrait Option
              _buildCropOptionTile(
                context: dialogContext,
                icon: Icons.crop_portrait_rounded,
                title: 'Portrait',
                subtitle: '9:16 Aspect Ratio',
                cropType: CropType.portrait,
              ),
              const SizedBox(height: 24),

              // Cancel Button
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build individual crop option tile
  Widget _buildCropOptionTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required CropType cropType,
  }) {
    return GestureDetector(
      onTap: () => Navigator.pop(context, cropType),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          border: Border.all(color: Colors.grey[200]!, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorPalette.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 32, color: ColorPalette.secondary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  /// Show minimal white dialog for camera permission
  void _showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) => Dialog(
        backgroundColor: Colors.white,
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Camera Permission',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Enable camera permission in Settings to use your camera.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                      openAppSettings();
                    },
                    child: const Text(
                      'Settings',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickImageFromGallery() async {
    emit(ImagePickerLoading());
    try {
      final List<XFile> pickedFiles = await _imagePicker.pickMultiImage(
        limit: 4,
      );

      List<MediaItem>? mediaItems = [];
      for (var file in pickedFiles) {
        MediaItem newItem = MediaItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          path: file.path,
          type: MediaType.image,
        );
        mediaItems.add(newItem);
      }

      emit(ImagePickerLoaded(mediaList: mediaItems));
    } catch (e) {
      emit(ImagePickerError('Error picking image from gallery: $e'));
      debugPrint('Error picking image from gallery: $e');
    }
  }

  /// Remove media item by ID or by index
  void removeMedia(String? id, {int? index}) {
    emit(ImagePickerLoading());
    if (id == 'header_image' || index == -1) {
      selectedImage = null;
    } else if (id != null) {
      mediaList.removeWhere((item) => item.id == id);
    } else if (index != null && index >= 0 && index < mediaList.length) {
      mediaList.removeAt(index);
    }
    emit(ImagePickerLoaded(mediaList: mediaList));
  }

  /// Reorder media items by dragging
  void reorderMedia(int oldIndex, int newIndex) {
    if (oldIndex < 0 ||
        oldIndex >= mediaList.length ||
        newIndex < 0 ||
        newIndex >= mediaList.length) {
      return;
    }

    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final item = mediaList.removeAt(oldIndex);
    mediaList.insert(newIndex, item);
    emit(ImagePickerLoaded(mediaList: mediaList));
  }

  /// Clear all media
  void clearAllMedia() {
    mediaList.clear();
    emit(ImagePickerLoaded(mediaList: mediaList));
  }

  /// Update media list and emit state (useful for external updates)
  void updateMediaList(List<MediaItem> newMediaList) {
    emit(ImagePickerLoading());
    mediaList = newMediaList;
    emit(ImagePickerLoaded(mediaList: mediaList));
  }

  /// Get current count of media
  int get mediaCount => mediaList.length;

  /// Check if max capacity reached
  bool get isMaxCapacityReached => mediaList.length >= maxMediaItems;

  /// Get remaining slots
  int get remainingSlots => maxMediaItems - mediaList.length;

  Future<void> pickMultipleImagesFromGallery() async {
    await pickImagesFromGallery();
  }

  /// Pick GIF from Giphy
  Future<void> pickGifFromGiphy(BuildContext context) async {
    if (mediaList.length >= maxMediaItems) {
      emit(ImagePickerError('Maximum $maxMediaItems media items allowed'));
      return;
    }

    emit(ImagePickerLoading());
    try {
      final GiphyGif? gif = await GiphyGet.getGif(
        context: context,
        apiKey:
            'MZgWWh3zy23GoQevUIGiWaGdWaAd9MKm', // Public beta key from giphy_get docs
      );

      if (gif != null && gif.images?.original?.url != null) {
        // Download the GIF to local storage
        final gifUrl = gif.images!.original!.url;

        // For now, we'll store the URL as the path
        // In production, you may want to download and cache the GIF locally
        final newItem = MediaItem(
          path: gifUrl,
          type: MediaType.image,
          id: DateTime.now().millisecondsSinceEpoch.toString(),
        );

        mediaList.add(newItem);
        emit(ImagePickerLoaded(mediaList: mediaList));
      } else {
        emit(ImagePickerLoaded(mediaList: mediaList));
      }
    } catch (e) {
      emit(ImagePickerError('Error picking GIF: $e'));
      debugPrint('Error picking GIF from Giphy: $e');
    }
  }
}
