import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:fennac_app/bloc/cubit/imagepicker_cubit.dart';
import 'package:fennac_app/bloc/cubit/wave_form_cubit.dart';
import 'package:fennac_app/core/network/api_helper.dart';
import 'package:fennac_app/helpers/shared_pref_helper.dart';
import 'package:fennac_app/pages/auth/data/datasources/create_account_datasource.dart';
import 'package:fennac_app/pages/auth/data/datasources/legal_content_datasource.dart';
import 'package:fennac_app/pages/auth/data/datasources/login_datasource.dart';
import 'package:fennac_app/pages/auth/data/repositories/create_account_repo_impl.dart';
import 'package:fennac_app/pages/auth/data/repositories/legal_content_repo_impl.dart';
import 'package:fennac_app/pages/auth/data/repositories/login_repo_impl.dart';
import 'package:fennac_app/pages/auth/domain/repositories/create_account_repo.dart';
import 'package:fennac_app/pages/auth/domain/repositories/legal_content_repo.dart';
import 'package:fennac_app/pages/auth/domain/repositories/login_repo.dart';
import 'package:fennac_app/pages/auth/domain/usecases/create_account_usecase.dart';
import 'package:fennac_app/pages/auth/domain/usecases/legal_content_usecase.dart';
import 'package:fennac_app/pages/auth/domain/usecases/login_usecase.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/auth_cubit.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/create_account_cubit.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/legal_content_cubit.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/login_cubit.dart';
import 'package:fennac_app/pages/buy_poke/data/datasource/poke_datasource.dart';
import 'package:fennac_app/pages/buy_poke/data/repository/poke_repository_impl.dart';
import 'package:fennac_app/pages/buy_poke/domain/repository/poke_repository.dart';
import 'package:fennac_app/pages/buy_poke/domain/usecase/fetch_pokes_usecase.dart';
import 'package:fennac_app/pages/buy_poke/domain/usecase/send_poke_usecase.dart';
import 'package:fennac_app/pages/buy_poke/presentation/bloc/cubit/poke_cubit.dart';
import 'package:fennac_app/pages/call/presentation/bloc/cubit/call_cubit.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/cubit/chat_landing_cubit.dart';
import 'package:fennac_app/pages/chats/presentation/bloc/cubit/message_cubit.dart';
import 'package:fennac_app/pages/create_group/data/datasource/create_group_datasource.dart';
import 'package:fennac_app/pages/create_group/data/repository/create_group_repository_impl.dart';
import 'package:fennac_app/pages/create_group/domain/repository/create_group_repository.dart';
import 'package:fennac_app/pages/create_group/domain/usecase/create_group_usecase.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/cubit/contact_list_cubit.dart';
import 'package:fennac_app/pages/dashboard/presentation/bloc/cubit/dashboard_cubit.dart';
import 'package:fennac_app/pages/filter/presentation/bloc/cubit/google_map_cubit.dart';
import 'package:fennac_app/pages/find_group/data/datasource/find_group_datasource.dart';
import 'package:fennac_app/pages/find_group/data/repository/find_group_repository_impl.dart';
import 'package:fennac_app/pages/find_group/domain/repository/find_group_repository.dart';
import 'package:fennac_app/pages/find_group/domain/usecase/find_group_usecase.dart';
import 'package:fennac_app/pages/find_group/presentation/bloc/cubit/find_group_cubit.dart';
import 'package:fennac_app/pages/filter/presentation/bloc/cubit/filter_cubit.dart';
import 'package:fennac_app/pages/home/data/datasource/groups_datasource.dart';
import 'package:fennac_app/pages/home/data/repository/groups_repository_impl.dart';
import 'package:fennac_app/pages/home/presentation/bloc/cubit/home_cubit.dart';
import 'package:fennac_app/pages/homelanding/data/datasource/home_landing_datasource.dart';
import 'package:fennac_app/pages/homelanding/data/repository/home_landing_repository_impl.dart';
import 'package:fennac_app/pages/homelanding/domain/repository/home_landing_repository.dart';
import 'package:fennac_app/pages/homelanding/domain/usecase/fetch_group_invitations_usecase.dart';
import 'package:fennac_app/pages/homelanding/domain/usecase/accept_decline_group_invitation_usecase.dart';
import 'package:fennac_app/pages/homelanding/presentation/bloc/cubit/home_landing_cubit.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/cubit/create_group_cubit.dart';
import 'package:fennac_app/pages/kyc/presentation/bloc/cubit/kyc_cubit.dart';
import 'package:fennac_app/pages/kyc/presentation/bloc/cubit/kyc_prompt_cubit.dart';
import 'package:fennac_app/pages/my_group/data/datasource/my_group_datasource.dart';
import 'package:fennac_app/pages/my_group/data/repository/my_group_repository_impl.dart';
import 'package:fennac_app/pages/my_group/domain/repository/my_group_repository.dart';
import 'package:fennac_app/pages/my_group/domain/usecase/my_group_usecase.dart';
import 'package:fennac_app/pages/my_group/presentation/bloc/cubit/my_group_cubit.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/cubit/profile_cubit.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/cubit/privacy_permission_cubit.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/cubit/notification_settings_cubit.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/cubit/settings_cubit.dart';
import 'package:fennac_app/pages/profile/data/datasource/profile_datasource.dart';
import 'package:fennac_app/pages/profile/data/datasource/privacy_permission_datasource.dart';
import 'package:fennac_app/pages/profile/data/datasource/notification_settings_datasource.dart';
import 'package:fennac_app/pages/profile/data/repository/privacy_permission_repository_impl.dart';
import 'package:fennac_app/pages/profile/data/repository/notification_settings_repository_impl.dart';
import 'package:fennac_app/pages/profile/domain/repository/privacy_permission_repository.dart';
import 'package:fennac_app/pages/profile/domain/repository/notification_settings_repository.dart';
import 'package:fennac_app/pages/profile/domain/usecase/privacy_permission_usecase.dart';
import 'package:fennac_app/pages/profile/domain/usecase/notification_settings_usecase.dart';
import 'package:fennac_app/pages/profile/data/repository/profile_repository_impl.dart';
import 'package:fennac_app/pages/profile/domain/repository/profile_repository.dart';
import 'package:fennac_app/pages/profile/domain/usecase/profile_usecase.dart';
import 'package:fennac_app/pages/profile/data/datasource/contact_support_datasource.dart';
import 'package:fennac_app/pages/profile/data/repository/contact_support_repository_impl.dart';
import 'package:fennac_app/pages/profile/domain/repository/contact_support_repository.dart';
import 'package:fennac_app/pages/profile/domain/usecase/contact_support_usecase.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/cubit/contact_support_cubit.dart';
import 'package:fennac_app/pages/profile/data/datasource/faqs_datasource.dart';
import 'package:fennac_app/pages/profile/data/repository/faqs_repository_impl.dart';
import 'package:fennac_app/pages/profile/domain/repository/faqs_repository.dart';
import 'package:fennac_app/pages/profile/domain/usecase/faqs_usecase.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/cubit/faqs_cubit.dart';
import 'package:fennac_app/pages/profile/data/datasource/report_problem_datasource.dart';
import 'package:fennac_app/pages/profile/data/repository/report_problem_repository_impl.dart';
import 'package:fennac_app/pages/profile/domain/repository/report_problem_repository.dart';
import 'package:fennac_app/pages/profile/domain/usecase/report_problem_usecase.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/cubit/report_problem_cubit.dart';
import 'package:fennac_app/pages/splash/presentation/bloc/cubit/background_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/cubit/background_cubit.dart';
import '../pages/home/domain/repository/groups_repository.dart'
    show GroupsRepository;
