import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/app_emojis.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/buy_poke/presentation/bloc/cubit/poke_cubit.dart';
import 'package:fennac_app/pages/buy_poke/presentation/bloc/state/poke_state.dart';
import 'package:fennac_app/pages/buy_poke/presentation/widgets/poke_pack_tile.dart';
import 'package:fennac_app/reusable_widgets/animated_background_container.dart';
import 'package:fennac_app/reusable_widgets/custom_app_bar.dart';
import 'package:fennac_app/skeletons/poke_pack_skeleton.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/custom_text.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class BuyPokeScreen extends StatefulWidget {
  const BuyPokeScreen({super.key});

  @override
  State<BuyPokeScreen> createState() => _BuyPokeScreenState();
}

class _BuyPokeScreenState extends State<BuyPokeScreen> {
  final PokeCubit _pokeCubit = Di().sl<PokeCubit>();

  @override
  void initState() {
    super.initState();
    _pokeCubit.fetchPokes();
  }

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
                BlocBuilder<PokeCubit, PokeState>(
                  bloc: _pokeCubit,
                  builder: (context, state) {
                    if (state is PokeLoading &&
                        _pokeCubit.isPurchasing == false) {
                      return const PokePackSkeleton(itemCount: 3);
                    }
                    if (state is PokeError) {
                      return AppText(
                        text: state.message ?? 'Unable to fetch poke products',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.body(
                          context,
                        ).copyWith(color: ColorPalette.error),
                      );
                    }

                    final products = _pokeCubit.pockModel?.data?.products ?? [];

                    if (products.isEmpty) {
                      return AppText(
                        text: 'No poke products available',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.body(context).copyWith(
                          color: isLightTheme(context)
                              ? ColorPalette.black
                              : ColorPalette.textSecondary,
                        ),
                      );
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      separatorBuilder: (context, index) =>
                          const CustomSizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return PokePackTile(
                          pokes: product.pokeCount ?? 0,
                          title: product.name ?? 'Poke Pack',
                          subtitle: 'Tap to purchase',
                          price:
                              '\$${(product.priceUsd ?? 0).toStringAsFixed(2)}',
                          onTap: () {
                            Di().sl<PokeCubit>().purchasePokes(
                              product.id ?? '',
                            );
                          },
                          isPurchasing:
                              _pokeCubit.isPurchasing &&
                              _pokeCubit.purchasingProductId == product.id,
                        );
                      },
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
