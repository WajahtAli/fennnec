import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/cubit/contact_list_cubit.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/state/contact_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/constants/media_query_constants.dart';

class AddMemberSearchBar extends StatelessWidget {
  final ContactListCubit cubit;

  const AddMemberSearchBar({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final isLight = isLightTheme(context);

    return BlocBuilder<ContactListCubit, ContactListState>(
      bloc: cubit,
      builder: (context, state) {
        return TextField(
          controller: cubit.searchController,
          style: TextStyle(color: isLight ? Colors.black : Colors.white),
          cursorColor: isLight ? Colors.black54 : Colors.white70,
          onChanged: (value) {
            cubit.searchContacts(value);
          },
          onSubmitted: (value) => cubit.searchContacts(value),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: isLight ? Colors.black38 : Colors.white70,
            ),
            hintText: 'Search by email or phone number..',
            hintStyle: TextStyle(
              color: isLight ? Colors.black45 : Colors.white60,
            ),
            filled: true,
            fillColor: isLight
                ? ColorPalette.textGrey.withValues(alpha: 0.2)
                : Colors.black.withValues(alpha: 0.15),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            suffixIcon: cubit.searchController.text.isNotEmpty
                ? GestureDetector(
                    onTap: cubit.clearSearch,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Assets.icons.cancel.svg(
                        width: 14,
                        height: 14,
                        colorFilter: ColorFilter.mode(
                          isLight ? Colors.black45 : Colors.white60,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: isLight
                    ? Colors.black.withValues(alpha: 0.12)
                    : Colors.white.withValues(alpha: 0.24),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: isLight
                    ? Colors.black.withValues(alpha: 0.24)
                    : Colors.white.withValues(alpha: 0.36),
              ),
            ),
          ),
        );
      },
    );
  }
}
