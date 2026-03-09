import 'package:fennac_app/app/constants/app_enums.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/homelanding/data/models/group_invitation_model.dart';
import 'package:fennac_app/pages/homelanding/presentation/bloc/cubit/home_landing_cubit.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLandingBanner extends StatelessWidget {
  const HomeLandingBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: BlocBuilder(
        bloc: _homeLandingCubit,
        builder: (context, state) {
          final invitations = _homeLandingCubit.invitations;
          final firstInvitation = invitations.isNotEmpty
              ? invitations[0]
              : null;
          final group = firstInvitation?.group;
          final inviter = firstInvitation?.inviter;
          // Get member names
          final memberNames = group?.members != null
              ? group!.members!
                    .map((m) => m.firstName ?? '')
                    .where((name) => name.isNotEmpty)
                    .join(',\t')
              : 'Group Members';
          // Get inviter name
          final inviterName = inviter != null
              ? '${inviter.firstName ?? ''} ${inviter.lastName ?? ''}'.trim()
              : 'Group Creator';
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomSizedBox(height: 80),
              Container(
                height: getWidth(context) > 370 ? 370 : 320,
                decoration: BoxDecoration(
                  color: isDarkTheme(context)
                      ? ColorPalette.black.withValues(alpha: 0.2)
                      : ColorPalette.textGrey,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildGroupImageWithAvatars(context, group),
                    const CustomSizedBox(height: 54),
                    AppText(
                      text: memberNames,
                      style: AppTextStyles.h1(
                        context,
                      ).copyWith(fontSize: 24, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    const CustomSizedBox(height: 16),
                    // Group Creation Info
                    AppText(
                      text: group != null
                          ? 'Group "${group.title ?? group.name}" created by $inviterName'
                          : 'Group created by $inviterName',
                      style: AppTextStyles.description(context).copyWith(
                        color: isDarkTheme(context)
                            ? ColorPalette.textSecondary
                            : ColorPalette.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const CustomSizedBox(height: 16),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildGroupImageWithAvatars(BuildContext context, Group? group) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          width: 392,
          height: getWidth(context) > 370 ? 250 : 200,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: ColorFiltered(
              colorFilter:
                  _homeLandingCubit.invitationStatus ==
                      InvitationStatus.declined
                  ? const ColorFilter.matrix(<double>[
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0,
                      0,
                      0,
                      1,
                      0,
                    ])
                  : const ColorFilter.mode(Colors.transparent, BlendMode.dst),
              child: _buildGroupImage(context, group),
            ),
          ),
        ),
        // Member Avatars Row at Bottom
        Positioned(
          bottom: -30,
          right: (group?.members?.length == 1) ? null : 0,
          left: (group?.members?.length == 1) ? null : 70,
          child: Row(
            mainAxisAlignment: (group?.members?.length == 1)
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            mainAxisSize: (group?.members?.length == 1)
                ? MainAxisSize.max
                : MainAxisSize.min,
            children: [
              if (group?.members != null && group!.members!.isNotEmpty)
                for (final entry in group.members!.indexed)
                  Transform.translate(
                    offset: (group.members!.length == 1)
                        ? const Offset(0, 0)
                        : Offset(-12.0 * entry.$1, 0),
                    child: _buildMemberAvatar(
                      entry.$2.image ?? '',
                      context,
                      entry.$2,
                    ),
                  )
              else
                for (final entry in [
                  Assets.dummy.a1.path,
                  Assets.dummy.b1.path,
                  Assets.dummy.c1.path,
                  Assets.dummy.d1.path,
                ].indexed)
                  Transform.translate(
                    offset: Offset(-12.0 * entry.$1, 0),
                    child: _buildMemberAvatar(entry.$2, context, null),
                  ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGroupImage(BuildContext context, Group? group) {
    if (group?.photosVideos != null && group!.photosVideos!.isNotEmpty) {
      return Image.network(
        group.photosVideos![0],
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(Assets.dummy.groupSelfie.path, fit: BoxFit.cover);
        },
      );
    }
    return Image.asset(Assets.dummy.groupSelfie.path, fit: BoxFit.cover);
  }

  Widget _buildMemberAvatar(
    String imagePath,
    BuildContext context,
    Member? member,
  ) {
    final bool isDeclined =
        _homeLandingCubit.invitationStatus == InvitationStatus.declined;

    return Container(
      width: getWidth(context) > 370 ? 64 : 54,
      height: getWidth(context) > 370 ? 64 : 54,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: ColorFiltered(
          colorFilter: isDeclined
              ? const ColorFilter.matrix(<double>[
                  0.2126,
                  0.7152,
                  0.0722,
                  0,
                  0,
                  0.2126,
                  0.7152,
                  0.0722,
                  0,
                  0,
                  0.2126,
                  0.7152,
                  0.0722,
                  0,
                  0,
                  0,
                  0,
                  0,
                  1,
                  0,
                ])
              : const ColorFilter.mode(Colors.transparent, BlendMode.dst),
          child:
              member != null && member.image != null && member.image!.isNotEmpty
              ? Image.network(
                  member.image!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildPlaceholderAvatar(imagePath);
                  },
                )
              : _buildPlaceholderAvatar(imagePath),
        ),
      ),
    );
  }

  Widget _buildPlaceholderAvatar(String imagePath) {
    return imagePath.isNotEmpty
        ? Image.asset(imagePath, fit: BoxFit.cover)
        : Icon(Icons.account_circle, color: ColorPalette.primary, size: 64);
  }
}

final HomeLandingCubit _homeLandingCubit = Di().sl<HomeLandingCubit>();
