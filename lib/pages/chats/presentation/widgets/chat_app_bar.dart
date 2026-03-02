import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/dummy_constants.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/reusable_widgets/circle_icon_button.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/widgets/custom_back_button.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatAppBar extends StatelessWidget {
  final bool isGroup;
  final String? contactName;
  final String? contactAvatar;
  final bool isOnline;

  const ChatAppBar({
    super.key,
    required this.isGroup,
    this.contactName,
    this.contactAvatar,
    this.isOnline = false,
  });

  @override
  Widget build(BuildContext context) {
    return isGroup
        ? _buildGroupHeader(context)
        : _buildIndividualHeader(context);
  }

  Widget _buildGroupHeader(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return ClipRRect(
      borderRadius: BorderRadius.zero,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 40,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(color: Colors.transparent),
            ),
          ),

          // Positioned(
          //   top: 40,
          //   left: 0,
          //   right: 0,
          //   height: 0,
          //   child: BackdropFilter(
          //     filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          //     child: Container(color: Colors.transparent),
          //   ),
          // ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF111111).withValues(alpha: 0.5),
                  const Color(0xFF111111).withValues(alpha: 0),
                ],
              ),
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: topPadding + 12,
              bottom: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBackButton(height: 40, width: 40),
                const CustomSizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context.router.push(GroupDetailRoute());
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Avatars Stack
                        SizedBox(
                          width: 210,
                          height: 24,
                          child: Stack(
                            children: List.generate(
                              DummyConstants.avatarPaths.length > 9
                                  ? 9
                                  : DummyConstants.avatarPaths.length,
                              (index) {
                                return Positioned(
                                  left: index * 14.0,
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: ColorPalette.secondary,
                                        width: 2,
                                      ),
                                      image: DecorationImage(
                                        image: AssetImage(
                                          DummyConstants.avatarPaths[index],
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const CustomSizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '10 members',
                              style: AppTextStyles.bodySmall(
                                context,
                              ).copyWith(fontWeight: FontWeight.w400),
                            ),
                            const CustomSizedBox(width: 2),
                            Icon(
                              Icons.chevron_right,
                              color: ColorPalette.white,
                              size: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Phone Button
                CircleIconButton(
                  customChild: SvgPicture.asset(
                    Assets.icons.phone.path,
                    colorFilter: ColorFilter.mode(
                      isLightTheme(context)
                          ? ColorPalette.black
                          : ColorPalette.white,
                      BlendMode.srcIn,
                    ),
                    width: 20,
                    height: 20,
                  ),
                  onTap: () {
                    AutoRouter.of(context).push(
                      GroupAudioCallRoute(
                        group: DummyConstants.groups[1],
                        isVideoCall: false,
                      ),
                    );
                  },
                ),
                const CustomSizedBox(width: 8),
                // Video Button
                CircleIconButton(
                  customChild: SvgPicture.asset(
                    Assets.icons.video.path,
                    colorFilter: ColorFilter.mode(
                      isLightTheme(context)
                          ? ColorPalette.black
                          : ColorPalette.white,
                      BlendMode.srcIn,
                    ),
                    width: 20,
                    height: 20,
                  ),
                  onTap: () {
                    AutoRouter.of(context).push(
                      GroupAudioCallRoute(
                        group: DummyConstants.groups[1],
                        isVideoCall: true,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndividualHeader(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return ClipRRect(
      borderRadius: BorderRadius.zero,
      child: Stack(
        children: [
          // Gradient blur layers - strong at top, fading to almost 0 at bottom
          // Top section - full blur (24)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 40,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
              child: Container(color: Colors.transparent),
            ),
          ),
          // Middle-top section - medium blur (18)
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            height: 20,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(color: Colors.transparent),
            ),
          ),
          // Middle section - lighter blur (12)
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            height: 20,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(color: Colors.transparent),
            ),
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF111111).withValues(alpha: 0.5),
                  const Color(0xFF111111).withValues(alpha: 0),
                ],
              ),
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.only(
              left: 6,
              right: 6,
              top: topPadding + 12,
              bottom: 12,
            ),
            child: Row(
              children: [
                CustomBackButton(height: 40, width: 40),
                const CustomSizedBox(width: 12),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: contactAvatar != null
                              ? DecorationImage(
                                  image: AssetImage(contactAvatar!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                          color: Colors.black.withValues(alpha: 0.3),
                        ),
                      ),
                      const CustomSizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              contactName ?? 'Unknown',
                              style: AppTextStyles.body(
                                context,
                              ).copyWith(fontWeight: FontWeight.w600),
                            ),
                            const CustomSizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isOnline
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                ),
                                const CustomSizedBox(width: 6),
                                Text(
                                  textAlign: TextAlign.start,
                                  isOnline ? 'Online' : 'Offline',
                                  style: AppTextStyles.bodySmall(context)
                                      .copyWith(
                                        color: isLightTheme(context)
                                            ? ColorPalette.black
                                            : ColorPalette.white.withValues(
                                                alpha: 0.7,
                                              ),
                                        fontSize: 12,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const CustomSizedBox(width: 12),
                CircleIconButton(
                  icon: Assets.icons.phone.path,
                  onTap: () {
                    AutoRouter.of(context).push(const CallRoute());
                  },
                ),
                const CustomSizedBox(width: 8),
                CircleIconButton(
                  icon: Assets.icons.video.path,
                  onTap: () {
                    AutoRouter.of(context).push(VideoCallRoute());

                    // AutoRouter.of(context).push(const CallRoute());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
