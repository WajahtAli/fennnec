import '../../../../app/constants/app_constants.dart';
import '../../../../core/network/api_helper.dart';
import '../../../auth/data/model/login_model.dart';

abstract class UpdateProfileDataSource {
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

class UpdateProfileDataSourceImpl implements UpdateProfileDataSource {
  final ApiHelper apiHelper;

  UpdateProfileDataSourceImpl(this.apiHelper);

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
    try {
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
    } catch (e) {
      rethrow;
    }
  }
}
