import 'package:fennac_app/pages/auth/data/model/login_model.dart';

abstract class CreateAccountRepo {
  Future<dynamic> sendVerificationCode({
    required String method,
    String? phone,
    String? email,
  });

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
    final List<String>? mediaLinks,
    final String? countryCode,
    final String? fcmToken,
  });

  Future<dynamic> uploadMedia({required final String filePath});

  Future<dynamic> customPrompt({
    required final String promptTitle,
    required final String type,
    required final String promptAnswer,
  });

  Future<LoginModel> loadProfile();

  Future<dynamic> updatePrompt({
    required String id,
    required String promptTitle,
    required String promptAnswer,
  });
}
