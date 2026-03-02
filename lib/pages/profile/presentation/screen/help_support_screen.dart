import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/pages/auth/presentation/widgets/privacy_bottom_sheet.dart';
import 'package:fennac_app/pages/auth/presentation/widgets/terms_bottom_sheet.dart';
import 'package:fennac_app/reusable_widgets/custom_app_bar.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import '../../../../app/constants/media_query_constants.dart';

class HelpItem {
  final String title;
  final String description;

  const HelpItem({required this.title, required this.description});
}

@RoutePage()
class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  late final ValueNotifier<bool> _isBlurNotifier;

  List<HelpItem> helpItems = [
    HelpItem(
      title: 'Frequently Asked Questions',
      description:
          'Browse answers to the most common questions about using Fennec.',
    ),
    HelpItem(
      title: 'Contact Support',
      description: 'Need direct help? Our team is ready to assist.',
    ),
    HelpItem(
      title: 'Report a Problem',
      description:
          'Found a bug or encountered an issue? Let us know so we can fix it quickly.',
    ),
    HelpItem(
      title: 'Terms of Service',
      description: 'Review our community rules and user agreement.',
    ),
    HelpItem(
      title: 'Privacy Policy',
      description: 'Learn how we collect, use, and protect your data.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _isBlurNotifier = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    _isBlurNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isBlurNotifier,
      builder: (context, isBlurred, child) {
        return Stack(
          children: [
            Scaffold(
              body: MovableBackground(
                backgroundType: MovableBackgroundType.dark,
                child: SafeArea(
                  child: Column(
                    children: [
                      CustomAppBar(title: 'Help & Support'),
                      CustomSizedBox(height: 20),
                      Expanded(
                        child: SingleChildScrollView(
                          child: ListView.builder(
                            itemCount: helpItems.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return _buildHelpTile(context, helpItems[index]);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (isBlurred)
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(color: Colors.black.withValues(alpha: 0.2)),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildHelpTile(BuildContext context, HelpItem item) {
    return InkWell(
      onTap: () {
        final title = item.title.toLowerCase();
        if (title == 'terms of service') {
          TermsBottomSheet.show(context, blurNotifier: _isBlurNotifier);
        } else if (title == 'privacy policy') {
          PrivacyBottomSheet.show(context, blurNotifier: _isBlurNotifier);
        } else if (title == 'contact support') {
          AutoRouter.of(context).push(const ContactSupportRoute());
        } else if (title == 'report a problem') {
          AutoRouter.of(context).push(const ReportProblemRoute());
        } else {
          AutoRouter.of(context).push(const FaqRoute());
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: ColorPalette.border.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: AppTextStyles.bodyLarge(
                      context,
                    ).copyWith(fontWeight: FontWeight.w500),
                  ),
                  const CustomSizedBox(height: 8),
                  Text(
                    item.description,
                    style: AppTextStyles.description(context).copyWith(
                      color: isLightTheme(context)
                          ? ColorPalette.black
                          : ColorPalette.textSecondary,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Icon(
                Icons.chevron_right,
                color: ColorPalette.white,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
