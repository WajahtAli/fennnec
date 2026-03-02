part of 'routes_imports.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey});
  @override
  List<AutoRoute> get routes => [
    CustomRoute(
      page: SplashRoute.page,
      initial: true,
      transitionsBuilder: AppTransitions.fade,
      opaque: true,
      duration: const Duration(milliseconds: 300),
    ),

    CustomRoute(
      page: LandingRoute.page,
      opaque: true,
      transitionsBuilder: AppTransitions.noTransition,
    ),

    CustomRoute(
      page: DashboardRoute.page,
      // initial: true,
      opaque: true,
      transitionsBuilder: AppTransitions.noTransition,
    ),

    CustomRoute(
      page: HomeRoute.page,
      transitionsBuilder: AppTransitions.fade,
      opaque: true,
      duration: const Duration(milliseconds: 300),
    ),

    CustomRoute(
      page: HomeLandingRoute.page,
      transitionsBuilder: AppTransitions.fade,
      opaque: true,
      duration: const Duration(milliseconds: 300),
    ),

    CustomRoute(
      page: ChatLandingRoute.page,
      transitionsBuilder: AppTransitions.fade,
      opaque: true,
      duration: const Duration(milliseconds: 300),
    ),

    CustomRoute(
      page: GroupChatRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 400),
    ),

    CustomRoute(
      page: GroupDetailRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 400),
    ),

    CustomRoute(
      page: CreateGroupRoute.page,
      transitionsBuilder: AppTransitions.fade,
      opaque: true,
      duration: const Duration(milliseconds: 300),
    ),

    CustomRoute(
      page: FindGroupRoute.page,
      transitionsBuilder: AppTransitions.fade,
      opaque: true,
      duration: const Duration(milliseconds: 300),
    ),

    CustomRoute(
      page: LoginRoute.page,
      transitionsBuilder: AppTransitions.slideUp,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),

    CustomRoute(
      page: ResetPasswordRoute.page,
      transitionsBuilder: AppTransitions.fade,
      opaque: true,
      duration: const Duration(milliseconds: 300),
    ),

    CustomRoute(
      page: OtpVerificationRoute.page,
      transitionsBuilder: AppTransitions.fade,
      opaque: true,
      duration: const Duration(milliseconds: 300),
    ),

    CustomRoute(
      page: SetNewPasswordRoute.page,
      transitionsBuilder: AppTransitions.fade,
      opaque: true,
      duration: const Duration(milliseconds: 300),
    ),

    CustomRoute(
      page: CreateAccountRoute.page,
      transitionsBuilder: AppTransitions.slideUp,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),

    CustomRoute(
      page: OnBoardingRoute.page,
      transitionsBuilder: AppTransitions.fade,
      opaque: true,
      duration: const Duration(milliseconds: 600),
    ),

    CustomRoute(
      page: VerifyPhoneNumberRoute.page,
      transitionsBuilder: AppTransitions.slideUp,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),

    CustomRoute(
      page: OnBoardingRoute1.page,
      transitionsBuilder: AppTransitions.fade,
      opaque: true,
      duration: const Duration(milliseconds: 300),
    ),

    CustomRoute(
      page: KycRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 400),
    ),

    CustomRoute(
      page: KycDetailsRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),

    CustomRoute(
      page: KycGalleryRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),

    CustomRoute(
      page: KycMatchRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),

    CustomRoute(
      page: KycPromptRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),

    CustomRoute(
      page: FilterRoute.page,
      transitionsBuilder: AppTransitions.slideUp,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),

    CustomRoute(
      page: DistanceRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 400),
    ),

    CustomRoute(
      page: AddMemberRoute.page,
      transitionsBuilder: AppTransitions.slideUp,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      page: CreateGroupGalleryRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      page: CallRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      page: AudioCallRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      page: VideoCallRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      page: ProfileRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      page: EditPublicProfileRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      page: BuyPokeRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      page: YourGroupsRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      page: ChangeEmailPhoneRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      page: ChangePasswordRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      page: NotificationSettingsRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      page: PrivacyPermissionsRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      page: ManageSubscriptionsRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      page: HelpSupportRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      page: ReportProblemRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      page: GetPockedRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      page: GroupAudioCallRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      page: MediaPreviewRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      page: FaqRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      page: ContactSupportRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      page: MyGroupRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
    CustomRoute(
      page: EditGroupRoute.page,
      transitionsBuilder: AppTransitions.slideRight,
      opaque: true,
      duration: const Duration(milliseconds: 500),
    ),
  ];
}
