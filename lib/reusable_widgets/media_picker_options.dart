import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/bloc/cubit/imagepicker_cubit.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MediaPickerOptions extends StatelessWidget {
  final int? containerIndex;

  const MediaPickerOptions({super.key, this.containerIndex});

  static void show(BuildContext context, {int? containerIndex}) {
    if (_imagePickerCubit.isMaxCapacityReached) {
      Fluttertoast.showToast(
        msg: 'Maximum 6 media items allowed',
        backgroundColor: Colors.orange,
        textColor: Colors.white,
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      builder: (context) {
        return MediaPickerOptions(containerIndex: containerIndex);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLight = isLightTheme(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24 + 16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        gradient: isLight
            ? null
            : LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [ColorPalette.secondary, ColorPalette.black],
              ),
        color: isLight ? Colors.white : null,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: isLight
                      ? Colors.black.withValues(alpha: 0.2)
                      : Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Add Media',
                style: AppTextStyles.h1(context).copyWith(
                  color: isLight ? Colors.black : Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Divider(
              color: isLight
                  ? Colors.black.withValues(alpha: 0.08)
                  : Colors.white.withValues(alpha: 0.08),
              height: 1,
            ),
            _buildMediaOption(
              context,
              label: 'Pick Photo from Gallery',
              icon: Assets.icons.gallery.path,
              isLight: isLight,
              onTap: () {
                Navigator.pop(context);
                _imagePickerCubit.pickImagesFromGallery(
                  containerIndex: containerIndex,
                );
              },
            ),
            Divider(
              color: isLight
                  ? Colors.black.withValues(alpha: 0.08)
                  : Colors.white.withValues(alpha: 0.08),
              height: 1,
            ),
            _buildMediaOption(
              context,
              label: 'Pick Video from Gallery',
              icon: Assets.icons.video.path,
              isLight: isLight,
              onTap: () {
                Navigator.pop(context);
                _imagePickerCubit.pickVideoFromGallery(
                  containerIndex: containerIndex,
                );
              },
            ),
            Divider(
              color: isLight
                  ? Colors.black.withValues(alpha: 0.08)
                  : Colors.white.withValues(alpha: 0.08),
              height: 1,
            ),
            _buildMediaOption(
              context,
              label: 'Take a Photo with Camera',
              icon: Assets.icons.camera.path,
              isLight: isLight,
              onTap: () {
                Navigator.pop(context);
                _imagePickerCubit.pickImageFromCamera(
                  containerIndex: containerIndex,
                );
              },
            ),
            Divider(
              color: isLight
                  ? Colors.black.withValues(alpha: 0.08)
                  : Colors.white.withValues(alpha: 0.08),
              height: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaOption(
    BuildContext context, {
    required String label,
    required String icon,
    required bool isLight,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: isLight ? Colors.black : Colors.white,
              height: 22,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.body(
                  context,
                ).copyWith(color: isLight ? Colors.black : Colors.white),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: isLight ? Colors.black : Colors.white,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

final _imagePickerCubit = Di().sl<ImagePickerCubit>();
