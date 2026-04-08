import 'package:fennac_app/pages/create_group/data/model/selected_member.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/login_cubit.dart';
import 'package:fennac_app/pages/my_group/data/model/my_group_model.dart';
import 'package:fennac_app/pages/my_group/presentation/bloc/cubit/my_group_cubit.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/cubit/contact_list_cubit.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/state/contact_list_state.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedMembersList extends StatefulWidget {
  final ContactListCubit contactListCubit;
  final bool isEditMode;
  final List<CreatedBy> editMembers;
  final bool canEditMembers;

  const SelectedMembersList({
    super.key,
    required this.contactListCubit,
    required this.isEditMode,
    required this.editMembers,
    this.canEditMembers = true,
  });

  @override
  State<SelectedMembersList> createState() => _SelectedMembersListState();
}

class _SelectedMembersListState extends State<SelectedMembersList> {
  @override
  void initState() {
    super.initState();
    if (widget.isEditMode) {
      widget.contactListCubit.selectedMembers.clear();
      for (final member in widget.editMembers) {
        if (member.id != null) {
          final displayName = [
            member.firstName,
            member.lastName,
          ].whereType<String>().join(' ').trim();

          widget.contactListCubit.addMember(
            SelectedMember(
              id: member.id ?? '',
              displayName: displayName.isNotEmpty ? displayName : 'Member',
              email: member.email ?? '',
              fennecId: member.id ?? "",
              isFennecUser: true,
              profileImageUrl: member.image,
              memberStatus: member.memberStatus,
            ),
            isApiCallNeeded: false,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactListCubit, ContactListState>(
      bloc: widget.contactListCubit,
      builder: (context, state) {
        final selectedMembers = widget.contactListCubit.selectedMembers;

        return _MembersWrap(
          isEditMode: widget.isEditMode,
          selectedMembers: selectedMembers,
          onAddTap: widget.canEditMembers
              ? () {
                  AutoRouter.of(context).push(const AddMemberRoute());
                }
              : null,
          onRemove: widget.canEditMembers
              ? (index) {
                  widget.contactListCubit.removeMember(index);
                }
              : null,
        );
      },
    );
  }
}

class _MembersWrap extends StatelessWidget {
  final bool isEditMode;
  final List<SelectedMember> selectedMembers;
  final VoidCallback? onAddTap;
  final Function(int)? onRemove;

  const _MembersWrap({
    required this.isEditMode,
    required this.selectedMembers,
    required this.onAddTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final myGroupCubit = Di().sl<MyGroupCubit>();
    final loginCubit = Di().sl<LoginCubit>();
    final currentUser = loginCubit.userData?.user;

    final createdBy =
        myGroupCubit.myGroupModel?.data?.createdBy ??
        ((myGroupCubit.myGroupList?.groupList?.isNotEmpty ?? false)
            ? myGroupCubit.myGroupList!.groupList!.first.createdBy
            : null);

    final adminFirstName = isEditMode
        ? createdBy?.firstName?.trim()
        : currentUser?.firstName?.trim();
    final adminLastName = isEditMode
        ? createdBy?.lastName?.trim()
        : currentUser?.lastName?.trim();
    final adminId = isEditMode ? createdBy?.id : currentUser?.id;
    final adminEmail = isEditMode ? createdBy?.email : currentUser?.email;
    final currentUserBestShorts = currentUser?.bestShorts;
    final adminImage = isEditMode
        ? createdBy?.image
        : ((currentUserBestShorts != null && currentUserBestShorts.isNotEmpty)
              ? currentUserBestShorts.first
              : '');

    final createdByName = [
      adminFirstName,
      adminLastName,
    ].whereType<String>().where((name) => name.isNotEmpty).join(' ').trim();

    final createdByMember = SelectedMember(
      id: adminId ?? 'group-admin',
      displayName: createdByName.isNotEmpty ? createdByName : 'Admin',
      profileImageUrl: adminImage,
      email: adminEmail,
      isFennecUser: true,
      fennecId: adminId,
    );

    // Filter out admin from members to avoid duplicate
    final filteredMembers = selectedMembers
        .where((m) => m.id != createdByMember.id)
        .toList();

    // Total non-admin slots = 4 (slots 2–5)
    // Slot layout: [Admin, member/addMember/empty, member/addMember/empty, member/addMember/empty, member/addMember/empty]
    // The first empty slot after all real members becomes "Add Member" (tappable)
    // Remaining slots are plain empty placeholders

    // Build the 5 fixed slots
    List<Widget> allSlots = [];

    // Slot 0: Admin (always)
    allSlots.add(
      _MemberSlot(
        isAdmin: true,
        selectedMember: createdByMember,
        imagePath: adminImage?.isNotEmpty == true ? adminImage : null,
        label: createdByMember.displayName,
        roleLabel: 'Admin',
      ),
    );

    // Slots 1–4: member data, then one "Add Member", then empty placeholders
    bool addMemberSlotPlaced = false;
    for (int i = 0; i < 4; i++) {
      if (i < filteredMembers.length) {
        // Real member
        final member = filteredMembers[i];
        allSlots.add(
          _MemberSlot(
            selectedMember: member,
            label: member.displayName.isNotEmpty
                ? member.displayName
                : 'Member',
            subtitle: member.phoneNumber,
            roleLabel: member.memberStatus,
            onRemove: onRemove != null ? () => onRemove!(i) : null,
          ),
        );
      } else if (!addMemberSlotPlaced && onAddTap != null) {
        // First empty slot becomes the tappable "Add Member"
        allSlots.add(
          _MemberSlot(isAdd: true, label: 'Add Member', onAdd: onAddTap),
        );
        addMemberSlotPlaced = true;
      } else {
        // Remaining slots: plain empty placeholder (non-tappable)
        allSlots.add(
          const _MemberSlot(isAdd: true, isEmptyPlaceholder: true, label: ''),
        );
      }
    }

    // Split into top row (3) and bottom row (2)
    final topRow = allSlots.take(3).toList();
    final bottomRow = allSlots.skip(3).take(2).toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < topRow.length; i++) ...[
              topRow[i],
              if (i != topRow.length - 1) const CustomSizedBox(width: 30),
            ],
          ],
        ),
        const CustomSizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < bottomRow.length; i++) ...[
              bottomRow[i],
              if (i != bottomRow.length - 1) const CustomSizedBox(width: 40),
            ],
          ],
        ),
      ],
    );
  }
}

