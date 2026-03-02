import '../../../auth/data/model/login_model.dart';
import '../repository/update_profile_repository.dart';

class UpdateProfileUseCase {
  final UpdateProfileRepository updateProfileRepository;

  UpdateProfileUseCase(this.updateProfileRepository);

  Future<LoginModel> call({
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
  }) {
    return updateProfileRepository.updateProfile(
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
      countryCode: countryCode,
    );
  }
}
