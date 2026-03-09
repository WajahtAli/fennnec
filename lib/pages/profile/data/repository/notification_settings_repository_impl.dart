import 'package:fennac_app/pages/profile/data/datasource/notification_settings_datasource.dart';
import 'package:fennac_app/pages/profile/data/models/notification_settings_model.dart';
import 'package:fennac_app/pages/profile/domain/repository/notification_settings_repository.dart';

class NotificationSettingsRepositoryImpl
    extends NotificationSettingsRepository {
  final NotificationSettingsDatasource _datasource;

  NotificationSettingsRepositoryImpl(this._datasource);

  @override
  Future<NotificationSettingsModel> fetchNotificationSettings() async {
    return await _datasource.fetchNotificationSettings();
  }

  @override
  Future<NotificationSettingsModel> updateNotificationSettings({
    required NotificationSettingsModel notificationSettingsModel,
  }) async {
    return await _datasource.updateNotificationSettings(
      notificationSettingsModel: notificationSettingsModel,
    );
  }
}
