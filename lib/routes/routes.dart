part of 'routes_imports.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey});
  @override
  List<AutoRoute> get routes => [
    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: SplashRoute.page,
      initial: true,
      transitionsBuilder: AppTransitions.fade,
      opaque: true,
      duration: const Duration(milliseconds: 300),
    ),

    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: LandingRoute.page,
      opaque: true,
      transitionsBuilder: AppTransitions.noTransition,
    ),

    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: DashboardRoute.page,
      // initial: true,
      opaque: true,
      transitionsBuilder: AppTransitions.noTransition,
    ),

    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: HomeRoute.page,
      transitionsBuilder: AppTransitions.fade,
      opaque: true,
      duration: const Duration(milliseconds: 300),
    ),

    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: HomeLandingRoute.page,
      transitionsBuilder: AppTransitions.fade,
      opaque: true,
      duration: const Duration(milliseconds: 300),
    ),

    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: ChatLandingRoute.page,
      transitionsBuilder: AppTransitions.fade,
      opaque: true,
      duration: const Duration(milliseconds: 300),
    ),

    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: GroupChatRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 400),
    ),

    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: GroupDetailRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 400),
    ),

    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: CreateGroupRoute.page,
      transitionsBuilder: AppTransitions.fade,
      opaque: true,
      duration: const Duration(milliseconds: 300),
    ),

    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: FindGroupRoute.page,
      transitionsBuilder: AppTransitions.fade,
      opaque: true,
      duration: const Duration(milliseconds: 300),
    ),

    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: LoginRoute.page,
      transitionsBuilder: AppTransitions.slideUp,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),

    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: ResetPasswordRoute.page,
      transitionsBuilder: AppTransitions.fade,
      opaque: true,
      duration: const Duration(milliseconds: 300),
    ),

    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: OtpVerificationRoute.page,
      transitionsBuilder: AppTransitions.fade,
      opaque: true,
      duration: const Duration(milliseconds: 300),
    ),

    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: SetNewPasswordRoute.page,
      transitionsBuilder: AppTransitions.fade,
      opaque: true,
      duration: const Duration(milliseconds: 300),
    ),

    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: CreateAccountRoute.page,
      transitionsBuilder: AppTransitions.slideUp,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),

    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: OnBoardingRoute.page,
      transitionsBuilder: AppTransitions.fade,
      opaque: true,
      duration: const Duration(milliseconds: 600),
    ),

    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: VerifyPhoneNumberRoute.page,
      transitionsBuilder: AppTransitions.slideUp,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),

    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: OnBoardingRoute1.page,
      transitionsBuilder: AppTransitions.fade,
      opaque: true,
      duration: const Duration(milliseconds: 300),
    ),

    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: KycRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 400),
    ),

    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: KycDetailsRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),

    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: KycGalleryRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),

    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: KycMatchRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),

    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: KycPromptRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),

    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: FilterRoute.page,
      transitionsBuilder: AppTransitions.slideUp,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),

    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: DistanceRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 400),
    ),

    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: AddMemberRoute.page,
      transitionsBuilder: AppTransitions.slideUp,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: CreateGroupGalleryRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: CallRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: AudioCallRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: VideoCallRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: ProfileRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: EditPublicProfileRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: BuyPokeRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: YourGroupsRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: ChangeEmailPhoneRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: ChangePasswordRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: NotificationSettingsRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: PrivacyPermissionsRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: ManageSubscriptionsRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: HelpSupportRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: ReportProblemRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: GetPockedRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: GroupAudioCallRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: MediaPreviewRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: FaqRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: ContactSupportRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: MyGroupRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: EditGroupRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      customRouteBuilder: AppTransitions.platformRouteBuilder,
      page: CreateGroupLocationRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
  ];
}
