import 'package:fennac_app/app/theme/app_emojis.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/cubit/create_group_cubit.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/state/create_group_state.dart';
import 'package:fennac_app/pages/create_group/presentation/widgets/interest_chip.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupInterestsSelection extends StatelessWidget {
  final CreateGroupCubit cubit;
  final bool isEditable;

  const GroupInterestsSelection({
    super.key,
    required this.cubit,
    this.isEditable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: 'What fits your group well?',
          style: AppTextStyles.inputLabel(
            context,
          ).copyWith(fontWeight: FontWeight.bold),
        ),
        const CustomSizedBox(height: 12),
        BlocBuilder<CreateGroupCubit, CreateGroupState>(
          bloc: cubit,
          builder: (context, state) {
            final selectedInterests = cubit.selectedInterests;
            return IgnorePointer(
              ignoring: !isEditable,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  InterestChip(
                    emoji: AppEmojis.mountain,
                    label: 'Travel & Adventure',
                    isSelected: selectedInterests.contains('travel'),
                    onTap: () => cubit.toggleInterest('travel'),
                  ),
                  InterestChip(
                    emoji: AppEmojis.musicalNote,
                    label: 'Music & Arts',
                    isSelected: selectedInterests.contains('music'),
                    onTap: () => cubit.toggleInterest('music'),
                  ),
                  InterestChip(
                    emoji: AppEmojis.hamburger,
                    label: 'Food & Drink',
                    isSelected: selectedInterests.contains('food'),
                    onTap: () => cubit.toggleInterest('food'),
                  ),
                  InterestChip(
                    emoji: AppEmojis.yoga,
                    label: 'Wellness & Lifestyle',
                    isSelected: selectedInterests.contains('wellness'),
                    onTap: () => cubit.toggleInterest('wellness'),
                  ),
                  InterestChip(
                    emoji: AppEmojis.football,
                    label: 'Sports & Outdoors',
                    isSelected: selectedInterests.contains('sports'),
                    onTap: () => cubit.toggleInterest('sports'),
                  ),
                  InterestChip(
                    emoji: AppEmojis.partyPopper,
                    label: 'Events & Parties',
                    isSelected: selectedInterests.contains('events'),
                    onTap: () => cubit.toggleInterest('events'),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
