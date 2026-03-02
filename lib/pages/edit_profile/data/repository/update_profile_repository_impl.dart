import '../../../auth/data/model/login_model.dart';
import '../../domain/repository/update_profile_repository.dart';
import '../datasource/update_profile_datasource.dart';

class UpdateProfileRepositoryImpl implements UpdateProfileRepository {
  final UpdateProfileDataSource updateProfileDataSource;

  UpdateProfileRepositoryImpl(this.updateProfileDataSource);

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
  }) {
    return updateProfileDataSource.updateProfile(
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
