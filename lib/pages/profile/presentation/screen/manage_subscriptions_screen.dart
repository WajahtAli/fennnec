import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/app_emojis.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/reusable_widgets/custom_app_bar.dart';
import 'package:fennac_app/widgets/custom_outlined_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

@RoutePage()
class ManageSubscriptionsScreen extends StatelessWidget {
  const ManageSubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MovableBackground(
        backgroundType: MovableBackgroundType.dark,
        child: SafeArea(
          child: Column(
            children: [
              CustomAppBar(title: 'Manage Subscription', allowSpace: true),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      _buildPremiumCard(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumCard(BuildContext context) {
    return CustomPaint(
      painter: _GradientBorderPainter(
        radius: 24,
        strokeWidth: 2,
        gradient: LinearGradient(
          colors: [ColorPalette.primary, ColorPalette.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDarkTheme(context)
              ? ColorPalette.black.withValues(alpha: 0.4)
              : ColorPalette.textGrey,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title with gradient
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        colors: [
                          const Color(0xFFC2932A),
                          const Color(0xFFF2E0A0),
                          const Color(0xFFEEDC9C),
                          const Color(0xFFCAA44F),
                          const Color(0xFFAD7A29),
                        ],
                        stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        // transform: GradientRotation(275.33 * math.pi / 180),
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcIn,
                    child: Text(
                      'Fennec Premium',
                      style: AppTextStyles.h3(
                        context,
                      ).copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SvgPicture.asset(
                  Assets.icons.diamondStone.path,
                  width: 24,
                  height: 24,
                ),
              ],
            ),
            const CustomSizedBox(height: 12),

            // Description
            Text(
              'Fennec Premium lets you join multiple groups, start one-on-one chats, enjoy longer calls, and reach more amazing people around you.',
              style: AppTextStyles.description(context).copyWith(
                fontSize: 13,
                height: 1.5,
                color: isDarkTheme(context)
                    ? ColorPalette.textSecondary
                    : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const CustomSizedBox(height: 20),

            // Features list
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isLightTheme(context)
                    ? ColorPalette.white
                    : ColorPalette.primary.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildFeatureItem(
                    AppEmojis.checkMark,
                    'Join multiple groups',
                    context,
                  ),
                  const CustomSizedBox(height: 12),
                  _buildFeatureItem(
                    AppEmojis.speechBalloon,
                    'Start individual chats',
                    context,
                  ),
                  const CustomSizedBox(height: 12),
                  _buildFeatureItem(
                    AppEmojis.telephone,
                    'Unlimited voice & video calls',
                    context,
                  ),
                  const CustomSizedBox(height: 12),
                  _buildFeatureItem(
                    AppEmojis.sparklingHeart,
                    'See who liked your group',
                    context,
                  ),
                  const CustomSizedBox(height: 12),
                  _buildFeatureItem(
                    AppEmojis.lightning,
                    'Unlimited daily swipes',
                    context,
                  ),
                  const CustomSizedBox(height: 12),
                  _buildFeatureItem(
                    AppEmojis.wrappedGift,
                    'Access premium prompts',
                    context,
                    isLast: true,
                  ),
                ],
              ),
            ),
            const CustomSizedBox(height: 24),

            // Details section
            _buildDetailRow('Price', '\$9.99 / month', context),
            const SizedBox(height: 16),
            _buildDetailRow('Plan Type', 'Premium Monthly', context),
            const SizedBox(height: 16),
            _buildDetailRow('Premium User Since', 'October 25, 2024', context),
            const SizedBox(height: 16),
            _buildDetailRow('Next Billing Date', 'November 25, 2025', context),
            const SizedBox(height: 32),

            // Cancel Subscription button
            CustomOutlinedButton(
              text: 'Cancel Subscription',
              onPressed: () {
                VxToast.show(message: 'Coming Soon!');
              },
              borderColor: isLightTheme(context)
                  ? ColorPalette.secondary
                  : ColorPalette.textPrimary,
              textColor: isLightTheme(context)
                  ? ColorPalette.secondary
                  : ColorPalette.textPrimary,
              borderRadius: 52,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
    String emoji,
    String text,
    BuildContext context, {
    bool isLast = false,
  }) {
    return Row(
      children: [
        Text(emoji, style: AppTextStyles.chipLabel(context)),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: AppTextStyles.chipLabel(context))),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.chipLabel(context)),
        Text(value, style: AppTextStyles.inputLabel(context)),
      ],
    );
  }
}

// ------------------- Gradient Border Painter -------------------
class _GradientBorderPainter extends CustomPainter {
  final double strokeWidth;
  final double radius;
  final Gradient gradient;

  _GradientBorderPainter({
    required this.strokeWidth,
    required this.radius,
    required this.gradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;

    final RRect rrect = RRect.fromRectAndRadius(
      rect.deflate(strokeWidth / 2),
      Radius.circular(radius),
    );

    final Paint paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
