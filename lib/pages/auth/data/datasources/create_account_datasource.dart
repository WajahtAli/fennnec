// import 'package:http/http.dart' as http;

import 'dart:developer';

import 'package:fennac_app/app/constants/app_constants.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/auth/data/model/login_model.dart';
import 'package:fennac_app/pages/create_group/presentation/bloc/cubit/create_group_cubit.dart';

import '../../../../core/network/api_helper.dart';

abstract class CreateAccountDatasource {
  Future<dynamic> resetVerificationCode({
    required String method,
    String? phone,
    String? email,
  });
  Future<LoginUser> createAccount({
    final String? firstName,
    final String? lastName,
    final String? email,
    final String? phone,
    final String? countryCode,
    final String? password,
  });

  Future<LoginModel> verifyCode({
    final String? phone,
    final String? verificationCode,
  });

  Future<LoginModel> updateProfile({
    final String? dob,
    final String? gender,
    final List<String>? sexualOrientation,
    final String? pronouns,
    final String? shortBio,
    final List<String>? lifestyleLikes,
    final String? jobTitle,
    final String? education,
    final List<String>? bestShorts,
    final Map<String, List<String>>? vibes,
    final String? countryCode,
  });

  // load profile
  Future<LoginModel> loadProfile();

  Future<dynamic> uploadMedia({required final String filePath});

  Future<dynamic> customPrompt({
    required final String promptTitle,
    required final String type,
    required final String promptAnswer,
  });

  // update prompt

  Future<dynamic> updatePrompt({
    required final String id,
    required final String promptTitle,
    required final String promptAnswer,
  });
}

class CreateAccountDatasourceImpl extends CreateAccountDatasource {
  final ApiHelper apiHelper;

  CreateAccountDatasourceImpl(this.apiHelper);

  @override
  Future<LoginUser> createAccount({
    final String? firstName,
    final String? lastName,
    final String? email,
    final String? phone,
    final String? countryCode,
    final String? password,
  }) async {
    final data = await apiHelper.post(
      AppConstants.createAccount,
      requiresAuth: false,
      body: {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "countryCode": countryCode,
        "password": password,
      },
    );
    return LoginUser.fromJson(data);
  }

  @override
  Future<LoginModel> verifyCode({
    final String? phone,
    final String? verificationCode,
  }) async {
    final data = await apiHelper.post(
      AppConstants.verifyCode,
      requiresAuth: false,
      body: {"phone": phone, "verificationCode": verificationCode},
    );
    return LoginModel.fromJson(data);
  }

  @override
  Future<LoginModel> updateProfile({
    final String? dob,
    final String? gender,
    final List<String>? sexualOrientation,
    final String? pronouns,
    final String? shortBio,
    final List<String>? lifestyleLikes,
    final String? jobTitle,
    final String? education,
    final List<String>? bestShorts,
    final Map<String, List<String>>? vibes,
    final String? countryCode,
  }) async {
    final data = await apiHelper.put(
      AppConstants.updateProfile,
      requiresAuth: true,
      body: {
        if (dob != null) "dob": dob,
        if (gender != null) "gender": gender,
        if (sexualOrientation != null) "sexualOrientation": sexualOrientation,
        if (pronouns != null) "pronouns": pronouns,
        if (shortBio != null) "shortBio": shortBio,
        if (lifestyleLikes != null) "lifestyleLikes": lifestyleLikes,
        if (jobTitle != null) "jobTitle": jobTitle,
        if (education != null) "education": education,
        if (bestShorts != null) "bestShorts": bestShorts,
        if (vibes != null) "vibes": vibes,
        if (countryCode != null) "countryCode": countryCode,
      },
    );
    return LoginModel.fromJson(data);
  }

  @override
  Future<dynamic> uploadMedia({required final String filePath}) async {
    final data = await apiHelper.uploadFile(
      AppConstants.uploadSingle,
      fileFieldName: 'file',
      filePath: filePath,
      requiresAuth: true,
    );
    return data;
  }

  @override
  Future<dynamic> customPrompt({
    required final String promptTitle,
    required final String type,
    required final String promptAnswer,
  }) async {
    final createGroupCubit = Di().sl<CreateGroupCubit>();
    final body = {
      "promptTitle": promptTitle,
      "type": type,
      "promptAnswer": promptAnswer,
    };
    if (createGroupCubit.groupId.isNotEmpty) {
      body['groupId'] = createGroupCubit.groupId;
    }
    log("body: $body", name: "createGroupCubit", level: 10);
    final data = await apiHelper.post(
      AppConstants.userPrompts,
      requiresAuth: true,
      body: body,
    );
    return data;
  }

  @override
  Future<dynamic> resetVerificationCode({
    required String method,
    String? phone,
    String? email,
  }) async {
    final Map<String, dynamic> body = {"method": method};
    if (phone != null) body["phone"] = phone;
    if (email != null) body["email"] = email;
    final data = await apiHelper.post(
      AppConstants.resetVerificationCode,
      requiresAuth: false,
      body: body,
    );
    return data;
  }

  @override
  Future<LoginModel> loadProfile() async {
    final data = await apiHelper.put(
      AppConstants.updateProfile,
      requiresAuth: true,
    );
    return LoginModel.fromJson(data);
  }

  @override
  Future updatePrompt({
    required String id,
    required String promptTitle,
    required String promptAnswer,
  }) async {
    final createGroupCubit = Di().sl<CreateGroupCubit>();
    final body = {"promptTitle": promptTitle, "promptAnswer": promptAnswer};
    if (createGroupCubit.groupId.isNotEmpty) {
      body['groupId'] = createGroupCubit.groupId;
    }
    final data = await apiHelper.put(
      "${AppConstants.updatePrompt}$id",
      requiresAuth: true,
      body: body,
    );
    return data;
  }
}
