import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../reusable_widgets/custom_app_bar.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/movable_background.dart';

@RoutePage()
class CreateGroupLocationScreen extends StatefulWidget {
  const CreateGroupLocationScreen({super.key});

  @override
  State<CreateGroupLocationScreen> createState() =>
      _CreateGroupLocationScreenState();
}

class _CreateGroupLocationScreenState extends State<CreateGroupLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorPalette.secondary,
      body: MovableBackground(
        backgroundType: MovableBackgroundType.dark,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                title: 'Create a Group',
                titleStyle: AppTextStyles.h4(
                  context,
                ).copyWith(letterSpacing: 0.2, fontWeight: FontWeight.bold),
              ),
              Center(
                child: SizedBox(
                  width: 340,
                  child: AppText(
                    text:
                        "Selecting a location for your group can help you find and connect with nearby members, this helps other users were yo're located",
                    style: AppTextStyles.body(context).copyWith(
                      color: isLightTheme(context)
                          ? ColorPalette.black
                          : ColorPalette.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
