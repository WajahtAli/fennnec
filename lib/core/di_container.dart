import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:fennac_app/bloc/cubit/imagepicker_cubit.dart';
import 'package:fennac_app/bloc/cubit/wave_form_cubit.dart';
import 'package:fennac_app/core/network/api_helper.dart';
import 'package:fennac_app/helpers/shared_pref_helper.dart';
import 'package:fennac_app/pages/auth/data/datasources/create_account_datasource.dart';
import 'package:fennac_app/pages/auth/data/datasources/login_datasource.dart';
import 'package:fennac_app/pages/auth/data/repositories/create_account_repo_impl.dart';
import 'package:fennac_app/pages/auth/data/repositories/login_repo_impl.dart';
import 'package:fennac_app/pages/auth/domain/repositories/create_account_repo.dart';
import 'package:fennac_app/pages/auth/domain/repositories/login_repo.dart';
import 'package:fennac_app/pages/auth/domain/usecases/create_account_usecase.dart';
import 'package:fennac_app/pages/auth/domain/usecases/login_usecase.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/auth_cubit.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/create_account_cubit.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/login_cubit.dart';
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
import 'package:fennac_app/pages/profile/presentation/bloc/cubit/settings_cubit.dart';
import 'package:fennac_app/pages/profile/data/datasource/profile_datasource.dart';
import 'package:fennac_app/pages/profile/data/repository/profile_repository_impl.dart';
import 'package:fennac_app/pages/profile/domain/repository/profile_repository.dart';
import 'package:fennac_app/pages/profile/domain/usecase/profile_usecase.dart';
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
    sl.registerLazySingleton<HomeLandingDatasource>(
      () => HomeLandingDatasourceImpl(sl()),
    );

    // Repositories
    sl.registerLazySingleton<CreateAccountRepo>(
      () => CreateAccountRepoImpl(sl()),
    );
    sl.registerLazySingleton<LoginRepo>(() => LoginRepoImpl(sl()));
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
    sl.registerLazySingleton<HomeLandingRepository>(
      () => HomeLandingRepositoryImpl(sl()),
    );
    // sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(sl()));

    // Usecases

    sl.registerLazySingleton<CreateAccountUsecase>(
      () => CreateAccountUsecase(sl()),
    );
    sl.registerLazySingleton<LoginUsecase>(() => LoginUsecase(sl()));
    sl.registerLazySingleton<GroupsUsecase>(() => GroupsUsecase(sl()));
    sl.registerLazySingleton<CreateGroupUsecase>(
      () => CreateGroupUsecase(sl()),
    );
    sl.registerLazySingleton<FindGroupUsecase>(() => FindGroupUsecase(sl()));
    sl.registerLazySingleton<MyGroupUsecase>(() => MyGroupUsecase(sl()));
    sl.registerLazySingleton<ProfileUsecase>(() => ProfileUsecase(sl()));
    sl.registerLazySingleton<FetchGroupInvitationsUseCase>(
      () => FetchGroupInvitationsUseCase(sl()),
    );

    // Cubits
    sl.registerLazySingleton<AuthCubit>(() => AuthCubit());
    sl.registerLazySingleton<BackgroundCubit>(() => BackgroundCubit());
    sl.registerLazySingleton<ChatLandingCubit>(() => ChatLandingCubit());
    sl.registerLazySingleton<FilterCubit>(() => FilterCubit());
    sl.registerLazySingleton<KycCubit>(() => KycCubit());
    sl.registerLazySingleton<KycPromptCubit>(() => KycPromptCubit());
    sl.registerLazySingleton<ImagePickerCubit>(() => ImagePickerCubit());
    sl.registerLazySingleton<DashboardCubit>(() => DashboardCubit());
    sl.registerLazySingleton<HomeCubit>(() => HomeCubit());
    sl.registerLazySingleton<GroupsCubit>(() => GroupsCubit(sl()));
    sl.registerLazySingleton<LoginCubit>(() => LoginCubit(sl()));
    sl.registerLazySingleton<HomeLandingCubit>(() => HomeLandingCubit(sl()));
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
    sl.registerLazySingleton<CreateAccountCubit>(
      () => CreateAccountCubit(sl()),
    );
    sl.registerLazySingleton<SettingsCubit>(() => SettingsCubit());
    sl.registerLazySingleton<MyGroupCubit>(() => MyGroupCubit(sl()));
    sl.registerLazySingleton<GoogleMapCubit>(() => GoogleMapCubit());
    sl.registerLazySingleton<ContactListCubit>(() => ContactListCubit(sl()));
  }
}
