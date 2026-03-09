import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/dashboard/presentation/bloc/cubit/dashboard_cubit.dart';
import 'package:fennac_app/pages/find_group/presentation/bloc/cubit/find_group_cubit.dart';
import 'package:fennac_app/pages/find_group/presentation/bloc/state/find_group_state.dart';
import 'package:fennac_app/pages/home/presentation/screen/home_screen.dart';
import 'package:fennac_app/reusable_widgets/group_card.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/skeletons/group_card_skeleton.dart';
import 'package:fennac_app/utils/validators.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';

class GroupPreviewDialog extends StatelessWidget {
  final FindGroupCubit findGroupCubit;
  final String? widgetQrCode;

  const GroupPreviewDialog({
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
                    BlocBuilder<FindGroupCubit, FindGroupState>(
                      bloc: findGroupCubit,
                      builder: (context, state) {
                        if (state is FindGroupLoading) {
                          return const GroupCardSkeleton();
                        }

                        final apiAvatars =
                            findGroupCubit.myGroupModel?.data?.members
                                ?.map((member) => member.image)
                                .toList() ??
                            [];
                        final avatarPaths = apiAvatars.isNotEmpty
                            ? apiAvatars
                            : [
                                Assets.dummy.a1.path,
                                Assets.dummy.a2.path,
                                Assets.dummy.a3.path,
                                Assets.dummy.a4.path,
                                Assets.dummy.a5.path,
                              ];

                        return GroupCard(
                          isShowInfoIcon: false,
                          height: 166,
                          backgroundColor: isLightTheme(context)
                              ? Colors.white
                              : Colors.black.withValues(alpha: 0.2),
                          title:
                              findGroupCubit.myGroupModel?.data?.titleMembers ??
                              'Your Group',
                          subtitle:
                              findGroupCubit.myGroupModel?.data?.bio ??
                              'Group details',
                          avatarPaths: validateStringList(avatarPaths),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    BlocBuilder<FindGroupCubit, FindGroupState>(
                      bloc: findGroupCubit,
                      builder: (context, state) {
                        return SizedBox(
                          width: 300,
                          child: CustomElevatedButton(
                            text: 'Join Group',
                            isLoading: findGroupCubit.isJoining,
                            icon: findGroupCubit.isJoining
                                ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Lottie.asset(
                                      Assets.animations.loadingSpinner,
                                    ),
                                  )
                                : null,
                            onTap: findGroupCubit.isJoining
                                ? () {}
                                : () async {
                                    final qrCode =
                                        findGroupCubit.currentQrCode ??
                                        widgetQrCode;
                                    if (qrCode == null || qrCode.isEmpty) {
                                      return;
                                    }
                                    final success = await findGroupCubit
                                        .joinGroupByQr(qrCode);
                                    if (success && context.mounted) {
                                      Di().sl<DashboardCubit>().changePage(
                                        0,
                                        HomeScreen(),
                                      );
                                      AutoRouter.of(
                                        context,
                                      ).push(const DashboardRoute());
                                    } else {
                                      if (context.mounted) {
                                        AutoRouter.of(context).pop();
                                      }
                                    }
                                  },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
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
