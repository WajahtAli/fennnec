import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/cubit/message_cubit.dart';
import 'package:flutter/material.dart';
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
    final options = <_AttachmentOption>[
      _AttachmentOption(
        icon: Icons.photo_outlined,
        label: 'Photos',
        type: 'image',
      ),
      _AttachmentOption(
        icon: Icons.videocam_outlined,
        label: 'Videos',
        type: 'video',
      ),
      _AttachmentOption(
        icon: Icons.camera_alt_outlined,
        label: 'Camera',
        type: 'image',
      ),
      _AttachmentOption(icon: Icons.gif, label: 'GIFs', type: 'image'),
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorPalette.secondary.withValues(alpha: 0.25),
            ColorPalette.secondary.withValues(alpha: 0.9),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border.all(
          color: ColorPalette.white.withValues(alpha: 0.06),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: options.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.3,
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
    required this.icon,
    required this.label,
    required this.type,
  });

  final IconData icon;
  final String label;
  final String type;
}

class _AttachmentTile extends StatelessWidget {
  const _AttachmentTile({required this.option});

  final _AttachmentOption option;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isLightTheme(context)
            ? ColorPalette.textGrey.withValues(alpha: 0.3)
            : ColorPalette.primary.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ColorPalette.white.withValues(alpha: 0.06),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: ColorPalette.white.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              option.icon,
              color: isLightTheme(context)
                  ? ColorPalette.black
                  : ColorPalette.white,
              size: 26,
            ),
          ),
          const CustomSizedBox(height: 12),
          Text(
            option.label,
            style: AppTextStyles.body(context).copyWith(
              fontWeight: FontWeight.w600,
              color: isLightTheme(context)
                  ? ColorPalette.black
                  : ColorPalette.white,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
