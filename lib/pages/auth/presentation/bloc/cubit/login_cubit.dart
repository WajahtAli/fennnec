import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/app_constants.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/core/notifications/push_notification_service.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/pages/auth/domain/usecases/login_usecase.dart';
import 'package:fennac_app/pages/auth/data/model/login_model.dart';
import 'package:fennac_app/pages/auth/data/datasources/login_datasource.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/auth_cubit.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/create_account_cubit.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/state/login_state.dart';
import 'package:fennac_app/pages/dashboard/presentation/bloc/cubit/dashboard_cubit.dart';
import 'package:fennac_app/pages/home/presentation/bloc/cubit/groups_cubit.dart';
import 'package:fennac_app/pages/homelanding/presentation/bloc/cubit/home_landing_cubit.dart';
import 'package:fennac_app/pages/my_group/presentation/bloc/cubit/my_group_cubit.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';

import '../../../../../helpers/shared_pref_helper.dart';
import '../../../../../reusable_widgets/session_dialog.dart';
import '../../../../home/presentation/screen/home_screen.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase _loginUsecase;

  LoginCubit(this._loginUsecase) : super(LoginInitial());

  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final otpController = TextEditingController();

  int validationCounter = 0;
  bool obscurePassword = true;
  LoginModel? loginModel;
  LoginModel? individualProfileModel;
  LoginData? userData;
  LoginData? individualProfileData;
  bool isLoading = false;
  final SharedPreferencesHelper sharedPreferencesHelper = Di()
      .sl<SharedPreferencesHelper>();

  Future<void> getSelfInfo() async {
    emit(LoginLoading());
    loginModel = await sharedPreferencesHelper.getUserData();
    userData = loginModel?.data;
    log('userData ${userData?.user}');
    emit(LoginLoaded());
  }

  Future<LoginModel> getProfile({required String userId}) async {
    emit(LoginLoading());
    try {
      final data = await _loginUsecase.getProfile(userId: userId);
      individualProfileModel = data;
      individualProfileData = data.data;
      emit(LoginLoaded());
      return data;
    } catch (e) {
      emit(LoginError(e.toString()));
      rethrow;
    }
  }

  bool _signingIn = false;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter a valid email address';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    // Check for uppercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for lowercase letter
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    // Check for digit
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit';
    }

    // Check for special character
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character (!@#\$%^&*)';
    }

    return null;
  }

  void togglePasswordVisibility() {
    emit(LoginValidationLoading());
    obscurePassword = !obscurePassword;
    emit(LoginValidation(validationCounter: validationCounter));
  }

  /// Extract message from API response or exception
  String? _extractMessage(dynamic data) {
    try {
      if (data is Map<String, dynamic>) {
        return data['message'] as String?;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Login with email or phone
  Future<void> login({required BuildContext context}) async {
    emit(LoginLoading());

    try {
      final data = await _loginUsecase.login(
        emailOrPhone: email.text.trim(),
        password: password.text.trim(),
      );

      loginModel = data;
      userData = data.data;

      await sharedPreferencesHelper.saveUserId(userData?.user?.id ?? '');
      await sharedPreferencesHelper.saveUserData(data);
      await sharedPreferencesHelper.saveAuthToken(userData?.accessToken ?? '');
      await sharedPreferencesHelper.saveRefreshToken(
        userData?.refreshToken ?? '',
      );

      // update token
      await PushNotificationService.init();

      VxToast.show(
        message: data.message ?? 'Login successful',
        icon: Assets.icons.checkGreen.path,
      );

      email.clear();
      password.clear();

      if (Di().sl<HomeLandingCubit>().invitations.isNotEmpty) {
        AutoRouter.of(context).replaceAll([DashboardRoute()]);
      } else {
        Di().sl<DashboardCubit>().changePage(0, HomeScreen());
        AutoRouter.of(context).replaceAll([DashboardRoute()]);
      }

      emit(LoginLoaded());
    } catch (e) {
      debugPrint(e.toString());

      if (e is LoginException) {
        emit(LoginError(e.message, isVerified: e.isVerified));
        VxToast.show(message: e.message);
        return;
      }

      emit(LoginError(e.toString()));
      VxToast.show(message: e.toString());
    }
  }

  void updateUserFromProfileModel(LoginUser updatedUser) async {
    emit(LoginLoading());
    if (loginModel?.data == null) return;

    final updatedData = loginModel?.data?.copyWith(user: updatedUser);
    loginModel = loginModel?.copyWith(data: updatedData);

    userData = updatedData;
    log("user data $updatedData");
    await sharedPreferencesHelper.saveUserData(loginModel!);

    emit(LoginLoaded());
  }

  /// Request password reset via email
  Future<void> requestPasswordReset(String emailAddress) async {
    isLoading = true;
    emit(LoginLoading());
    try {
      final response = await _loginUsecase.requestPasswordReset(
        method: "email",
        email: emailAddress,
      );
      final message = _extractMessage(response) ?? 'Password reset link sent';
      VxToast.show(message: message, icon: Assets.icons.checkGreen.path);
      isLoading = false;
      emit(PasswordResetSuccessState(emailAddress));
    } catch (e) {
      isLoading = false;
      emit(LoginError(e.toString()));
      VxToast.show(message: e.toString());
    }
  }

  /// Verify the password reset code
  Future<void> verifyResetCode({
    required String emailAddress,
    required String resetCode,
  }) async {
    isLoading = true;
    emit(LoginLoading());
    try {
      final response = await _loginUsecase.verifyResetCode(
        method: "email",
        email: emailAddress,
        resetCode: resetCode,
      );
      final message = _extractMessage(response) ?? 'Reset code verified';
      VxToast.show(message: message, icon: Assets.icons.checkGreen.path);
      resetCode = '';
      // otpController.clear();
      isLoading = false;
      emit(LoginLoaded());
    } catch (e) {
      isLoading = false;
      emit(LoginError(e.toString()));
      VxToast.show(message: e.toString());
    }
  }

  /// Reset password with new password
  Future<void> resetPassword({
    required String newPassword,
    required String email,
    required String resetCode,
    required BuildContext context,
  }) async {
    isLoading = true;
    emit(LoginLoading());
    try {
      final response = await _loginUsecase.resetPassword(
        method: "email",
        email: email,
        resetCode: resetCode,
        newPassword: newPassword,
      );
      final message = _extractMessage(response) ?? 'Password reset successful';
      VxToast.show(message: message, icon: Assets.icons.checkGreen.path);
      isLoading = false;
      AutoRouter.of(context).replace(OnBoardingRoute());
      otpController.clear();
      Di().sl<AuthCubit>().newPasswordController.clear();
      Di().sl<AuthCubit>().confirmNewPasswordController.clear();
      emit(LoginLoaded());
    } catch (e) {
      isLoading = false;
      emit(LoginError(e.toString()));
      VxToast.show(message: e.toString());
    }
  }

  /// Login with Google
  Future<void> loginWithGoogle({required BuildContext context}) async {
    if (_signingIn) return;
    _signingIn = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(24),

          child: SizedBox(
            width: 40,
            height: 40,
            child: Lottie.asset(
              Assets.animations.loadingSpinner,

              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );

    try {
      emit(LoginLoading());

      // 1️⃣ Ensure clean Google session
      await GoogleSignIn.instance.signOut();

      // 2️⃣ Initialize Google Sign-In with WEB client ID
      await GoogleSignIn.instance.initialize(
        serverClientId: AppConstants.googleClientId,
      );

      // 3️⃣ Google authentication
      final googleUser = await GoogleSignIn.instance.authenticate();
      final googleAuth = googleUser.authentication;

      final String? googleIdToken = googleAuth.idToken;
      if (googleIdToken == null || googleIdToken.isEmpty) {
        throw Exception('Missing Google ID token');
      }

      // 4️⃣ Sign in to Firebase using Google credential
      final credential = GoogleAuthProvider.credential(idToken: googleIdToken);

      await FirebaseAuth.instance.signInWithCredential(credential);

      // 5️⃣ Get FRESH Firebase ID token (this is what backend needs)
      final firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser == null) {
        throw Exception('Firebase user is null after sign-in');
      }

      final String firebaseIdToken = await firebaseUser.getIdToken(true) ?? '';

      // 6️⃣ Send Firebase ID token to backend
      final data = await _loginUsecase.loginUserByGoogle(
        accessToken: firebaseIdToken,
      );

      loginModel = data;
      userData = data.data;

      await sharedPreferencesHelper.saveUserId(userData?.user?.id ?? '');
      await sharedPreferencesHelper.saveUserData(data);
      await sharedPreferencesHelper.saveAuthToken(userData?.accessToken ?? '');

      Di().sl<DashboardCubit>().changeIndex(0);
      if (userData?.user?.sexualOrientation?.isEmpty ?? false) {
        Di().sl<CreateAccountCubit>().createdUser = userData?.user;
        AutoRouter.of(context).replaceAll([KycRoute()]);
      } else {
        AutoRouter.of(context).replaceAll([DashboardRoute()]);
      }

      emit(LoginLoaded());
      VxToast.show(
        message: data.message ?? 'Google sign-in successful',
        icon: Assets.icons.checkGreen.path,
      );
    } on GoogleSignInException catch (e, st) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        emit(LoginError('Cancelled by user'));
        VxToast.show(message: 'Cancelled by user');
      } else {
        debugPrint('❌ Google sign-in error [${e.code}]: ${e.description}\n$st');
        emit(LoginError(e.description ?? e.code.name));
        VxToast.show(message: e.description ?? 'Google sign-in failed');
      }
    } catch (e, st) {
      debugPrint('❌ Google sign-in error: $e\n$st');
      emit(LoginError(e.toString()));
      VxToast.show(message: e.toString());
    } finally {
      _signingIn = false;
      // Dismiss overlay loading dialog
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    }
  }

  /// Login with Apple
  Future<void> loginWithApple({required BuildContext context}) async {
    if (_signingIn) return;
    _signingIn = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            width: 40,
            height: 40,
            child: Lottie.asset(
              Assets.animations.loadingSpinner,

              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );

    try {
      emit(LoginLoading());

      // 1️⃣ Sign in with Apple via Firebase Auth
      final appleProvider = AppleAuthProvider()
        ..addScope('email')
        ..addScope('name');

      await FirebaseAuth.instance.signInWithProvider(appleProvider);

      // 2️⃣ Get Firebase user
      final firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser == null) {
        throw Exception('Firebase user is null after Apple sign-in');
      }

      // 3️⃣ Get FRESH Firebase ID token (same as Google)
      final String firebaseIdToken = await firebaseUser.getIdToken(true) ?? '';

      if (firebaseIdToken.isEmpty) {
        throw Exception('Missing Firebase ID token');
      }

      // 4️⃣ Send Firebase ID token to backend
      final data = await _loginUsecase.loginUserByApple(
        firebaseUserId: firebaseUser.uid,
      );

      loginModel = data;
      userData = data.data;

      await sharedPreferencesHelper.saveUserId(userData?.user?.id ?? '');
      await sharedPreferencesHelper.saveUserData(data);
      await sharedPreferencesHelper.saveAuthToken(userData?.accessToken ?? '');

      Di().sl<DashboardCubit>().changeIndex(0);
      if (userData?.user?.sexualOrientation?.isEmpty ?? false) {
        Di().sl<CreateAccountCubit>().createdUser = userData?.user;
        AutoRouter.of(context).replaceAll([KycRoute()]);
      } else {
        AutoRouter.of(context).replaceAll([DashboardRoute()]);
      }

      emit(LoginLoaded());
      VxToast.show(
        message: data.message ?? 'Apple sign-in successful',
        icon: Assets.icons.checkGreen.path,
      );
    } on FirebaseAuthException catch (e, st) {
      if (e.code == 'sign_in_canceled') {
        const message = 'Cancelled by user';
        debugPrint('Apple sign-in cancelled by user');
        emit(LoginError(message));
        VxToast.show(message: message);
      } else {
        debugPrint(
          '❌ Apple sign-in Firebase error [${e.code}]: ${e.message}\n$st',
        );
        emit(LoginError('Apple sign-in failed: ${e.code}'));
        VxToast.show(message: 'Apple sign-in failed');
      }
    } catch (e, st) {
      debugPrint('❌ Apple sign-in error: $e\n$st');
      emit(LoginError(e.toString()));
      VxToast.show(message: e.toString());
    } finally {
      _signingIn = false;
    }
  }

  /// Refresh authentication token
  Future<void> refreshAuthToken({required String refreshToken}) async {
    emit(LoginLoading());
    try {
      final data = await _loginUsecase.refreshToken(refreshToken: refreshToken);

      loginModel = data;
      userData = data.data;

      await sharedPreferencesHelper.saveUserData(data);
      await sharedPreferencesHelper.saveAuthToken(userData?.accessToken ?? '');

      // log('✅ Token refreshed successfully');

      emit(LoginLoaded());
      // VxToast.show(
      //   message: data.message ?? 'Token refreshed successfully',
      //   icon: Assets.icons.checkGreen.path,
      // );
    } catch (e) {
      //todo
      // emit(LoginError(e.toString()));
      // VxToast.show(message: e.toString());
    }
  }

  /// Logout user
  Future<void> logout(BuildContext context) async {
    emit(LoginLoading());
    try {
      final response = await _loginUsecase.logout();

      await sharedPreferencesHelper.clearUserData();
      await sharedPreferencesHelper.clearAuthToken();
      loginModel = null;
      userData = null;
      email.clear();
      phone.clear();
      password.clear();

      VxToast.show(
        message: response['message'] ?? 'Logged out successfully',
        icon: Assets.icons.checkGreen.path,
      );
      Di().sl<GroupsCubit>().clearGroupData();
      Di().sl<MyGroupCubit>().clearGroupData();
      emit(LoginLoaded());

      if (context.mounted) {
        AutoRouter.of(context).replaceAll([const OnBoardingRoute()]);
      }
    } catch (e) {
      emit(LoginError(e.toString()));
      VxToast.show(message: e.toString());
    }
  }

  Future<void> deleteAccount({required BuildContext context}) async {
    emit(LoginLoading());
    try {
      final response = await _loginUsecase.deleteAccount();

      await sharedPreferencesHelper.clearUserData();
      await sharedPreferencesHelper.clearAuthToken();
      loginModel = null;
      userData = null;
      email.clear();
      phone.clear();
      password.clear();

      VxToast.show(
        message: response['message'] ?? 'Account deleted successfully',
        icon: Assets.icons.checkGreen.path,
      );
      Di().sl<GroupsCubit>().clearGroupData();
      Di().sl<MyGroupCubit>().clearGroupData();
      emit(LoginLoaded());

      if (context.mounted) {
        AutoRouter.of(context).replaceAll([const OnBoardingRoute()]);
      }
    } catch (e) {
      emit(LoginError(e.toString()));
      VxToast.show(message: e.toString());
    }
  }

  /// Check if token is valid and not expired
  Future<void> checkToken(BuildContext context) async {
    emit(LoginLoading());
    try {
      final response = await _loginUsecase.checkToken();
      var shouldOpenDashboard = false;

      if (response is Map<String, dynamic>) {
        final data = response['data'] as Map<String, dynamic>? ?? {};
        final isValid = validateBool(data['valid']);
        final sessionActive = validateBool(data['sessionActive']);

        debugPrint(
          'Token check - Valid: $isValid, sessionActive: $sessionActive',
        );

        if (isValid && sessionActive) {
          shouldOpenDashboard = true;
        } else {
          if (context.mounted) {
            showSessionExpiredDialog(context);
          }
        }
      } else {
        refreshAuthToken(refreshToken: userData?.refreshToken ?? '');
        shouldOpenDashboard = true;
      }

      if (shouldOpenDashboard && context.mounted) {
        if (userData?.user?.sexualOrientation?.isEmpty ?? false) {
          Di().sl<CreateAccountCubit>().createdUser = userData?.user;
          AutoRouter.of(context).replaceAll([KycRoute()]);
        } else {
          AutoRouter.of(context).replaceAll([DashboardRoute()]);
        }
      }

      emit(LoginLoaded());
    } catch (e) {
      debugPrint('Error checking token: $e');
      emit(LoginError(e.toString()));
      // If there's an error checking token, logout and navigate to onboarding
      if (context.mounted) {
        logout(context);
      }
    }
  }

  Future<String> getLocationFromLatLng(
    String? latitude,
    String? longitude,
  ) async {
    if (latitude == null || longitude == null) return '';
    try {
      final lat = double.tryParse(latitude);
      final lng = double.tryParse(longitude);
      if (lat == null || lng == null) return '';

      final placemarks = await geocoding.placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final city = place.locality ?? '';
        final state = place.administrativeArea ?? '';
        if (city.isNotEmpty && state.isNotEmpty) {
          return '$city, $state';
        } else if (city.isNotEmpty) {
          return city;
        } else if (state.isNotEmpty) {
          return state;
        }
      }
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
    return '';
  }

  @override
  Future<void> close() {
    email.dispose();
    phone.dispose();
    password.dispose();
    return super.close();
  }
}
