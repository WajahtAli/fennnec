class PrivacyPermissionModel {
  final bool? success;
  final String? message;
  final Data? data;

  PrivacyPermissionModel({this.success, this.message, this.data});

  PrivacyPermissionModel copyWith({
    bool? success,
    String? message,
    Data? data,
  }) => PrivacyPermissionModel(
    success: success ?? this.success,
    message: message ?? this.message,
    data: data ?? this.data,
  );

  factory PrivacyPermissionModel.fromJson(Map<String, dynamic> json) =>
      PrivacyPermissionModel(
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
  final PrivacyPermissions? privacyPermissions;

  Data({this.privacyPermissions});

  Data copyWith({PrivacyPermissions? privacyPermissions}) =>
      Data(privacyPermissions: privacyPermissions ?? this.privacyPermissions);

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    privacyPermissions: json["privacyPermissions"] == null
        ? null
        : PrivacyPermissions.fromJson(json["privacyPermissions"]),
  );

  Map<String, dynamic> toJson() => {
    "privacyPermissions": privacyPermissions?.toJson(),
  };
}

class PrivacyPermissions {
  final bool? activityStatusEnabled;
  final bool? locationSharingEnabled;
  final bool? contactAccessEnabled;
  final bool? mediaPermissionsEnabled;

  PrivacyPermissions({
    this.activityStatusEnabled,
    this.locationSharingEnabled,
    this.contactAccessEnabled,
    this.mediaPermissionsEnabled,
  });

  PrivacyPermissions copyWith({
    bool? activityStatusEnabled,
    bool? locationSharingEnabled,
    bool? contactAccessEnabled,
    bool? mediaPermissionsEnabled,
  }) => PrivacyPermissions(
    activityStatusEnabled: activityStatusEnabled ?? this.activityStatusEnabled,
    locationSharingEnabled:
        locationSharingEnabled ?? this.locationSharingEnabled,
    contactAccessEnabled: contactAccessEnabled ?? this.contactAccessEnabled,
    mediaPermissionsEnabled:
        mediaPermissionsEnabled ?? this.mediaPermissionsEnabled,
  );

  factory PrivacyPermissions.fromJson(Map<String, dynamic> json) =>
      PrivacyPermissions(
        activityStatusEnabled: json["activityStatusEnabled"],
        locationSharingEnabled: json["locationSharingEnabled"],
        contactAccessEnabled: json["contactAccessEnabled"],
        mediaPermissionsEnabled: json["mediaPermissionsEnabled"],
      );

  Map<String, dynamic> toJson() => {
    "activityStatusEnabled": activityStatusEnabled,
    "locationSharingEnabled": locationSharingEnabled,
    "contactAccessEnabled": contactAccessEnabled,
    "mediaPermissionsEnabled": mediaPermissionsEnabled,
  };
}
