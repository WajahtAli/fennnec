import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/app_enums.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/app_emojis.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/cubit/chat_landing_cubit.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/state/chat_landing_state.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class PremiumCard extends StatelessWidget {
  final bool? isGradientTitle;
  const PremiumCard({super.key, this.isGradientTitle = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatLandingCubit, ChatLandingState>(
      bloc: Di().sl<ChatLandingCubit>(),
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: CustomPaint(
            painter: _GradientBorderPainter(
              radius: 24,
              strokeWidth: 2,
              gradient: LinearGradient(
                colors: [ColorPalette.primary, ColorPalette.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Container(
                // height: isGradientTitle == true ? 560 : 530,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: isLightTheme(context)
                      ? ColorPalette.textGrey
                      : ColorPalette.black.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    if (isGradientTitle == true) ...[
                      Column(
                        children: [
                          ShaderMask(
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
                                // transform: GradientRotation(
                                //   275.33 * math.pi / 180,
                                // ),
                              ).createShader(bounds);
                            },
                            blendMode: BlendMode.srcIn,
                            child: Text(
                              'Unlock the Full Fennec\nExperience',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.h3(context).copyWith(
                                color: Colors.white,
                                fontSize: getWidth(context) > 370 ? 24 : 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const CustomSizedBox(height: 10),
                          SvgPicture.asset(
                            Assets.icons.diamondStone.path,
                            width: getWidth(context) > 370 ? 24 : 20,
                            height: getWidth(context) > 370 ? 24 : 20,
                          ),
                        ],
                      ),
                    ] else
                      Text(
                        'Unlock the Full Fennec\nExperience',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.h3(
                          context,
                        ).copyWith(fontWeight: FontWeight.w600),
                      ),
                    const CustomSizedBox(height: 14),
                    Text(
                      'Fennec Premium lets you join multiple groups, start one-on-one chats, enjoy longer calls, and reach more amazing groups around you.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.description(context),
                    ),
                    const CustomSizedBox(height: 20),
                    Container(
                      // height: 244,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isLightTheme(context)
                            ? Colors.white
                            : ColorPalette.primary.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFeatureItem(
                            AppEmojis.checkMark,
                            'Join multiple groups',
                            context,
                          ),
                          const CustomSizedBox(height: 8),
                          _buildFeatureItem(
                            AppEmojis.speechBalloon,
                            'Start individual chats',
                            context,
                          ),
                          const CustomSizedBox(height: 8),
                          _buildFeatureItem(
                            AppEmojis.telephone,
                            'Unlimited voice & video calls',
                            context,
                          ),
                          const CustomSizedBox(height: 8),
                          _buildFeatureItem(
                            AppEmojis.sparklingHeart,
                            'See who liked your group',
                            context,
                          ),
                          const CustomSizedBox(height: 8),
                          _buildFeatureItem(
                            AppEmojis.lightning,
                            'Unlimited daily swipes',
                            context,
                          ),
                          const CustomSizedBox(height: 8),
                          _buildFeatureItem(
                            AppEmojis.wrappedGift,
                            'Access premium prompts',
                            context,
                          ),
                        ],
                      ),
                    ),
                    const CustomSizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$9.99',
                          style: AppTextStyles.h2(context).copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: getWidth(context) > 370 ? 32 : 24,
                          ),
                        ),
                        Text(
                          '/month',
                          style: AppTextStyles.subHeading(context),
                        ),
                      ],
                    ),
                    const CustomSizedBox(height: 20),
                    CustomElevatedButton(
                      text: 'Upgrade to Premium',
                      onTap: () {
                        if (isGradientTitle == true) {
                          // VxToast.show(message: 'Coming Soon!');
                          AutoRouter.of(context).push(const MyGroupRoute());
                        } else {
                          Di().sl<ChatLandingCubit>().updateSubscriptionStatus(
                            SubscriptionStatus.subscribed,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeatureItem(String emoji, String text, BuildContext context) {
    return Row(
      children: [
        Text(emoji, style: AppTextStyles.chipLabel(context)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.chipLabel(
              context,
            ).copyWith(fontSize: getWidth(context) > 370 ? 16 : 14),
          ),
        ),
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
