import 'package:fennac_app/pages/create_group/data/model/selected_member.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/dummy_constants.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/login_cubit.dart';
import 'package:fennac_app/pages/my_group/data/model/my_group_model.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/cubit/contact_list_cubit.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/state/contact_list_state.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedMembersList extends StatelessWidget {
  final ContactListCubit contactListCubit;
  final bool isEditMode;
  final List<CreatedBy> editMembers;

  const SelectedMembersList({
    super.key,
    required this.contactListCubit,
    required this.isEditMode,
    required this.editMembers,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactListCubit, ContactListState>(
      bloc: contactListCubit,
      builder: (context, state) {
        final selectedMembers = contactListCubit.selectedMembers;

        return _MembersWrap(
          selectedMembers: selectedMembers,
          isEditMode: isEditMode,
          editMembers: editMembers,
          onAddTap: () {
            AutoRouter.of(context).push(const AddMemberRoute());
          },
          onRemove: (index) {
            contactListCubit.removeMember(index);
          },
        );
      },
    );
  }
}

class _MembersWrap extends StatelessWidget {
  final List<SelectedMember> selectedMembers;
  final bool isEditMode;
  final List<CreatedBy> editMembers;
  final VoidCallback onAddTap;
  final Function(int) onRemove;

  const _MembersWrap({
    required this.selectedMembers,
    required this.isEditMode,
    required this.editMembers,
    required this.onAddTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    // Build list of all members (local + API)
    // Build list of all members
    final allMembers = <Map<String, dynamic>>[];
    final addedIdentifiers = <String>{};

    String? getEditMemberIdentifier(CreatedBy member) {
      if (member.id != null) return 'id:${member.id}';
      if (member.email != null && member.email!.isNotEmpty) {
        return 'email:${member.email}';
      }
      return null;
    }

    // Add selected members
    for (int i = 0; i < selectedMembers.length && allMembers.length < 4; i++) {
      final member = selectedMembers[i];
      final identifier = member.id;

      if (addedIdentifiers.contains(identifier)) {
        continue; // Skip duplicate
      }
      addedIdentifiers.add(identifier);

      allMembers.add({'type': 'selected', 'member': member, 'index': i});
    }

    if (isEditMode) {
      for (final member in editMembers) {
        if (allMembers.length >= 4) break;
        if (member.id == null) continue;

        final identifier = getEditMemberIdentifier(member);

        if (identifier != null && addedIdentifiers.contains(identifier)) {
          continue; // Skip duplicate
        }
        if (identifier != null) {
          addedIdentifiers.add(identifier);
        }

        allMembers.add({'type': 'group', 'member': member});
      }
    }

    // Generate member slots
    final memberSlots = List.generate(4, (index) {
      if (index < allMembers.length) {
        final memberData = allMembers[index];
        if (memberData['type'] == 'selected') {
          final member = memberData['member'] as SelectedMember;
          return _MemberSlot(
            selectedMember: member,
            label: member.displayName.isNotEmpty
                ? member.displayName
                : 'Member',
            subtitle: member.phoneNumber,
            roleLabel: 'Invited',
            onRemove: () => onRemove(memberData['index']),
          );
        } else if (memberData['type'] == 'group') {
          final member = memberData['member'] as CreatedBy;
          final displayName = [
            member.firstName,
            member.lastName,
          ].whereType<String>().join(' ').trim();

          return _MemberSlot(
            label: displayName.isNotEmpty ? displayName : 'Member',
            subtitle: member.email,
            roleLabel: 'Invited',
          );
        }
      }
      return _MemberSlot(isAdd: true, label: 'Add Member', onAdd: onAddTap);
    });

    final loginCubit = Di().sl<LoginCubit>();
    final currentUserImage =
        loginCubit.userData?.user?.bestShorts?.isNotEmpty == true
        ? loginCubit.userData!.user!.bestShorts!.first
        : DummyConstants.avatarPaths[0];

    final allSlots = [
      _MemberSlot(
        isAdmin: true,
        imagePath: currentUserImage,
        label: 'You',
        roleLabel: 'Admin',
      ),
      ...memberSlots,
    ];

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
              onTap: isAdd ? onAdd : null,
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
                          isLight ? Colors.black : Colors.white,
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
                                    child: Icon(
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
