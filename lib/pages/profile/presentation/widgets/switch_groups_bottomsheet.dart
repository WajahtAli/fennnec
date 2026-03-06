import 'dart:ui';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/my_group/presentation/bloc/cubit/my_group_cubit.dart';
import 'package:fennac_app/pages/my_group/presentation/bloc/state/my_group_state.dart';
import 'package:fennac_app/reusable_widgets/member_avatar_widget.dart';
import 'package:fennac_app/skeletons/group_card_skeleton.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchGroupsBottomSheet extends StatefulWidget {
  const SwitchGroupsBottomSheet({super.key});

  @override
  State<SwitchGroupsBottomSheet> createState() =>
      _SwitchGroupsBottomSheetState();
}

class _SwitchGroupsBottomSheetState extends State<SwitchGroupsBottomSheet> {
  final ValueNotifier<int?> _selectedGroupIndex = ValueNotifier<int?>(0);
  late final MyGroupCubit _myGroupCubit;

  @override
  void initState() {
    super.initState();
    _myGroupCubit = Di().sl<MyGroupCubit>();
    // Fetch groups if not already loaded
    if (_myGroupCubit.myGroupList == null ||
        _myGroupCubit.myGroupList?.groupList == null) {
      _myGroupCubit.fetchGroupById('');
    }
  }

  @override
  void dispose() {
    _selectedGroupIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isLightTheme(context) ? Colors.white : ColorPalette.secondary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CustomSizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const CustomSizedBox(height: 20),
          Text('Switch Group', style: AppTextStyles.h3(context)),
          const CustomSizedBox(height: 24),
          Flexible(
            child: BlocBuilder<MyGroupCubit, MyGroupState>(
              bloc: _myGroupCubit,
              builder: (context, state) {
                if (state is MyGroupLoading) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Column(
                      children: [
                        GroupCardSkeleton(),
                        const CustomSizedBox(height: 8),
                        GroupCardSkeleton(),
                      ],
                    ),
                  );
                }

                final groupList = _myGroupCubit.myGroupList?.groupList;

                if (groupList == null || groupList.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Center(
                      child: Text(
                        'No groups available',
                        style: AppTextStyles.description(context),
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 32),
                  itemCount: groupList.length,
                  itemBuilder: (context, index) {
                    final group = groupList[index];
                    final apiAvatars =
                        group.photosVideos
                            ?.where((path) => path.trim().isNotEmpty)
                            .toList() ??
                        [];
                    final avatarPaths = apiAvatars.isNotEmpty
                        ? apiAvatars
                        : [
                            Assets.dummy.a1.path,
                            Assets.dummy.a2.path,
                            Assets.dummy.a3.path,
                          ];

                    return ValueListenableBuilder<int?>(
                      valueListenable: _selectedGroupIndex,
                      builder: (context, selectedIndex, child) {
                        final isSelected = selectedIndex == index;
                        return _SelectableGroupCard(
                          title:
                              group.titleMembers ??
                              'Brenda, Nancy, Jeff, Anna & You',
                          avatarPaths: avatarPaths,
                          isSelected: isSelected,
                          onTap: () {
                            _selectedGroupIndex.value = index;
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectableGroupCard extends StatelessWidget {
  final String title;
  final List<String> avatarPaths;
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectableGroupCard({
    required this.title,
    required this.avatarPaths,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = getWidth(context) - 32;
    final maxWidth = 392.0;
    final actualWidth = cardWidth > maxWidth ? maxWidth : cardWidth;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: actualWidth,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected
                    ? ColorPalette.primary
                    : (isLightTheme(context)
                          ? ColorPalette.textGrey
                          : ColorPalette.black.withValues(alpha: 0.3)),
                borderRadius: BorderRadius.circular(24),
                border: isSelected
                    ? Border.all(color: ColorPalette.primary, width: 2)
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  MemberAvatarWidget(
                    avatarPaths: avatarPaths,
                    borderColor: isSelected ? Colors.white : null,
                  ),
                  const CustomSizedBox(height: 16),
                  Text(
                    title,
                    style: AppTextStyles.h4(
                      context,
                    ).copyWith(color: isSelected ? Colors.white : null),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const CustomSizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showSwitchGroupsBottomSheet(
  BuildContext context, {
  ValueNotifier<bool>? blurNotifier,
}) {
  blurNotifier?.value = true;
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => const SwitchGroupsBottomSheet(),
  ).whenComplete(() {
    blurNotifier?.value = false;
  });
}
