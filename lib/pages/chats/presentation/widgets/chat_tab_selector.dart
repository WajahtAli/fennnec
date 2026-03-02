import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubit/chat_landing_cubit.dart';

class ChatTabSelector extends StatelessWidget {
  final String? title1;
  final String? title2;

  const ChatTabSelector({super.key, this.title1, this.title2});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _chatLandingCubit,
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
                  onTap: () => _chatLandingCubit.selectTab(0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _chatLandingCubit.selectedTabIndex == 0
                          ? ColorPalette.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    alignment: Alignment.center,
                    child: AppText(
                      text: title1 ?? 'Chats',
                      style: AppTextStyles.subHeading(context).copyWith(
                        color: _chatLandingCubit.selectedTabIndex == 0
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
                  onTap: () => _chatLandingCubit.selectTab(1),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _chatLandingCubit.selectedTabIndex == 1
                          ? ColorPalette.primary
                          : isLightTheme(context)
                          ? ColorPalette.textSecondary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    alignment: Alignment.center,
                    child: AppText(
                      text: title2 ?? 'Calls',
                      style: AppTextStyles.subHeading(context).copyWith(
                        color: _chatLandingCubit.selectedTabIndex == 1
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

final ChatLandingCubit _chatLandingCubit = Di().sl<ChatLandingCubit>();
