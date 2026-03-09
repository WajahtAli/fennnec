import 'package:fennac_app/pages/profile/data/models/notification_settings_model.dart';

abstract class NotificationSettingsRepository {
  Future<NotificationSettingsModel> fetchNotificationSettings();
  Future<NotificationSettingsModel> updateNotificationSettings({
    required NotificationSettingsModel notificationSettingsModel,
  });
}
