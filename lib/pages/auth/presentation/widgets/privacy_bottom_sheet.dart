import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:fennac_app/widgets/html_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/legal_content_cubit.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/state/legal_content_state.dart';

class PrivacyBottomSheet extends StatefulWidget {
  final ValueNotifier<bool>? blurNotifier;

  const PrivacyBottomSheet({super.key, this.blurNotifier});

  static void show(BuildContext context, {ValueNotifier<bool>? blurNotifier}) {
    blurNotifier?.value = true;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PrivacyBottomSheet(blurNotifier: blurNotifier),
    ).then((_) {
      blurNotifier?.value = false;
    });
  }

  @override
  State<PrivacyBottomSheet> createState() => _PrivacyBottomSheetState();
}

class _PrivacyBottomSheetState extends State<PrivacyBottomSheet> {
  final LegalContentCubit _legalContentCubit = Di().sl<LegalContentCubit>();

  @override
  void initState() {
    super.initState();
    _legalContentCubit.fetchLegalContents(termOfService: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        gradient: isDarkTheme(context)
            ? LinearGradient(
                colors: [ColorPalette.secondary, ColorPalette.black],

                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            : null,
        color: isLightTheme(context) ? Colors.white : null,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: 'Privacy Policy',
                  style: AppTextStyles.h1(context).copyWith(
                    color: isLightTheme(context) ? Colors.black : Colors.white,
                    fontSize: 24,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: SvgPicture.asset(
                    Assets.icons.cancel.path,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      isLightTheme(context) ? Colors.black : Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<LegalContentCubit, LegalContentState>(
              bloc: _legalContentCubit,
              builder: (context, state) {
                final legalContents =
                    _legalContentCubit.legalContentModel?.data?.legalContent ??
                    [];

                final htmlContent = legalContents.isNotEmpty
                    ? (legalContents.first.content ?? '')
                    : '';

                if (state is LegalContentLoading && htmlContent.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is LegalContentError && htmlContent.isEmpty) {
                  return Center(child: _buildText(context, state.message));
                }

                if (htmlContent.isEmpty) {
                  return Center(
                    child: _buildText(
                      context,
                      'No privacy policy content available.',
                    ),
                  );
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: HtmlViewer(htmlContent: htmlContent),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildText(BuildContext context, String text) {
    return AppText(text: text, style: AppTextStyles.body(context));
  }
}
