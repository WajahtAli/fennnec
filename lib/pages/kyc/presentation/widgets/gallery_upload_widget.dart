import 'dart:io';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/bloc/cubit/imagepicker_cubit.dart';
import 'package:fennac_app/bloc/state/imagepicker_state.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GalleryUploadWidget extends StatelessWidget {
  final int? containerIndex;

  const GalleryUploadWidget({super.key, this.containerIndex});

  @override
  Widget build(BuildContext context) {
    final cubit = Di().sl<ImagePickerCubit>();

    return BlocBuilder<ImagePickerCubit, ImagePickerState>(
      bloc: cubit,
      builder: (context, state) {
        final hasIndexedMedia =
            containerIndex != null &&
            containerIndex! >= 0 &&
            containerIndex! < cubit.mediaList.length &&
            cubit.mediaList[containerIndex!].path.isNotEmpty;

        final hasDefaultMedia =
            cubit.mediaList.isNotEmpty && cubit.mediaList[0].path.isNotEmpty;

        final hasMedia = containerIndex != null
            ? hasIndexedMedia
            : hasDefaultMedia;

        final mediaPath = hasMedia
            ? (containerIndex != null
                  ? cubit.mediaList[containerIndex!].path
                  : cubit.mediaList[0].path)
            : null;

        final mediaId = hasMedia
            ? (containerIndex != null
                  ? cubit.mediaList[containerIndex!].id
                  : cubit.mediaList[0].id)
            : null;

        return GestureDetector(
          onTap: () => _showImageSourceDialog(context, cubit),
          child: Container(
            width: 258,
            height: 260,
            decoration: BoxDecoration(
              color: isDarkTheme(context)
                  ? ColorPalette.secondary.withValues(alpha: 0.5)
                  : ColorPalette.textGrey,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: hasMedia
                  ? Stack(
                      children: [
                        Image.file(
                          File(mediaPath!),
                          width: double.infinity,
                          height: 260,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: SvgPicture.asset(
                                Assets.icons.camera.path,
                                colorFilter: ColorFilter.mode(
                                  isLightTheme(context)
                                      ? ColorPalette.black
                                      : ColorPalette.white,
                                  BlendMode.srcIn,
                                ),
                                fit: BoxFit.scaleDown,
                              ),
                            );
                          },
                        ),
                        Positioned(
                          top: 6,
                          right: 6,
                          child: GestureDetector(
                            onTap: () {
                              if (containerIndex != null) {
                                cubit.removeMedia(null, index: containerIndex);
                              } else {
                                cubit.removeMedia(mediaId!);
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorPalette.error,
                              ),
                              child: SvgPicture.asset(
                                Assets.icons.trash.path,
                                colorFilter: ColorFilter.mode(
                                  isLightTheme(context)
                                      ? ColorPalette.black
                                      : ColorPalette.white,
                                  BlendMode.srcIn,
                                ),
                                width: 10,
                                height: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: SvgPicture.asset(
                        Assets.icons.camera.path,
                        colorFilter: ColorFilter.mode(
                          isLightTheme(context)
                              ? ColorPalette.black
                              : ColorPalette.white,
                          BlendMode.srcIn,
                        ),
                        fit: BoxFit.scaleDown,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }

  void _showImageSourceDialog(BuildContext context, ImagePickerCubit cubit) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          gradient: isLightTheme(context)
              ? null
              : LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [ColorPalette.secondary, ColorPalette.black],
                ),
          color: isLightTheme(context) ? Colors.white : null,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isLightTheme(context)
                      ? Colors.black.withValues(alpha: 0.2)
                      : Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                  color: isLightTheme(context) ? Colors.black : Colors.white,
                ),
                title: Text(
                  'Choose from Gallery',
                  style: TextStyle(
                    color: isLightTheme(context) ? Colors.black : Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  cubit.pickImagesFromGallery(
                    containerIndex: containerIndex ?? -1,
                    context: context,
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.camera_alt,
                  color: isLightTheme(context) ? Colors.black : Colors.white,
                ),
                title: Text(
                  'Take Photo',
                  style: TextStyle(
                    color: isLightTheme(context) ? Colors.black : Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  cubit.pickImageFromCamera(containerIndex: containerIndex);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
