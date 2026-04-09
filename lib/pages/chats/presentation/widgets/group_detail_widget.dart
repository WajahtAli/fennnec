import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubit/group_details_tab_cubit.dart';
import '../bloc/state/group_details_tab_state.dart';

class GroupDetailWidget extends StatelessWidget {
  final String? title1;
  final String? title2;
  final GroupDetailsTabCubit tabCubit;

  const GroupDetailWidget({
    super.key,
    this.title1,
    this.title2,
    required this.tabCubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupDetailsTabCubit, GroupDetailsTabState>(
      bloc: tabCubit,
      builder: (context, state) {
        return Container(
          height: 36,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: isLightTheme(context)
                ? ColorPalette.textSecondary
                : ColorPalette.cardBlack,
            border: Border.all(color: ColorPalette.grey, width: 1.5),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => tabCubit.selectTab(0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: state.selectedTab == 0
                          ? ColorPalette.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    alignment: Alignment.center,
                    child: AppText(
                      text: title1 ?? '',
                      style: AppTextStyles.subHeading(context).copyWith(
                        color: state.selectedTab == 0
                            ? ColorPalette.white
                            : isLightTheme(context)
                            ? ColorPalette.black
                            : ColorPalette.white,
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: GestureDetector(
                  onTap: () => tabCubit.selectTab(1),
                  child: Container(
                    decoration: BoxDecoration(
                      color: state.selectedTab == 1
                          ? ColorPalette.primary
                          : isLightTheme(context)
                          ? ColorPalette.textSecondary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    alignment: Alignment.center,
                    child: AppText(
                      text: title2 ?? '',
                      style: AppTextStyles.subHeading(context).copyWith(
                        color: state.selectedTab == 1
                            ? ColorPalette.white
                            : isLightTheme(context)
                            ? ColorPalette.black
                            : ColorPalette.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
