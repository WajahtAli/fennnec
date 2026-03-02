import 'package:fennac_app/pages/auth/data/model/login_model.dart';
import 'package:fennac_app/pages/auth/domain/repositories/create_account_repo.dart';

class CreateAccountUsecase {
  Future<dynamic> resetVerificationCode({
    required String method,
    String? phone,
    String? email,
  }) async {
    return await _createAccountRepo.resetVerificationCode(
      method: method,
      phone: phone,
      email: email,
    );
  }

  final CreateAccountRepo _createAccountRepo;

  CreateAccountUsecase(this._createAccountRepo);

  Future<LoginUser> createAccount({
    final String? firstName,
    final String? lastName,
    final String? email,
    final String? phone,
    final String? countryCode,
    final String? password,
  }) async {
    return await _createAccountRepo.createAccount(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      countryCode: countryCode,
      password: password,
    );
  }

  Future<LoginModel> verifyCode({
    final String? phone,
    final String? verificationCode,
  }) async {
    return await _createAccountRepo.verifyCode(
      phone: phone,
      verificationCode: verificationCode,
    );
  }

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
    final List<String>? mediaLinks,
    final String? countryCode,
  }) async {
    return await _createAccountRepo.updateProfile(
      dob: dob,
      gender: gender,
      sexualOrientation: sexualOrientation,
      pronouns: pronouns,
      shortBio: shortBio,
      lifestyleLikes: lifestyleLikes,
      jobTitle: jobTitle,
      education: education,
      bestShorts: bestShorts,
      vibes: vibes,
      mediaLinks: mediaLinks,
      countryCode: countryCode,
    );
  }

  Future<dynamic> uploadMedia({required final String filePath}) async {
    return await _createAccountRepo.uploadMedia(filePath: filePath);
  }

  Future<dynamic> customPrompt({
    required final String promptTitle,
    required final String type,
    required final String promptAnswer,
  }) async {
    return await _createAccountRepo.customPrompt(
      promptTitle: promptTitle,
      type: type,
      promptAnswer: promptAnswer,
    );
  }

  Future<LoginModel> loadProfile() async {
    return await _createAccountRepo.loadProfile();
  }

  Future<dynamic> updatePrompt({
    required String id,
    required String promptTitle,
    required String promptAnswer,
  }) async {
    return await _createAccountRepo.updatePrompt(
      id: id,
      promptTitle: promptTitle,
      promptAnswer: promptAnswer,
    );
  }
}