import '../pages/home/domain/usecase/groups_usecase.dart';
import '../pages/home/presentation/bloc/cubit/groups_cubit.dart';

class Di {
  // Groups Feature

  final sl = GetIt.I;

  Future<void> init() async {
    // External / controllers
    sl.registerLazySingleton<WaveformExtractionController>(
      () => WaveformExtractionController(),
    );

    // helpers
    sl.registerLazySingleton<ApiHelper>(() => ApiHelper());
    sl.registerLazySingleton<SharedPreferencesHelper>(
      () => SharedPreferencesHelper(sl()),
    );
    sl.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance(),
    );

    // Datasources

    sl.registerLazySingleton<CreateAccountDatasource>(
      () => CreateAccountDatasourceImpl(sl()),
    );
    sl.registerLazySingleton<GroupsDataSource>(
      () => GroupsDataSourceImpl(sl()),
    );
    sl.registerLazySingleton<LoginDatasource>(() => LoginDatasourceImpl(sl()));
    sl.registerLazySingleton<LegalContentDatasource>(
      () => LegalContentDatasourceImpl(sl()),
    );
    sl.registerLazySingleton<CreateGroupDatasource>(
      () => CreateGroupDatasourceImpl(sl()),
    );
    sl.registerLazySingleton<FindGroupDatasource>(
      () => FindGroupDatasourceImpl(sl()),
    );
    sl.registerLazySingleton<MyGroupDatasource>(
      () => MyGroupDatasourceImpl(sl()),
    );
    sl.registerLazySingleton<ProfileDatasource>(
      () => ProfileDatasourceImpl(sl()),
    );
    sl.registerLazySingleton<PrivacyPermissionDatasource>(
      () => PrivacyPermissionDatasourceImpl(sl()),
    );
    sl.registerLazySingleton<NotificationSettingsDatasource>(
      () => NotificationSettingsDatasourceImpl(sl()),
    );
    sl.registerLazySingleton<ContactSupportDatasource>(
      () => ContactSupportDatasourceImpl(sl()),
    );
    sl.registerLazySingleton<FaqsDatasource>(() => FaqsDatasourceImpl(sl()));
    sl.registerLazySingleton<ReportProblemDatasource>(
      () => ReportProblemDatasourceImpl(sl()),
    );
    sl.registerLazySingleton<HomeLandingDatasource>(
      () => HomeLandingDatasourceImpl(sl()),
    );
    sl.registerLazySingleton<PokeDatasource>(() => PokeDatasourceImpl(sl()));

