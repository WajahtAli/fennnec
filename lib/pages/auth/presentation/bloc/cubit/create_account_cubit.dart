import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/helpers/shared_pref_helper.dart';
import 'package:fennac_app/pages/auth/domain/usecases/create_account_usecase.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/auth_cubit.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/login_cubit.dart'
    show LoginCubit;
import 'package:fennac_app/pages/auth/presentation/bloc/state/create_account_state.dart';
import 'package:fennac_app/pages/kyc/presentation/bloc/cubit/kyc_cubit.dart';
import 'package:fennac_app/pages/kyc/presentation/bloc/cubit/kyc_prompt_cubit.dart';
import 'package:fennac_app/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/cubit/imagepicker_cubit.dart';
import '../../../../../generated/assets.gen.dart';
import '../../../../../helpers/gradient_toast.dart';
import '../../../../../routes/routes_imports.gr.dart';
import '../../../data/model/login_model.dart';
import '../../widgets/verification_method_bottom_sheet.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  final CreateAccountUsecase _createAccountUsecase;
  CreateAccountCubit(this._createAccountUsecase)
    : super(CreateAccountInitial());

  // Media links storage
  List<String> mediaLinks = [];
  bool isLoading = false;
  final SharedPreferencesHelper sharedPreferencesHelper = Di()
      .sl<SharedPreferencesHelper>();
  final loginCubit = Di().sl<LoginCubit>();
  final kycPromptCubit = Di().sl<KycPromptCubit>();
  LoginUser? createdUser;
  bool isOtpVerify = false;

  Future<void> createAccount({
    final String? firstName,
    final String? lastName,
    final String? email,
    final String? phone,
    final String? countryCode,
    final String? password,
    required BuildContext context,
  }) async {
    isLoading = true;
    emit(CreateAccountLoading());

    try {
      await _createAccountUsecase.createAccount(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: normalizePhone(phone ?? ''),
        countryCode: countryCode,
        password: password,
      );
      // createdUser = user;
      isLoading = false;

      showBottomSheet(
        context: context,
        builder: (sheetContext) {
          return VerificationMethodBottomSheet(
            parentContext: context,
            phone: phone,
            email: email,
          );
        },
      );

      // AutoRouter.of(context).replace(VerifyPhoneNumberRoute());

      emit(CreateAccountLoaded());
    } catch (e) {
      String errorMsg = 'Failed to create account';
      if (e is Map<String, dynamic>) {
        errorMsg = e['message']?.toString() ?? errorMsg;
      } else if (e is Exception) {
        final msg = e.toString();
        final match = RegExp(r'message[":\s]+([^,}\]]+)').firstMatch(msg);
        if (match != null) {
          errorMsg = match.group(1)!;
        } else {
          errorMsg = msg;
        }
      } else {
        errorMsg = e.toString();
      }
      isLoading = false;
      VxToast.show(message: errorMsg);
      emit(CreateAccountError(errorMsg));
    }
  }

  /// Verify OTP code
  Future<void> verifyOtpCode(
    String otpCode,
    String phone,
    Function() onSuccess,
  ) async {
    isOtpVerify = true;
    emit(CreateAccountLoading());

    try {
      final LoginModel response = await _createAccountUsecase.verifyCode(
        phone: normalizePhone(phone),
        verificationCode: otpCode,
      );

      if (response.data == null || response.data!.accessToken == null) {
        emit(CreateAccountError("Invalid verification response"));
        return;
      }

      final token = response.data?.accessToken ?? '';
      await sharedPreferencesHelper.saveUserData(response);
      await sharedPreferencesHelper.saveAuthToken(token);

      log('✅ User logged in: ${response.data!.user!.firstName}');

      loginCubit.updateUserFromProfileModel(response.data!.user!);
      createdUser = response.data!.user;
      onSuccess();
      emit(CreateAccountLoaded());
    } catch (e) {
      emit(CreateAccountError(e.toString()));
    }
  }

  Future<String> uploadMedia({required String filePath}) async {
    try {
      final response = await _createAccountUsecase.uploadMedia(
        filePath: filePath,
      );

      debugPrint('📤 Upload response type: ${response.runtimeType}');
      debugPrint('📤 Upload response: $response');

      // Handle null response
      if (response == null) {
        debugPrint('❌ Upload response is null');
        emit(CreateAccountError("Upload failed: No response from server"));
        return "";
      }

      if (response is Map<String, dynamic>) {
        final url = _extractUploadUrl(response);

        if (url != null && url.isNotEmpty) {
          mediaLinks.add(url);
          debugPrint('✅ Media added: $url');
          emit(CreateAccountLoaded());
        } else {
          debugPrint('❌ No valid URL found in response: $response');
          emit(CreateAccountError("Invalid URL in upload response"));
        }
        return url ?? "";
      } else {
        debugPrint('❌ Response is not a Map: ${response.runtimeType}');
        emit(CreateAccountError("Invalid response format from upload"));
        return "";
      }
    } catch (e) {
      debugPrint('❌ Upload error: $e');
      emit(CreateAccountError("Failed to upload media: $e"));
      return "";
    }
  }

  String? _extractUploadUrl(Map<String, dynamic> response) {
    final directUrl =
        response['url'] ??
        response['fileUrl'] ??
        response['link'] ??
        response['location'];

    if (directUrl is String && directUrl.isNotEmpty) {
      return directUrl;
    }

    for (final key in ['data', 'result', 'payload']) {
      final nested = response[key];
      if (nested is Map<String, dynamic>) {
        final nestedUrl =
            nested['url'] ??
            nested['fileUrl'] ??
            nested['link'] ??
            nested['location'];
        if (nestedUrl is String && nestedUrl.isNotEmpty) {
          return nestedUrl;
        }
      }
    }

    return null;
  }

  Future<void> sendVerificationCode({
    required String method,
    String? phone,
    String? email,
    required BuildContext context,
  }) async {
    isLoading = true;
    emit(CreateAccountLoading());

    try {
      final normalizedPhone = method == 'phone' && phone != null
          ? normalizePhone(phone)
          : phone;

      final response = await _createAccountUsecase.sendVerificationCode(
        method: method,
        phone: normalizedPhone,
        email: email,
      );

      final message = response is Map<String, dynamic>
          ? (response['message']?.toString() ??
                'Verification code sent successfully')
          : 'Verification code sent successfully';
      AutoRouter.of(context).replace(
        VerifyPhoneNumberRoute(isEmail: method.toLowerCase() == 'email'),
      );

      VxToast.show(message: message, icon: Assets.icons.checkGreen.path);
      isLoading = false;

      emit(CreateAccountLoaded());
    } catch (e) {
      isLoading = false;
      VxToast.show(message: e.toString());
      emit(CreateAccountError(e.toString()));
    }
  }

  Future<void> resetVerificationCode({
    required String method,
    String? phone,
    String? email,
    required BuildContext context,
  }) async {
    isLoading = true;

    emit(CreateAccountLoading());
    try {
      final normalizedPhone = method == 'phone' && phone != null
          ? normalizePhone(phone)
          : phone;

      await _createAccountUsecase.resetVerificationCode(
        method: method,
        phone: normalizedPhone,
        email: email,
      );
      VxToast.show(
        message: 'Verification code resent successfully',
        icon: Assets.icons.checkGreen.path,
      );
      isLoading = false;
      emit(CreateAccountLoaded());
    } catch (e) {
      isLoading = false;
      VxToast.show(message: e.toString());
      emit(CreateAccountError(e.toString()));
    }
  }

  /// Strip emojis and extra spaces from text
  String _stripEmojis(String text) {
    return text.replaceAll(RegExp(r'[\p{Emoji}]+', unicode: true), '').trim();
  }

  /// Update profile
  Future<void> updateProfile({
    final List<String>? bestShorts,
    final Map<String, List<String>>? vibes,
    final String? fcmToken,
  }) async {
    emit(CreateAccountLoading());

    try {
      final kycCubit = Di().sl<KycCubit>();
      final loginCubit = Di().sl<LoginCubit>();
      final imagePickerCubit = Di().sl<ImagePickerCubit>();
      final user = loginCubit.loginModel?.data?.user;

      // Prepare parameters - only include values that were actually set in kycCubit
      String? formattedDob;
      if (kycCubit.selectedDate != null) {
        formattedDob = formatDate(kycCubit.selectedDate.toString());
      }

      String? gender;
      if (kycCubit.selectedGender != null) {
        gender = kycCubit.selectedGender?.toLowerCase() ?? user?.gender;
      }

      List<String>? transformedOrientations;
      if (kycCubit.selectedSexualOrientations.isNotEmpty) {
        transformedOrientations = kycCubit.selectedSexualOrientations
            .map((o) => o.toLowerCase())
            .toList();
      }

      String? pronouns;
      if (kycCubit.selectedPronoun != null) {
        pronouns = kycCubit.selectedPronoun ?? user?.pronouns;
      }

      String? shortBio;
      if (kycCubit.shortBioController.text.isNotEmpty) {
        shortBio = kycCubit.shortBioController.text;
      }

      List<String>? transformedLifestyles;
      if (kycCubit.selectedLifestyles.isNotEmpty) {
        transformedLifestyles = kycCubit.selectedLifestyles
            .map((l) => _stripEmojis(l).toLowerCase())
            .toList();
      }

      String? jobTitle;
      if (kycCubit.jobTitleController.text.isNotEmpty) {
        jobTitle = kycCubit.jobTitleController.text;
      }

      String? education;
      if (kycCubit.educationController.text.isNotEmpty) {
        education = kycCubit.educationController.text;
      }

      Map<String, List<String>>? vibesMap;
      final selectedVibes = kycCubit.getSelectedVibes();
      if (selectedVibes.isNotEmpty) {
        vibesMap = selectedVibes;
      }

      List<String> validMediaLinks = imagePickerCubit.mediaList
          .where(
            (path) =>
                path.path.startsWith('http://') ||
                path.path.startsWith('https://'),
          )
          .map((path) => path.path)
          .toList();

      List<String>? bestShortsToSend;
      List<String>? mediaLinksToSend;
      if (validMediaLinks.isNotEmpty) {
        bestShortsToSend = validMediaLinks;
        mediaLinksToSend = validMediaLinks;
        log('Updating profile with media links: $validMediaLinks');
      }

      String? countryCode;
      if (Di().sl<AuthCubit>().selectedCountry?.name != null) {
        countryCode = Di().sl<AuthCubit>().selectedCountry!.name;
      }

      final LoginModel profileResponse = await _createAccountUsecase
          .updateProfile(
            dob: formattedDob,
            gender: gender,
            sexualOrientation: transformedOrientations,
            pronouns: pronouns,
            shortBio: shortBio,
            lifestyleLikes: transformedLifestyles,
            jobTitle: jobTitle,
            education: education,
            bestShorts: bestShortsToSend,
            vibes: vibesMap,
            mediaLinks: mediaLinksToSend,
            countryCode: countryCode,
            fcmToken: fcmToken,
          );

      loginCubit.userData = profileResponse.data;
      loginCubit.loginModel = LoginModel(
        message: profileResponse.message,
        data: profileResponse.data,
      );
      log("user data ${loginCubit.userData}");
      if (profileResponse.data?.user != null) {
        loginCubit.updateUserFromProfileModel(profileResponse.data!.user!);
      }

      emit(CreateAccountLoaded());
    } catch (e) {
      String errorMsg = 'Failed to update profile';

      if (e is Map<String, dynamic>) {
        errorMsg = e['message']?.toString() ?? errorMsg;
      } else {
        errorMsg = e.toString();
      }

      emit(CreateAccountError(errorMsg));
    }
  }

  // handling id on update wise for each prompt
  String promptId = "";

  Future<void> customPrompts({
    required String promptTitle,
    required String promptAnswer,
    required String type,
    required BuildContext context,
  }) async {
    isLoading = true;
    emit(CreateAccountLoading());
    try {
      var results = await _createAccountUsecase.customPrompt(
        promptTitle: promptTitle,
        promptAnswer: promptAnswer,
        type: type,
      );

      if (results["data"]["_id"] != null) {
        promptId = results['data']['_id'];
      }
      AutoRouter.of(context).pop();
      VxToast.show(
        message: 'Prompt submitted successfully',
        icon: Assets.icons.checkGreen.path,
      );
      promptTitle = '';
      promptAnswer = '';
      isLoading = false;

      emit(CreateAccountLoaded());
    } catch (e) {
      isLoading = false;
      emit(CreateAccountError("Failed to set custom prompts $e"));
    }
  }

  Future<void> loadProfile() async {
    emit(CreateAccountLoading());
    try {
      final profileResponse = await _createAccountUsecase.loadProfile();
      Di().sl<LoginCubit>().userData = profileResponse.data;
      Di().sl<LoginCubit>().loginModel = LoginModel(
        message: profileResponse.message,
        data: profileResponse.data,
      );
      log("user data ${Di().sl<LoginCubit>().userData}");
      if (profileResponse.data?.user != null) {
        Di().sl<LoginCubit>().updateUserFromProfileModel(
          profileResponse.data!.user!,
        );
      }
      emit(CreateAccountLoaded());
    } catch (e) {
      emit(CreateAccountError("Failed to load profile $e"));
    }
  }

  Future<void> updatePrompt({
    required String id,
    required String promptTitle,
    required String promptAnswer,
    required BuildContext context,
  }) async {
    isLoading = true;
    emit(CreateAccountLoading());
    try {
      var results = await _createAccountUsecase.updatePrompt(
        id: id,
        promptTitle: promptTitle,
        promptAnswer: promptAnswer,
      );
      log("results $results");
      AutoRouter.of(context).pop();
      VxToast.show(
        message: 'Prompt updated successfully',
        icon: Assets.icons.checkGreen.path,
      );
      promptTitle = '';
      promptAnswer = '';
      isLoading = false;

      emit(CreateAccountLoaded());
    } catch (e) {
      isLoading = false;
      emit(CreateAccountError("Failed to update prompt $e"));
    }
  }
}
