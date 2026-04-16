import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../app/constants/media_query_constants.dart';
import '../app/theme/text_styles.dart';
import '../reusable_widgets/animated_background_container.dart';
import '../widgets/custom_elevated_button.dart';

Future<void> showDeleteDialog(
  BuildContext context, {
  required Function() onConfirm,
}) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => _DeleteDialog(onConfirm: onConfirm),
  );
}

class _DeleteDialog extends StatefulWidget {
  final Function() onConfirm;

  const _DeleteDialog({required this.onConfirm});

  @override
  State<_DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<_DeleteDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 6,
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
          decoration: BoxDecoration(
            gradient: isDarkTheme(context)
                ? LinearGradient(
                    colors: [ColorPalette.secondary, ColorPalette.black],

                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                : null,
            color: isLightTheme(context) ? Colors.white : null,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBackgroundContainer(icon: Assets.icons.trash.path),

              const SizedBox(height: 16),
              Text("Delete Account?", style: AppTextStyles.h2(context)),
              const SizedBox(height: 8),
              Text(
                "Once you submit your account is deleted permanently!!!",
                textAlign: TextAlign.center,
                style: AppTextStyles.body(context),
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      text: "Cancel",
                      backgroundColor: Colors.grey.shade400,
                      icon: const Icon(Icons.close, color: Colors.white),
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomElevatedButton(
                      text: "Delete",
                      backgroundColor: ColorPalette.primary,
                      icon: SvgPicture.asset(
                        Assets.icons.trash.path,
                        height: 20,
                        width: 20,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        widget.onConfirm();
                      },
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
}
