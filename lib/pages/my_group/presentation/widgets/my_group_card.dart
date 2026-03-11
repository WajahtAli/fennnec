import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/my_group/presentation/bloc/cubit/my_group_cubit.dart';
import 'package:fennac_app/pages/my_group/presentation/bloc/state/my_group_state.dart';
import 'package:fennac_app/pages/profile/presentation/widgets/group_option_bottomsheet.dart';
import 'package:fennac_app/reusable_widgets/group_card.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/skeletons/group_card_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fennac_app/pages/my_group/data/model/my_group_model.dart';
import '../../../../core/di_container.dart';

class MyGroupCard extends StatefulWidget {
  final bool isEditMode;

  const MyGroupCard({super.key, this.isEditMode = false});

  @override
  State<MyGroupCard> createState() => _MyGroupCardState();
}

class _MyGroupCardState extends State<MyGroupCard> {
  final ValueNotifier<bool> _showBackdrop = ValueNotifier<bool>(false);

  final MyGroupCubit _myGroupCubit = Di().sl<MyGroupCubit>();

  Future<void> fetchGroupById() async {
    return await _myGroupCubit.fetchGroupById('');
  }

  @override
  void initState() {
    if (!widget.isEditMode) {
      fetchGroupById();
    }
    super.initState();
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
    return BlocBuilder<MyGroupCubit, MyGroupState>(
      bloc: _myGroupCubit,
      builder: (context, state) {
        if (state is MyGroupLoading) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              spacing: 10,
              children: [
                GroupCardSkeleton(),
                GroupCardSkeleton(),
                GroupCardSkeleton(),
                GroupCardSkeleton(),
                GroupCardSkeleton(),
              ],
            ),
          );
        }

        final groupList = _myGroupCubit.myGroupList?.groupList;

        if (groupList?.isEmpty ?? true) {
          return const SizedBox.shrink();
        }

        return ListView.builder(
          itemCount: groupList?.length ?? 0,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final group = groupList?[index];
            final avatarPaths =
                group?.members?.map((member) => member.image ?? '').toList() ??
                [
                  Assets.dummy.a1.path,
                  Assets.dummy.a2.path,
                  Assets.dummy.a3.path,
                  Assets.dummy.a4.path,
                  Assets.dummy.a5.path,
                ];

            final memberNames =
                group?.members
                    ?.map(
                      (member) =>
                          '${member.firstName ?? ''} ${member.lastName ?? ''}'
                              .trim(),
                    )
                    .toList() ??
                [];

            return GroupCard(
              title: group?.titleMembers ?? '',
              subtitle: group?.bio ?? '',
              avatarPaths: avatarPaths,
              onMenuPressed: widget.isEditMode
                  ? () {
                      AutoRouter.of(
                        context,
                      ).push(CreateGroupRoute(isEditMode: true));
                    }
                  : () => _showGroupOptions(group!),
              chipLabel: group?.fitsForGroup,
              isEditMode: widget.isEditMode,
              memberNames: memberNames,
            );
          },
        );
      },
    );
  }
}
