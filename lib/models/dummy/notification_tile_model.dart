class NotificationTileData {
  final String title;
  final String subtitle;
  final bool value;

  const NotificationTileData({
    required this.title,
    required this.subtitle,
    required this.value,
  });

  NotificationTileData copyWith({bool? value}) {
    return NotificationTileData(
      title: title,
      subtitle: subtitle,
      value: value ?? this.value,
    );
  }
}

class PrivacyPermissionData {
  final String title;
  final String subtitle;
  final void Function(bool) onChanged;

  PrivacyPermissionData({
    required this.title,
    required this.subtitle,
    required this.onChanged,
  });
}
