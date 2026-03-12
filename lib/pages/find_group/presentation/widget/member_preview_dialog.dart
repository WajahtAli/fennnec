import 'dart:ui' as ui;

import 'package:fennac_app/core/di_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/pages/find_group/presentation/bloc/cubit/find_group_cubit.dart';
import 'package:fennac_app/pages/find_group/presentation/bloc/state/find_group_state.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/create_group/data/model/selected_member.dart';
import 'package:lottie/lottie.dart';

import '../../../create_group/presentation/bloc/cubit/contact_list_cubit.dart';

class MemberPreviewDialog extends StatelessWidget {
  final FindGroupCubit findGroupCubit;
  final String? widgetQrCode;

  const MemberPreviewDialog({
    super.key,
    required this.findGroupCubit,
    this.widgetQrCode,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Material(
          color: Colors.transparent,
          child: SizedBox(
            width: getWidth(context),
            height: 304,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.only(bottom: 0),
                decoration: BoxDecoration(
                  color: isLightTheme(context)
                      ? Colors.white
                      : const Color(0xFF0B0B0B),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: isLightTheme(context)
                          ? Colors.black.withValues(alpha: 0.15)
                          : const Color(0xFF5F00DB),
                      blurRadius: 50,
                      spreadRadius: 0,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: BlocBuilder<FindGroupCubit, FindGroupState>(
                        bloc: findGroupCubit,
                        builder: (context, state) {
                          if (state is FindGroupLoading) {
                            return Center(
                              child: Lottie.asset(
                                Assets.animations.loadingSpinner,
                              ),
                            );
                          }

                          final member = findGroupCubit.qrMemberModel?.data;
                          final avatarPath = member?.image ?? '';

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: avatarPath.isNotEmpty
                                    ? CachedNetworkImageProvider(avatarPath)
                                    : AssetImage(Assets.dummy.a1.path)
                                          as ImageProvider,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                '${member?.firstName ?? ''} ${member?.lastName ?? ''}'
                                    .trim(),
                                style: AppTextStyles.h3(context),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    BlocBuilder<FindGroupCubit, FindGroupState>(
                      bloc: findGroupCubit,
                      builder: (context, state) {
                        return SizedBox(
                          width: 300,
                          child: CustomElevatedButton(
                            text: 'Add to Group',
                            onTap: () {
                              final member = findGroupCubit.qrMemberModel?.data;
                              if (member != null && member.id != null) {
                                final selectedMember = SelectedMember(
                                  id: member.id!,
                                  displayName:
                                      '${member.firstName ?? ''} ${member.lastName ?? ''}'
                                          .trim(),
                                  profileImageUrl: member.image,
                                  isFennecUser: true,
                                  fennecId: member.id!,
                                );
                                Di().sl<ContactListCubit>().addMember(
                                  selectedMember,
                                );
                                AutoRouter.of(context).pop();
                                AutoRouter.of(context).pop();
                              } else {
                                AutoRouter.of(context).pop();
                              }
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