class _MemberSlot extends StatelessWidget {
  final SelectedMember? selectedMember;
  final bool isAdd;
  final bool isAdmin;
  final bool isEmptyPlaceholder; // true = non-tappable empty slot
  final String? imagePath;
  final String label;
  final String? subtitle;
  final String? roleLabel;
  final VoidCallback? onAdd;
  final VoidCallback? onRemove;

  const _MemberSlot({
    this.selectedMember,
    this.isAdd = false,
    this.isAdmin = false,
    this.isEmptyPlaceholder = false,
    this.imagePath,
    this.label = '',
    this.subtitle,
    this.roleLabel,
    this.onAdd,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    const double size = 80;
    final String initial = _initialFor(selectedMember);
    final bool showRemove = !isAdd && !isAdmin && onRemove != null;
    final isLight = Theme.of(context).brightness == Brightness.light;
    final avatarBgColor = isLight
        ? ColorPalette.textGrey
        : ColorPalette.secondary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            GestureDetector(
              // Only tappable if it's the active "Add Member" slot
              onTap: (isAdd && !isEmptyPlaceholder) ? onAdd : null,
              child: Container(
                width: size,
                height: size,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: isAdd || selectedMember != null
                      ? LinearGradient(
                          colors: [
                            avatarBgColor.withValues(alpha: 0.85),
                            avatarBgColor.withValues(alpha: 0.9),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: imagePath != null ? Colors.transparent : avatarBgColor,
                ),
                child: isAdd
                    ? Assets.icons.userPlus.svg(
                        width: 34,
                        height: 34,
                        colorFilter: ColorFilter.mode(
                          // Dim the icon for empty placeholders
                          isEmptyPlaceholder
                              ? (isLight ? Colors.black : Colors.white)
                                    .withValues(alpha: 0.3)
                              : (isLight ? Colors.black : Colors.white),
                          BlendMode.srcIn,
                        ),
                      )
                    : imagePath != null
                    ? ClipOval(
                        child: imagePath!.startsWith('http')
                            ? Image.network(
                                imagePath!,
                                width: size,
                                height: size,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: size,
                                    height: size,
                                    color: avatarBgColor,
                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                              )
                            : Image.asset(
                                imagePath!,
                                width: size,
                                height: size,
                                fit: BoxFit.cover,
                              ),
                      )
                    : Text(initial, style: AppTextStyles.h2(context)),
              ),
            ),
            if (roleLabel != null)
              Positioned(
                bottom: -10,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: ColorPalette.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: AppText(
                      text: roleLabel!,
                      style: AppTextStyles.inputLabel(context).copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            if (showRemove)
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: onRemove,
                  child: Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorPalette.error,
                    ),
                    child: Assets.icons.cancel.svg(
                      width: 12,
                      height: 12,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        // Only show label text for non-empty-placeholder slots
        if (!isEmptyPlaceholder) ...[
          AppText(
            text: label,
            style: AppTextStyles.description(context).copyWith(
              color: isLightTheme(context)
                  ? ColorPalette.black
                  : ColorPalette.textSecondary,
            ),
          ),
          if (subtitle != null && subtitle!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: SizedBox(
                width: 90,
                child: AppText(
                  text: subtitle!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmall(context).copyWith(
                    color: ColorPalette.textPrimary.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ),
        ] else
          // Reserve the same space as label text to keep layout consistent
          const SizedBox(height: 20),
      ],
    );
  }
}

String _initialFor(SelectedMember? member) {
  final name = member?.displayName.trim();
  if (name == null || name.isEmpty) {
    return '?';
  }
  return name[0].toUpperCase();
}
