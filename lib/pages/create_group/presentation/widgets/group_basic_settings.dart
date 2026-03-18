import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/cubit/create_group_cubit.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/state/create_group_state.dart';
import 'package:fennac_app/reusable_widgets/group_settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupBasicSettings extends StatelessWidget {
  const GroupBasicSettings({super.key, this.isEditMode = false});

  final bool isEditMode;

  @override
  Widget build(BuildContext context) {
    final canManageSettings =
        !isEditMode || cubit.canCurrentUserEditGroupSettings();

    return BlocBuilder<CreateGroupCubit, CreateGroupState>(
      bloc: cubit,
      builder: (context, state) {
        return GroupSettingsWidget(
          settings: [
            GroupSettingItem(
              label: 'Anyone can invite members',
              value: cubit.canInviteMembers,
              onChanged: (value) {
                if (!canManageSettings) {
                  return;
                }
                cubit.updateCanInviteMembers(value);
              },
            ),
            GroupSettingItem(
              label: 'Anyone can update photos/videos',
              value: cubit.canUpdatePhotosVideos,
              onChanged: (value) {
                if (!canManageSettings) {
                  return;
                }
                cubit.updateCanUpdatePhotosVideos(value);
              },
            ),
            GroupSettingItem(
              label: 'Anyone can update prompts',
              value: cubit.canUpdatePrompts,
              onChanged: (value) {
                if (!canManageSettings) {
                  return;
                }
                cubit.updateCanUpdatePrompts(value);
              },
            ),
          ],
        );
      },
    );
  }
}

final cubit = Di().sl<CreateGroupCubit>();
