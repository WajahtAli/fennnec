import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/helpers/shared_pref_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/widgets/movable_background.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/text_styles.dart';
import '../../../../routes/routes_imports.gr.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../../../../widgets/custom_text.dart';
import '../../../auth/presentation/bloc/cubit/login_cubit.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _lottieController;
  late final AnimationController _textController;

  late final Animation<Offset> _textSlideAnimation;
  late final Animation<Offset> _logoSlideAnimation;
  late final Animation<double> _textFadeAnimation;

  late final AnimationController _logoController;
  late final Animation<Offset> _logoAndTextSlideAnimation;
  late final Animation<double> _logoScaleAnimation;
  late final AnimationController _welcomeController;
  late final Animation<double> _welcomeScaleAnimation;

  late final Animation<Offset> _buttonSlideAnimation;
  late final SharedPreferencesHelper sharedPreferencesHelper = Di()
      .sl<SharedPreferencesHelper>();

  @override
  void initState() {
    super.initState();

    _lottieController = AnimationController(vsync: this);

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _textSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero).animate(
          CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
        );

    _logoSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
        );

    _logoAndTextSlideAnimation =
        Tween<Offset>(
          begin: const Offset(0, 0),
          end: const Offset(0, -0.65),
        ).animate(
          CurvedAnimation(parent: _logoController, curve: Curves.easeOutCubic),
        );

    _textFadeAnimation = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    );

    _logoScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.5,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeOut));

    _welcomeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _welcomeScaleAnimation = Tween<double>(begin: 10, end: 1).animate(
      CurvedAnimation(parent: _welcomeController, curve: Curves.easeOut),
    );

    _buttonSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _welcomeController,
            curve: Curves.easeOutCubic,
          ),
        );

    _startAnimationFlow();
  }

  Future<void> _startAnimationFlow() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    // Lottie (if duration set)
    if (_lottieController.duration != null) {
      await _lottieController.forward();
    }

    // Text animations (slide + fade + logo slide)
    await _textController.forward();
    if (!mounted) return;

    // Logo animations (scale + move up)
    await _logoController.forward();
    if (!mounted) return;

    // Welcome + button animations
    await _welcomeController.forward();
    if (!mounted) return;

    // NOW everything is fully finished
    final userToken = sharedPreferencesHelper.getAuthToken();

    log('User token in Splash Screen: $userToken');

    if (userToken != null && userToken.isNotEmpty) {
      await Di().sl<LoginCubit>().checkToken(context);
    }
  }

  @override
  void dispose() {
    _lottieController.dispose();
    _textController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MovableBackground(
        backgroundType: MovableBackgroundType.light,
        forceShowBackground: true,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              /// 1️⃣ BACKGROUND / WELCOME ANIMATION (UNDER EVERYTHING)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                left: 0,
                right: 0,
                top: _logoAndTextSlideAnimation.value.dy + 50,
                child: ScaleTransition(
                  scale: _welcomeScaleAnimation,
                  child: Lottie.asset(
                    Assets.animations.welcomeScreenAnimationRoadNoShadowDashed,
                    repeat: true,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /// 2️⃣ LOGO + TEXT (ABOVE)
              SlideTransition(
                position: _logoAndTextSlideAnimation,
                child: ScaleTransition(
                  scale: _logoScaleAnimation,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SlideTransition(
                        position: _logoSlideAnimation,
                        child: Lottie.asset(
                          Assets.animations.fennecLogoAnimation,
                          controller: _lottieController,
                          repeat: false,
                          fit: BoxFit.contain,
                          onLoaded: (composition) {
                            _lottieController
                              ..duration = composition.duration
                              ..forward();
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      FadeTransition(
                        opacity: _textFadeAnimation,
                        child: SlideTransition(
                          position: _textSlideAnimation,
                          child: SvgPicture.asset(
                            Assets.icons.fennecLogoText.path,
                            width: 210,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (sharedPreferencesHelper.getAuthToken() == null ||
                  (sharedPreferencesHelper.getAuthToken()?.isEmpty ?? false))
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  bottom: 10,
                  child: SlideTransition(
                    position: _buttonSlideAnimation,
                    child: Column(
                      children: [
                        AppText(
                          text: 'Find your vibe\n-\ttogether.',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.h1(
                            context,
                          ).copyWith(color: ColorPalette.textPrimary),
                        ),
                        SizedBox(height: 72.h),
                        CustomElevatedButton(
                          width: 0.9.sw,
                          text: 'Get Started',
                          onTap: () {
                            AutoRouter.of(
                              context,
                            ).replace(const LandingRoute());
                          },
                          icon: Assets.icons.arrowRight.svg(
                            width: 18,
                            height: 18,
                            colorFilter: ColorFilter.mode(
                              ColorPalette.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
