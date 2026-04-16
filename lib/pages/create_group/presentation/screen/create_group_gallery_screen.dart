import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/bloc/cubit/imagepicker_cubit.dart';
import 'package:fennac_app/bloc/state/imagepicker_state.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/create_account_cubit.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/cubit/create_group_cubit.dart';
import 'package:fennac_app/pages/my_group/presentation/bloc/cubit/my_group_cubit.dart';
import 'package:fennac_app/reusable_widgets/custom_app_bar.dart';
import 'package:fennac_app/reusable_widgets/gallery_grid_widget.dart';
import 'package:fennac_app/reusable_widgets/media_picker_options.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

import '../bloc/state/create_group_state.dart';

@RoutePage()
class CreateGroupGalleryScreen extends StatefulWidget {
  final bool isEditMode;
  const CreateGroupGalleryScreen({super.key, this.isEditMode = false});

  @override
  State<CreateGroupGalleryScreen> createState() =>
      _CreateGroupGalleryScreenState();
}

class _CreateGroupGalleryScreenState extends State<CreateGroupGalleryScreen> {
  final MyGroupCubit _myGroupCubit = Di().sl<MyGroupCubit>();
  final CreateAccountCubit _createAccountCubit = Di().sl<CreateAccountCubit>();
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    if (widget.isEditMode == true) {
      _prefillFromGroupData();
    }
  }

  void _setCoverMediaIndex(int index) {
    final mediaList = imagePickerCubit.mediaList;
    if (index < 0 || index >= mediaList.length) {
      return;
    }

    if (index == 0) {
      if (mounted) {
        setState(() {
          _selectedIndex = 0;
        });
      }
      return;
    }

    final newList = List<MediaItem>.from(mediaList);
    final temp = newList[0];
    newList[0] = newList[index];
    newList[index] = temp;
    imagePickerCubit.updateMediaList(newList);
    createGroupCubit.photosVideos = newList.map((item) => item.path).toList();
    _createAccountCubit.mediaLinks = List<String>.from(
      createGroupCubit.photosVideos,
    );

    if (mounted) {
      setState(() {
        _selectedIndex = 0;
      });
    }
  }

  void _prefillFromGroupData() {
    final existing = _myGroupCubit.myGroupModel?.data?.photosVideos ?? [];
    if (existing.isEmpty) return;

    final prefilled = existing
        .take(ImagePickerCubit().maxMediaItems)
        .toList(growable: false)
        .asMap()
        .entries
        .map(
          (entry) => MediaItem(
            path: entry.value,
            type: _isVideo(entry.value) ? MediaType.video : MediaType.image,
            id: 'existing_${entry.key}_${entry.value.hashCode}',
          ),
        )
        .toList();

    imagePickerCubit.updateMediaList(prefilled);
    createGroupCubit.photosVideos = List<String>.from(existing);
    _createAccountCubit.mediaLinks = List<String>.from(existing);
    if (mounted) {
      setState(() {
        _selectedIndex = prefilled.isNotEmpty ? 0 : null;
      });
    }
  }

  bool _isVideo(String path) {
    final lower = path.toLowerCase();
    return lower.endsWith('.mp4') ||
        lower.endsWith('.mov') ||
        lower.endsWith('.m4v') ||
        lower.endsWith('.avi');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MovableBackground(
        child: BlocBuilder<ImagePickerCubit, ImagePickerState>(
          bloc: imagePickerCubit,
          builder: (context, state) {
            final mediaList = state.mediaList ?? [];

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSizedBox(height: 16),
                    CustomAppBar(
                      title: widget.isEditMode
                          ? 'Edit Group Details'
                          : 'Create a Group',
                    ),
                    CustomSizedBox(height: 16),

                    // Gallery Grid Layout
                    GalleryGridWidget(
                      mediaList: mediaList,
                      onShowMediaPicker: (context, {containerIndex}) {
                        MediaPickerOptions.show(
                          context,
                          containerIndex: containerIndex,
                        );
                      },
                      hasHeader: true,
                      headerMedia: mediaList.isNotEmpty
                          ? mediaList.first
                          : null,
                      isEditMode: true,
                      selectedIndex: _selectedIndex,
                      onMediaTap: (index) {
                        _setCoverMediaIndex(index);
                      },
                    ),

                    CustomSizedBox(height: 40),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BlocBuilder(
        bloc: createGroupCubit,
        builder: (context, state) {
          bool isLoading = state is CreateGroupLoading;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            child: CustomElevatedButton(
              icon: isLoading
                  ? SizedBox(
                      width: 16,
                      height: 16,
                      child: Lottie.asset(Assets.animations.loadingSpinner),
                    )
                  : null,
              text: isLoading
                  ? ''
                  : (widget.isEditMode ? 'Update' : 'Create Prompts'),
              onTap: () async {
                if (widget.isEditMode) {
                  await uploadAllMedia();
                  await createGroupCubit.updateGroupWithChangedFields(
                    groupId: _myGroupCubit.myGroupModel?.data?.id ?? '',
                  );
                  // // Clear media after successful update
                  // if (mounted) {
                  //   imagePickerCubit.updateMediaList([]);
                  // }
                } else {
                  await createGroupCubit.createGroup(context: context);
                  // Clear media after successful creation
                  if (mounted) {
                    imagePickerCubit.updateMediaList([]);
                  }
                }
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> uploadAllMedia() async {
    if (imagePickerCubit.mediaList.isEmpty) {
      return;
    }

    for (var item in imagePickerCubit.mediaList) {
      if (!item.path.startsWith('http://') &&
          !item.path.startsWith('https://')) {
        await _uploadMedia(item.path);
      }
    }
  }

  Future<void> _uploadMedia(String filePath) async {
    try {
      await _createAccountCubit.uploadMedia(filePath: filePath);

      // After successful upload, update the media item path to the uploaded URL
      final uploadedUrl = _createAccountCubit.mediaLinks.last;
      final currentList = imagePickerCubit.mediaList;
      final index = currentList.indexWhere((item) => item.path == filePath);

      if (index != -1) {
        final updatedList = List<MediaItem>.from(currentList);
        updatedList[index] = MediaItem(
          path: uploadedUrl,
          type: currentList[index].type,
          id: currentList[index].id,
        );
        imagePickerCubit.updateMediaList(updatedList);
      }
    } catch (e) {
      if (mounted) {
        Fluttertoast.showToast(
          msg: 'Failed to upload media: $e',
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    }
  }
}

final imagePickerCubit = Di().sl<ImagePickerCubit>();
final createGroupCubit = Di().sl<CreateGroupCubit>();
