import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:fennac_app/app/app.dart';
import 'package:fennac_app/bloc/state/imagepicker_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
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
  List<MediaItem> mediaList = [];
  File? selectedImage;

  List<MediaItem> _snapshotMediaList([List<MediaItem>? source]) {
    return List<MediaItem>.unmodifiable(
      List<MediaItem>.from(source ?? mediaList),
    );
  }

  void _emitLoading() {
    emit(ImagePickerLoading(mediaList: _snapshotMediaList()));
  }

  void _emitLoaded([List<MediaItem>? source]) {
    final snapshot = _snapshotMediaList(source);
    mediaList = List<MediaItem>.from(snapshot);
    emit(ImagePickerLoaded(mediaList: snapshot));
  }

  void _emitError(String message) {
    emit(ImagePickerError(message, mediaList: _snapshotMediaList()));
  }

  Future<void> pickImagesFromGallery({
    required BuildContext context,
    int? containerIndex,
  }) async {
    final int remainingSlots = maxMediaItems - mediaList.length;
    containerIndex = remainingSlots > 1 ? null : containerIndex;

    log(
      'Container Index: $containerIndex, Remaining Slots: $remainingSlots mediaListLength: ${mediaList.length}',
    );

    if (containerIndex == null && remainingSlots <= 0) {
      _emitError('Maximum $maxMediaItems images allowed');
      return;
    }

    _emitLoading();

    try {
      List<MediaItem> pickedItems = [];

      // Pre-request permission so AssetPicker receives an already-resolved
      // state — avoids the first-grant exception on iOS/Android.
      final permissionState = await PhotoManager.requestPermissionExtend();
      if (!permissionState.hasAccess) {
        _emitLoaded();
        return;
      }

      final List<AssetEntity>? assets = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          requestType: RequestType.image,
          maxAssets: containerIndex == null ? remainingSlots : 1,
        ),
      );

      if (assets != null && assets.isNotEmpty) {
        final allowedAssets = assets.take(
          containerIndex == null ? remainingSlots : 1,
        );

        for (final asset in allowedAssets) {
          final file = await asset.file;
          if (file == null) continue;

          pickedItems.add(
            MediaItem(
              path: file.path,
              type: MediaType.image,
              id: DateTime.now().millisecondsSinceEpoch.toString(),
            ),
          );
        }
      }

      if (pickedItems.isEmpty) {
        _emitLoaded();
        return;
      }

      int currentIndex = containerIndex ?? mediaList.length;

      for (final newItem in pickedItems) {
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
          if (mediaList.length < maxMediaItems) {
            mediaList.add(newItem);
          }
        }

        if (mediaList.length >= maxMediaItems) break;
      }

      _emitLoaded();
    } catch (e) {
      debugPrint('Error picking images: $e');
      _emitError('Error picking images');
    }
  }

  /// Pick video from gallery and add to specific index
  Future<void> pickVideoFromGallery({int? containerIndex}) async {
    if (mediaList.length >= maxMediaItems) {
      _emitError('Maximum $maxMediaItems media items allowed');
      return;
    }

    _emitLoading();
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
        _emitLoaded();
      } else {
        _emitLoaded();
      }
    } catch (e) {
      _emitError('Error picking video: $e');
      debugPrint('Error picking video from gallery: $e');
    }
  }

  /// Pick image from camera and add to specific index
  Future<void> pickImageFromCamera({int? containerIndex}) async {
    if (mediaList.length >= maxMediaItems) {
      _emitError('Maximum $maxMediaItems media items allowed');
      return;
    }

    _emitLoading();

    try {
      // Just try to open camera - let image_picker request permission
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 80,
      );

      if (pickedFile == null) {
        _emitLoaded();
        return;
      }

      final croppedPath = pickedFile.path;

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

      _emitLoaded();
    } on PlatformException catch (e) {
      debugPrint('Camera error: ${e.code} - ${e.message}');

      // Emit state first so the existing grid stays visible on failures.
      _emitLoaded();

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
      _emitLoaded();
    }
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
    _emitLoading();
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

      _emitLoaded(mediaItems);
    } catch (e) {
      _emitError('Error picking image from gallery: $e');
      debugPrint('Error picking image from gallery: $e');
    }
  }

  /// Remove media item by ID or by index
  void removeMedia(String? id, {int? index}) {
    _emitLoading();
    if (id == 'header_image' || index == -1) {
      selectedImage = null;
    } else if (id != null) {
      mediaList.removeWhere((item) => item.id == id);
    } else if (index != null && index >= 0 && index < mediaList.length) {
      mediaList.removeAt(index);
    }
    _emitLoaded();
  }

  /// Reorder media items by dragging
  void reorderMedia(int oldIndex, int newIndex) {
    if (oldIndex < 0 || oldIndex >= mediaList.length) {
      return;
    }

    // Cap newIndex to the bounds of the current list
    if (newIndex >= mediaList.length) {
      newIndex = mediaList.length - 1;
    }
    if (newIndex < 0) {
      newIndex = 0;
    }

    if (oldIndex == newIndex) return;

    final updatedMediaList = List<MediaItem>.from(mediaList);
    final item = updatedMediaList.removeAt(oldIndex);
    updatedMediaList.insert(newIndex, item);
    _emitLoaded(updatedMediaList);
  }

  /// Clear all media
  void clearAllMedia() {
    mediaList.clear();
    _emitLoaded();
  }

  /// Update media list and emit state (useful for external updates)
  void updateMediaList(List<MediaItem> newMediaList) {
    _emitLoading();
    _emitLoaded(newMediaList);
  }

  /// Get current count of media
  int get mediaCount => mediaList.length;

  /// Check if max capacity reached
  bool get isMaxCapacityReached => mediaList.length >= maxMediaItems;

  /// Get remaining slots
  int get remainingSlots => maxMediaItems - mediaList.length;

  Future<void> pickMultipleImagesFromGallery({
    required BuildContext context,
  }) async {
    await pickImagesFromGallery(context: context);
  }

  /// Pick GIF from Giphy
  Future<void> pickGifFromGiphy(BuildContext context) async {
    if (mediaList.length >= maxMediaItems) {
      _emitError('Maximum $maxMediaItems media items allowed');
      return;
    }

    _emitLoading();
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
        _emitLoaded();
      } else {
        _emitLoaded();
      }
    } catch (e) {
      _emitError('Error picking GIF: $e');
      debugPrint('Error picking GIF from Giphy: $e');
    }
  }
}
