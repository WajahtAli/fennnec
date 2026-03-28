import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/cubit/message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fennac_app/widgets/app_inkwell.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../bloc/cubit/imagepicker_cubit.dart';
import '../../../../core/di_container.dart';
import '../../../../widgets/custom_sized_box.dart';

class AttachmentWidget extends StatelessWidget {
  const AttachmentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _AttachmentPanelBelow();
  }
}

class _AttachmentPanelBelow extends StatelessWidget {
  const _AttachmentPanelBelow();

  @override
  Widget build(BuildContext context) {
    final isLight = isLightTheme(context);
    final options = <_AttachmentOption>[
      _AttachmentOption(
        iconPath: Assets.icons.gallery.path,
        label: 'Photos',
        type: 'image',
      ),
      _AttachmentOption(
        iconPath: Assets.icons.video.path,
        label: 'Videos',
        type: 'video',
      ),
      _AttachmentOption(
        iconPath: Assets.icons.camera.path,
        label: 'Camera',
        type: 'image',
      ),
      _AttachmentOption(
        iconPath: Assets.icons.gif.path,
        label: 'GIFs',
        type: 'image',
      ),
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isLight ? Colors.white : null,
        gradient: isLight
            ? null
            : LinearGradient(
                colors: [
                  ColorPalette.secondary.withValues(alpha: 0.25),
                  ColorPalette.secondary.withValues(alpha: 0.9),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
        border: Border(
          top: BorderSide(
            color: isLight
                ? ColorPalette.lightDivider
                : ColorPalette.white.withValues(alpha: 0.06),
            width: 1,
          ),
        ),
      ),
      padding: EdgeInsets.fromLTRB(24, 0, 24, isLight ? 64 : 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: options.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 32,
          mainAxisExtent: 108,
        ),
        itemBuilder: (context, index) {
          final option = options[index];
          return AppInkWell(
            onTap: () {
              final picker = Di().sl<ImagePickerCubit>();
              Di().sl<MessageCubit>().toggleAttachmentPanel(close: true);
              if (option.label == 'Photos') {
                picker.pickImageFromGallery();
              } else if (option.type == 'video') {
                picker.pickVideoFromGallery();
              } else if (option.label == 'Camera') {
                picker.pickImageFromCamera();
              } else if (option.label == 'GIFs') {
                picker.pickGifFromGiphy(context);
              }
            },
            child: _AttachmentTile(option: option),
          );
        },
      ),
    );
  }
}

class _AttachmentOption {
  const _AttachmentOption({
    required this.iconPath,
    required this.label,
    required this.type,
  });

  final String iconPath;
  final String label;
  final String type;
}

class _AttachmentTile extends StatelessWidget {
  const _AttachmentTile({required this.option});

  final _AttachmentOption option;

  @override
  Widget build(BuildContext context) {
    final isLight = isLightTheme(context);
    return Container(
      decoration: BoxDecoration(
        color: isLight
            ? ColorPalette.lightSurface
            : ColorPalette.primary.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isLight
              ? ColorPalette.lightBorder
              : ColorPalette.white.withValues(alpha: 0.06),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            option.iconPath,
            width: 36,
            height: 36,
            colorFilter: ColorFilter.mode(
              isLight ? ColorPalette.black : ColorPalette.white,
              BlendMode.srcIn,
            ),
          ),
          const CustomSizedBox(height: 12),
          Text(
            option.label,
            style: AppTextStyles.body(context).copyWith(
              fontWeight: FontWeight.w500,
              color: isLight ? ColorPalette.black : ColorPalette.white,
            ),
          ),
        ],
      ),
    );
  }
}