    // Repositories
    sl.registerLazySingleton<CreateAccountRepo>(
      () => CreateAccountRepoImpl(sl()),
    );
    sl.registerLazySingleton<LoginRepo>(() => LoginRepoImpl(sl()));
    sl.registerLazySingleton<LegalContentRepo>(
      () => LegalContentRepoImpl(sl()),
    );
    sl.registerLazySingleton<GroupsRepository>(
      () => GroupsRepositoryImpl(sl()),
    );
    sl.registerLazySingleton<CreateGroupRepository>(
      () => CreateGroupRepositoryImpl(sl()),
    );
    sl.registerLazySingleton<FindGroupRepository>(
      () => FindGroupRepositoryImpl(sl()),
    );
    sl.registerLazySingleton<MyGroupRepository>(
      () => MyGroupRepositoryImpl(sl()),
    );
    sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(sl()),
    );
    sl.registerLazySingleton<PrivacyPermissionRepository>(
      () => PrivacyPermissionRepositoryImpl(sl()),
    );
    sl.registerLazySingleton<NotificationSettingsRepository>(
      () => NotificationSettingsRepositoryImpl(sl()),
    );
    sl.registerLazySingleton<ContactSupportRepository>(
      () => ContactSupportRepositoryImpl(sl()),
    );
    sl.registerLazySingleton<FaqsRepository>(() => FaqsRepositoryImpl(sl()));
    sl.registerLazySingleton<ReportProblemRepository>(
      () => ReportProblemRepositoryImpl(sl()),
    );
    sl.registerLazySingleton<HomeLandingRepository>(
      () => HomeLandingRepositoryImpl(sl()),
    );
    sl.registerLazySingleton<PokeRepository>(() => PokeRepositoryImpl(sl()));

    // sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(sl()));

    // Usecases

    sl.registerLazySingleton<CreateAccountUsecase>(
      () => CreateAccountUsecase(sl()),
    );
    sl.registerLazySingleton<LoginUsecase>(() => LoginUsecase(sl()));
    sl.registerLazySingleton<LegalContentUsecase>(
      () => LegalContentUsecase(sl()),
    );
    sl.registerLazySingleton<GroupsUsecase>(() => GroupsUsecase(sl()));
    sl.registerLazySingleton<CreateGroupUsecase>(
      () => CreateGroupUsecase(sl()),
    );
    sl.registerLazySingleton<FindGroupUsecase>(() => FindGroupUsecase(sl()));
    sl.registerLazySingleton<MyGroupUsecase>(() => MyGroupUsecase(sl()));
    sl.registerLazySingleton<ProfileUsecase>(() => ProfileUsecase(sl()));
    sl.registerLazySingleton<PrivacyPermissionUsecase>(
      () => PrivacyPermissionUsecase(sl()),
    );
    sl.registerLazySingleton<NotificationSettingsUsecase>(
      () => NotificationSettingsUsecase(sl()),
    );
    sl.registerLazySingleton<ContactSupportUsecase>(
      () => ContactSupportUsecase(sl()),
    );
    sl.registerLazySingleton<FaqsUsecase>(() => FaqsUsecase(sl()));
    sl.registerLazySingleton<ReportProblemUsecase>(
      () => ReportProblemUsecase(sl()),
    );
    sl.registerLazySingleton<FetchGroupInvitationsUseCase>(
      () => FetchGroupInvitationsUseCase(sl()),
    );
    sl.registerLazySingleton<AcceptDeclineGroupInvitationUseCase>(
      () => AcceptDeclineGroupInvitationUseCase(sl()),
    );
    sl.registerLazySingleton<FetchPokesUseCase>(() => FetchPokesUseCase(sl()));
    sl.registerLazySingleton<SendPokeUseCase>(() => SendPokeUseCase(sl()));

    // Cubits
    sl.registerLazySingleton<AuthCubit>(() => AuthCubit());
    sl.registerLazySingleton<BackgroundCubit>(() => BackgroundCubit());
    sl.registerLazySingleton<ChatLandingCubit>(() => ChatLandingCubit());
    sl.registerLazySingleton<FilterCubit>(() => FilterCubit());
    sl.registerLazySingleton<KycCubit>(() => KycCubit());
    sl.registerLazySingleton<KycPromptCubit>(() => KycPromptCubit());
    sl.registerLazySingleton<ImagePickerCubit>(() => ImagePickerCubit());
    sl.registerLazySingleton<DashboardCubit>(() => DashboardCubit());
    sl.registerLazySingleton<HomeCubit>(() => HomeCubit(sl()));
    sl.registerLazySingleton<GroupsCubit>(() => GroupsCubit(sl()));
    sl.registerLazySingleton<LoginCubit>(() => LoginCubit(sl()));
    sl.registerLazySingleton<LegalContentCubit>(() => LegalContentCubit(sl()));
    sl.registerLazySingleton<HomeLandingCubit>(
      () => HomeLandingCubit(sl(), sl()),
    );
    sl.registerLazySingleton<CreateGroupCubit>(() => CreateGroupCubit(sl()));
    sl.registerLazySingleton<FindGroupCubit>(() => FindGroupCubit(sl()));
    sl.registerLazySingleton<MoveAbleBackgroundCubit>(
      () => MoveAbleBackgroundCubit(),
    );
    sl.registerLazySingleton<WaveformCubit>(
      () => WaveformCubit(sl<WaveformExtractionController>()),
    );
    sl.registerLazySingleton<MessageCubit>(() => MessageCubit(sl()));
    sl.registerLazySingleton<CallCubit>(() => CallCubit());
    sl.registerLazySingleton<ProfileCubit>(() => ProfileCubit(sl()));
    sl.registerLazySingleton<PrivacyPermissionCubit>(
      () => PrivacyPermissionCubit(sl()),
    );
    sl.registerLazySingleton<NotificationSettingsCubit>(
      () => NotificationSettingsCubit(sl()),
    );
    sl.registerLazySingleton<ContactSupportCubit>(
      () => ContactSupportCubit(sl()),
    );
    sl.registerLazySingleton<FaqsCubit>(() => FaqsCubit(sl()));
    sl.registerLazySingleton<ReportProblemCubit>(
      () => ReportProblemCubit(sl()),
    );
    sl.registerLazySingleton<CreateAccountCubit>(
      () => CreateAccountCubit(sl()),
    );
    sl.registerLazySingleton<SettingsCubit>(() => SettingsCubit());
    sl.registerLazySingleton<MyGroupCubit>(() => MyGroupCubit(sl()));
    sl.registerLazySingleton<GoogleMapCubit>(() => GoogleMapCubit());
    sl.registerLazySingleton<ContactListCubit>(() => ContactListCubit(sl()));
    sl.registerLazySingleton<PokeCubit>(() => PokeCubit(sl()));
  }
}
