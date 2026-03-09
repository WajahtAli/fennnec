import 'package:fennac_app/pages/profile/data/models/notification_settings_model.dart';
import 'package:fennac_app/pages/profile/domain/repository/notification_settings_repository.dart';

class NotificationSettingsUsecase {
  final NotificationSettingsRepository _repository;

  NotificationSettingsUsecase(this._repository);

  Future<NotificationSettingsModel> fetchNotificationSettings() async {
    return await _repository.fetchNotificationSettings();
  }

  Future<NotificationSettingsModel> updateNotificationSettings({
    required NotificationSettingsModel notificationSettingsModel,
  }) async {
    return await _repository.updateNotificationSettings(
      notificationSettingsModel: notificationSettingsModel,
    );
  }
}
