import '../../../auth/data/model/login_model.dart';

abstract class UpdateProfileRepository {
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
}
