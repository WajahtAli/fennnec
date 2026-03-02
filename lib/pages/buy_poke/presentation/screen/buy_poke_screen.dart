import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/dummy_constants.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/app_emojis.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/pages/buy_poke/presentation/widgets/poke_pack_tile.dart';
import 'package:fennac_app/reusable_widgets/animated_background_container.dart';
import 'package:fennac_app/reusable_widgets/custom_app_bar.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';

@RoutePage()
class BuyPokeScreen extends StatelessWidget {
  const BuyPokeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.secondary,
      body: MovableBackground(
        backgroundType: MovableBackgroundType.dark,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomAppBar(title: 'Buy Pokes'),
                const CustomSizedBox(height: 24),
                AnimatedBackgroundContainer(
                  height: 140,
                  width: 140,
                  icon: AppEmojis.pointingRight,

                  isEmoji: true,
                ),
                const CustomSizedBox(height: 24),
                AppText(
                  text: 'Make Your Move with\nPokes',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h2(
                    context,
                  ).copyWith(fontWeight: FontWeight.w700),
                ),
                const CustomSizedBox(height: 16),
                AppText(
                  text:
                      'Pokes let you express direct interest. You can poke anyone without needing a group to match.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body(context).copyWith(
                    color: isLightTheme(context)
                        ? ColorPalette.black
                        : ColorPalette.textSecondary,
                  ),
                ),
                const CustomSizedBox(height: 32),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: DummyConstants.pokePacks.length,
                  separatorBuilder: (context, index) =>
                      const CustomSizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final pack = DummyConstants.pokePacks[index];
                    return PokePackTile(
                      pokes: pack.pokes,
                      title: pack.title,
                      subtitle: pack.subtitle,
                      price: pack.price,
                      onTap: () {},
                    );
                  },
                ),
                const CustomSizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
