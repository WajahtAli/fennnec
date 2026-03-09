class NotificationSettingsModel {
  final bool? success;
  final String? message;
  final Data? data;

  NotificationSettingsModel({this.success, this.message, this.data});

  NotificationSettingsModel copyWith({
    bool? success,
    String? message,
    Data? data,
  }) => NotificationSettingsModel(
    success: success ?? this.success,
    message: message ?? this.message,
    data: data ?? this.data,
  );

  factory NotificationSettingsModel.fromJson(Map<String, dynamic> json) =>
      NotificationSettingsModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final Map<String, bool>? notificationSettings;

  Data({this.notificationSettings});

  Data copyWith({Map<String, bool>? notificationSettings}) => Data(
    notificationSettings: notificationSettings ?? this.notificationSettings,
  );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    notificationSettings: Map.from(
      json["notificationSettings"]!,
    ).map((k, v) => MapEntry<String, bool>(k, v)),
  );

  Map<String, dynamic> toJson() => {
    "notificationSettings": Map.from(
      notificationSettings!,
    ).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}
