import 'package:fennac_app/pages/auth/data/datasources/create_account_datasource.dart';
import 'package:fennac_app/pages/auth/data/model/login_model.dart';
import 'package:fennac_app/pages/auth/domain/repositories/create_account_repo.dart';

class CreateAccountRepoImpl extends CreateAccountRepo {
  @override
  Future<dynamic> sendVerificationCode({
    required String method,
    String? phone,
    String? email,
  }) async {
    return await _createAccountDatasource.sendVerificationCode(
      method: method,
      phone: phone,
      email: email,
    );
  }

  @override
  Future<dynamic> resetVerificationCode({
    required String method,
    String? phone,
    String? email,
  }) async {
    return await _createAccountDatasource.resetVerificationCode(
      method: method,
      phone: phone,
      email: email,
    );
  }

  final CreateAccountDatasource _createAccountDatasource;

  CreateAccountRepoImpl(this._createAccountDatasource);

  @override
  Future<LoginUser> createAccount({
    final String? firstName,
    final String? lastName,
    final String? email,
    final String? phone,
    final String? countryCode,
    final String? homeTown,
    final String? password,
  }) async {
    return await _createAccountDatasource.createAccount(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      countryCode: countryCode,
      homeTown: homeTown,
      password: password,
    );
  }

  @override
  Future<LoginModel> verifyCode({
    final String? phone,
    final String? verificationCode,
  }) async {
    return await _createAccountDatasource.verifyCode(
      phone: phone,
      verificationCode: verificationCode,
    );
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
    final String? homeTown,
    final String? latitude,
    final String? longitude,
    final List<String>? bestShorts,
    final Map<String, List<String>>? vibes,
    final List<String>? mediaLinks,
    final String? countryCode,
    final String? fcmToken,
  }) async {
    return await _createAccountDatasource.updateProfile(
      dob: dob,
      gender: gender,
      sexualOrientation: sexualOrientation,
      pronouns: pronouns,
      shortBio: shortBio,
      lifestyleLikes: lifestyleLikes,
      jobTitle: jobTitle,
      education: education,
      homeTown: homeTown,
      latitude: latitude,
      longitude: longitude,
      bestShorts: bestShorts,
      vibes: vibes,
      countryCode: countryCode,
      fcmToken: fcmToken,
    );
  }

  @override
  Future<dynamic> uploadMedia({required final String filePath}) async {
    return await _createAccountDatasource.uploadMedia(filePath: filePath);
  }

  @override
  Future<dynamic> uploadMediaMultiple({
    required final List<String> filePaths,
  }) async {
    return await _createAccountDatasource.uploadMediaMultiple(
      filePaths: filePaths,
    );
  }

  @override
  Future<dynamic> customPrompt({
    required final String promptTitle,
    required final String type,
    required final String promptAnswer,
  }) async {
    return await _createAccountDatasource.customPrompt(
      promptTitle: promptTitle,
      type: type,
      promptAnswer: promptAnswer,
    );
  }

  @override
  Future<LoginModel> loadProfile() async {
    return await _createAccountDatasource.loadProfile();
  }

  @override
  Future<dynamic> updatePrompt({
    required String id,
    required String promptTitle,
    required String promptAnswer,
  }) async {
    return await _createAccountDatasource.updatePrompt(
      id: id,
      promptTitle: promptTitle,
      promptAnswer: promptAnswer,
    );
  }
}
