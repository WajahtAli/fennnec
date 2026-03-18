import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/helpers/qr_helper.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';

class ShareQrBottomSheet extends StatelessWidget {
  final String qrData;

  const ShareQrBottomSheet({super.key, required this.qrData});

  static Future<void> show({
    required BuildContext context,
    required String qrData,
    Color? barrierColor,
    bool isScrollControlled = true,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: barrierColor,
      isScrollControlled: isScrollControlled,
      builder: (context) => ShareQrBottomSheet(qrData: qrData),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight(context) * 0.55,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: isLightTheme(context)
            ? null
            : const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF16003F), Color(0xFF111111)],
              ),
        color: isLightTheme(context) ? Colors.white : null,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      padding: const EdgeInsets.only(top: 24, right: 24, bottom: 48, left: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 370,
            child: Text(
              'Share this QR Code with your friends',
              style: AppTextStyles.h3(context).copyWith(
                color: isLightTheme(context) ? Colors.black : Colors.white,
              ),
            ),
          ),
          const CustomSizedBox(height: 32),
          Container(
            width: 272,
            height: 272,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: ColorPalette.primary,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: ColorPalette.white, width: 4),
              boxShadow: isDarkTheme(context)
                  ? [
                      BoxShadow(
                        color: ColorPalette.primary,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                        spreadRadius: 3,
                      ),
                    ]
                  : null,
            ),
            child: QrHelper(data: qrData),
          ),
          const CustomSizedBox(height: 32),
          CustomElevatedButton(
            text: 'Done',
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
