import 'dart:developer';

import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/models/dummy/notification_tile_model.dart';
import 'package:fennac_app/pages/profile/data/models/notification_settings_model.dart';
import 'package:fennac_app/pages/profile/domain/usecase/notification_settings_usecase.dart';
import 'package:fennac_app/pages/profile/presentation/bloc/state/notification_settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationSettingsCubit extends Cubit<NotificationSettingsState> {
  final NotificationSettingsUsecase _notificationSettingsUsecase;

  NotificationSettingsCubit(this._notificationSettingsUsecase)
    : super(NotificationSettingsInitial());

  NotificationSettingsModel? notificationSettingsModel;
  bool isSubmitting = false;

  static const List<String> _settingsKeys = [
    'groupMatches',
    'newLikes',
    'newPokes',
    'newMessages',
    'callsAndMissedCalls',
    'messageReactions',
    'mentionsAndReplies',
    'groupInvitesAndRequests',
    'appAnnouncements',
    'email',
  ];

  final List<NotificationTileData> notificationItems = [
    NotificationTileData(
      title: 'Group Matches',
      subtitle: 'Get notified when your group matches with another group.',
      value: false,
    ),
    NotificationTileData(
      title: 'New Likes',
      subtitle: 'Get notified when someone likes your profile or content.',
      value: false,
    ),
    NotificationTileData(
      title: 'New Pokes',
      subtitle: 'Get notified when someone pokes you.',
      value: false,
    ),
    NotificationTileData(
      title: 'New Messages',
      subtitle: 'Alerts for incoming messages and media in your chats.',
      value: false,
    ),
    NotificationTileData(
      title: 'Calls & Missed Calls',
      subtitle:
          'Receive notifications for incoming and missed voice or video calls.',
      value: false,
    ),
    NotificationTileData(
      title: 'Message Reactions',
      subtitle: 'Stay updated when someone reacts to your messages.',
      value: false,
    ),
    NotificationTileData(
      title: 'Mentions & Replies',
      subtitle:
          'Be notified when someone tags or replies to you in group chats.',
      value: false,
    ),
    NotificationTileData(
      title: 'Group Invites & Requests',
      subtitle: 'Alerts for new group invitations and join requests.',
      value: false,
    ),
    NotificationTileData(
      title: 'App Announcements',
      subtitle:
          'Important updates, new features, and system messages from Fennec.',
      value: false,
    ),
    NotificationTileData(
      title: 'Email Notifications',
      subtitle: 'Receive summaries and important alerts via email.',
      value: false,
    ),
  ];

  Future<void> fetchNotificationSettings() async {
    emit(NotificationSettingsLoading());
    try {
      final response = await _notificationSettingsUsecase
          .fetchNotificationSettings();
      notificationSettingsModel = response;

      final settings = response.data?.notificationSettings;
      _applySettingsToItems(settings);

      emit(NotificationSettingsLoaded());
    } catch (e) {
      log('Error fetching notification settings: $e');
      emit(NotificationSettingsError(e.toString()));
    }
  }

  void toggleNotification(int index, bool value) {
    emit(NotificationSettingsLoading());
    notificationItems[index] = notificationItems[index].copyWith(value: value);
    _syncModelFromItems();
    emit(NotificationSettingsLoaded());
  }

  Future<bool> updateNotificationSettings() async {
    emit(NotificationSettingsLoading());
    isSubmitting = true;
    try {
      _syncModelFromItems();

      final currentModel =
          notificationSettingsModel ??
          NotificationSettingsModel(data: Data(notificationSettings: {}));

      final updatedResponse = await _notificationSettingsUsecase
          .updateNotificationSettings(notificationSettingsModel: currentModel);

      notificationSettingsModel = updatedResponse;
      VxToast.show(
        message: updatedResponse.message ?? 'Notification settings updated',
      );

      await fetchNotificationSettings();
      isSubmitting = false;
      return true;
    } catch (e) {
      log('Error updating notification settings: $e');
      VxToast.show(message: 'Failed to update notification settings');
      isSubmitting = false;
      emit(NotificationSettingsError(e.toString()));
      return false;
    }
  }

  void _syncModelFromItems() {
    final currentSettings = Map<String, bool>.from(
      notificationSettingsModel?.data?.notificationSettings ?? {},
    );

    for (var index = 0; index < _settingsKeys.length; index++) {
      if (index < notificationItems.length) {
        currentSettings[_settingsKeys[index]] = notificationItems[index].value;
      }
    }

    final currentData = notificationSettingsModel?.data;
    final updatedData =
        currentData?.copyWith(notificationSettings: currentSettings) ??
        Data(notificationSettings: currentSettings);

    notificationSettingsModel =
        (notificationSettingsModel ?? NotificationSettingsModel()).copyWith(
          data: updatedData,
        );
  }

  void _applySettingsToItems(Map<String, bool>? settings) {
    if (settings == null || settings.isEmpty) return;

    for (var index = 0; index < _settingsKeys.length; index++) {
      if (index < notificationItems.length &&
          settings[_settingsKeys[index]] != null) {
        notificationItems[index] = notificationItems[index].copyWith(
          value: settings[_settingsKeys[index]],
        );
      }
    }
  }
}
