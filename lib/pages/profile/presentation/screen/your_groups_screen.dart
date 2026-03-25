import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/login_cubit.dart';
import 'package:fennac_app/pages/chats/presentation/widgets/premium_card.dart';
import 'package:fennac_app/pages/my_group/data/model/my_group_model.dart';
import 'package:fennac_app/pages/my_group/presentation/bloc/cubit/my_group_cubit.dart';
import 'package:fennac_app/pages/my_group/presentation/bloc/state/my_group_state.dart';
import 'package:fennac_app/pages/profile/presentation/widgets/group_option_bottomsheet.dart';
import 'package:fennac_app/reusable_widgets/custom_app_bar.dart';
import 'package:fennac_app/reusable_widgets/group_card.dart';
import 'package:fennac_app/skeletons/group_card_skeleton.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di_container.dart';

@RoutePage()
class YourGroupsScreen extends StatefulWidget {
  const YourGroupsScreen({super.key});

  @override
  State<YourGroupsScreen> createState() => _YourGroupsScreenState();
}

class _YourGroupsScreenState extends State<YourGroupsScreen> {
  final ValueNotifier<bool> _showBackdrop = ValueNotifier<bool>(false);
  final MyGroupCubit _myGroupCubit = Di().sl<MyGroupCubit>();

  Future<void> fetchGroupById() async {
    return await _myGroupCubit.fetchGroupById('');
  }

  @override
  void initState() {
    super.initState();
    fetchGroupById();
  }

  @override
  void dispose() {
    _showBackdrop.dispose();
    super.dispose();
  }

  void _showGroupOptions(MyGroupData groupData) {
    _showBackdrop.value = true;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => GroupOptionsBottomSheet(groupData: groupData),
    ).whenComplete(() {
      _showBackdrop.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MovableBackground(
            backgroundType: MovableBackgroundType.dark,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomAppBar(title: 'Your Groups'),
                  CustomSizedBox(height: 16),
                  if (Di()
                          .sl<LoginCubit>()
                          .userData
                          ?.user
                          ?.accountStatus
                          ?.toLowerCase() ==
                      'active'.toLowerCase())
                    PremiumCard(isGradientTitle: true),
                  CustomSizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: AppText(
                        text: 'Your Groups',
                        textAlign: TextAlign.left,
                        style: AppTextStyles.subHeading(
                          context,
                        ).copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  BlocBuilder<MyGroupCubit, MyGroupState>(
                    bloc: _myGroupCubit,
                    builder: (context, state) {
                      if (state is MyGroupLoading) {
                        return GroupCardSkeleton();
                      }

                      var groupList = _myGroupCubit.myGroupList?.groupList;

                      return ListView.builder(
                        itemCount: groupList?.length ?? 0,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final group = groupList?[index];
                          final avatarPaths =
                              group?.members
                                  ?.map((member) => member.image ?? '')
                                  .toList() ??
                              [];
                          final avatarInitials =
                              group?.members?.map((member) {
                                final firstName =
                                    member.firstName?.trim() ?? '';
                                final lastName = member.lastName?.trim() ?? '';
                                final name = [firstName, lastName]
                                    .where((part) => part.isNotEmpty)
                                    .join(' ')
                                    .trim();
                                return name.isNotEmpty
                                    ? name[0].toUpperCase()
                                    : '?';
                              }).toList() ??
                              [];

                          final createdByFirstName =
                              group?.createdBy?.firstName ?? '';
                          final createdByLastName =
                              group?.createdBy?.lastName ?? '';
                          final createdByName =
                              '$createdByFirstName $createdByLastName'.trim();

                          return GroupCard(
                            title: group?.titleMembers ?? '',
                            subtitle: group?.bio ?? '',
                            avatarPaths: avatarPaths,
                            createdByName: createdByName.isNotEmpty
                                ? createdByName
                                : null,
                            createdAt: group?.createdAt,
                            memberNames: avatarInitials,
                            onMenuPressed: () =>
                                _showGroupOptions(group ?? MyGroupData()),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _showBackdrop,
            builder: (context, showBackdrop, child) {
              if (!showBackdrop) return const SizedBox.shrink();
              return Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(color: Colors.black.withValues(alpha: 0.2)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
