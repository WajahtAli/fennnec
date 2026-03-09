import 'package:fennac_app/app/constants/app_constants.dart';
import 'package:fennac_app/core/network/api_helper.dart';
import 'package:fennac_app/pages/profile/data/models/notification_settings_model.dart';

abstract class NotificationSettingsDatasource {
  Future<NotificationSettingsModel> fetchNotificationSettings();
  Future<NotificationSettingsModel> updateNotificationSettings({
    required NotificationSettingsModel notificationSettingsModel,
  });
}

class NotificationSettingsDatasourceImpl
    extends NotificationSettingsDatasource {
  final ApiHelper apiHelper;

  NotificationSettingsDatasourceImpl(this.apiHelper);

  @override
  Future<NotificationSettingsModel> fetchNotificationSettings() async {
    final response = await apiHelper.get(
      AppConstants.notificationSettings,
      requiresAuth: true,
    );

    return NotificationSettingsModel.fromJson(response);
  }

  @override
  Future<NotificationSettingsModel> updateNotificationSettings({
    required NotificationSettingsModel notificationSettingsModel,
  }) async {
    final response = await apiHelper.put(
      AppConstants.notificationSettings,
      requiresAuth: true,
      body: {
        'notificationSettings':
            notificationSettingsModel.data?.notificationSettings ?? {},
      },
    );

    return NotificationSettingsModel.fromJson(response);
  }
}
