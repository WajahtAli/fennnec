import 'dart:convert';
import 'package:fennac_app/pages/auth/data/model/prompt_model.dart';
import '../../../../utils/validators.dart';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool? success;
  String? message;
  LoginData? data;

  LoginModel({this.success, this.message, this.data});

  LoginModel copyWith({bool? success, String? message, LoginData? data}) =>
      LoginModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : LoginData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class LoginData {
  LoginUser? user;
  List<Prompt>? prompts;
  String? accessToken;
  String? refreshToken;
  String? deviceFingerprint;
  DeviceInfo? deviceInfo;

  LoginData({
    this.user,
    this.prompts,
    this.accessToken,
    this.refreshToken,
    this.deviceFingerprint,
    this.deviceInfo,
  });

  LoginData copyWith({
    LoginUser? user,
    List<Prompt>? prompts,
    String? accessToken,
    String? refreshToken,
    String? deviceFingerprint,
    DeviceInfo? deviceInfo,
  }) => LoginData(
    user: user ?? this.user,
    prompts: prompts ?? this.prompts,
    accessToken: accessToken ?? this.accessToken,
    refreshToken: refreshToken ?? this.refreshToken,
    deviceFingerprint: deviceFingerprint ?? this.deviceFingerprint,
    deviceInfo: deviceInfo ?? this.deviceInfo,
  );

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    user: json["user"] == null ? null : LoginUser.fromJson(json["user"]),
    prompts: json["prompts"] == null
        ? []
        : List<Prompt>.from(json["prompts"].map((x) => Prompt.fromJson(x))),
    accessToken: json["accessToken"]?.toString(),
    refreshToken: json["refreshToken"]?.toString(),
    deviceFingerprint: json["deviceFingerprint"]?.toString(),
    deviceInfo: json["deviceInfo"] == null
        ? null
        : DeviceInfo.fromJson(json["deviceInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "prompts": prompts == null
        ? []
        : List<dynamic>.from(prompts!.map((x) => x.toJson())),
    "accessToken": accessToken,
    "refreshToken": refreshToken,
    "deviceFingerprint": deviceFingerprint,
    "deviceInfo": deviceInfo?.toJson(),
  };
}

class DeviceInfo {
  String? userAgent;
  String? acceptLanguage;
  String? acceptEncoding;
  String? ip;

  DeviceInfo({
    this.userAgent,
    this.acceptLanguage,
    this.acceptEncoding,
    this.ip,
  });

  DeviceInfo copyWith({
    String? userAgent,
    String? acceptLanguage,
    String? acceptEncoding,
    String? ip,
  }) => DeviceInfo(
    userAgent: userAgent ?? this.userAgent,
    acceptLanguage: acceptLanguage ?? this.acceptLanguage,
    acceptEncoding: acceptEncoding ?? this.acceptEncoding,
    ip: ip ?? this.ip,
  );

  factory DeviceInfo.fromJson(Map<String, dynamic> json) => DeviceInfo(
    userAgent: json["userAgent"]?.toString(),
    acceptLanguage: json["acceptLanguage"]?.toString(),
    acceptEncoding: json["acceptEncoding"]?.toString(),
    ip: json["ip"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "userAgent": userAgent,
    "acceptLanguage": acceptLanguage,
    "acceptEncoding": acceptEncoding,
    "ip": ip,
  };
}

class LoginUser {
  String? authType;
  bool? isVerified;
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  bool? isPhoneVerified;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  List<String>? bestShorts;
  DateTime? dob;
  String? education;
  String? gender;
  String? jobTitle;
  List<String>? lifestyleLikes;
  String? pronouns;
  List<String>? sexualOrientation;
  String? shortBio;
  Vibes? vibes;

  /// NEW FIELDS
  String? countryCode;
  String? firebaseUserId;
  String? userImage;
  String? verifiedAt;
  String? latitude;
  String? longitude;
  String? address;
  String? zipCode;
  String? fcmToken;
  String? qrCode;
  bool? subscriptionActive;
  String? pokeBalance;
  String? accountStatus;
  NotificationSettings? notificationSettings;
  PrivacyPermissions? privacyPermissions;
  String? subscriptionExpiresAt;

  LoginUser({
    this.authType,
    this.isVerified,
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.isPhoneVerified,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.bestShorts,
    this.dob,
    this.education,
    this.gender,
    this.jobTitle,
    this.lifestyleLikes,
    this.pronouns,
    this.sexualOrientation,
    this.shortBio,
    this.vibes,
    this.countryCode,
    this.firebaseUserId,
    this.userImage,
    this.verifiedAt,
    this.latitude,
    this.longitude,
    this.address,
    this.zipCode,
    this.fcmToken,
    this.qrCode,
    this.subscriptionActive,
    this.pokeBalance,
    this.accountStatus,
    this.notificationSettings,
    this.privacyPermissions,
    this.subscriptionExpiresAt,
  });

  LoginUser copyWith({
    String? authType,
    bool? isVerified,
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    bool? isPhoneVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    List<String>? bestShorts,
    DateTime? dob,
    String? education,
    String? gender,
    String? jobTitle,
    List<String>? lifestyleLikes,
    String? pronouns,
    List<String>? sexualOrientation,
    String? shortBio,
    Vibes? vibes,
    String? countryCode,
    String? firebaseUserId,
    String? userImage,
    String? verifiedAt,
    String? latitude,
    String? longitude,
    String? address,
    String? zipCode,
    String? fcmToken,
    String? qrCode,
    bool? subscriptionActive,
    String? pokeBalance,
    String? accountStatus,
    NotificationSettings? notificationSettings,
    PrivacyPermissions? privacyPermissions,
    String? subscriptionExpiresAt,
  }) => LoginUser(
    authType: authType ?? this.authType,
    isVerified: isVerified ?? this.isVerified,
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    v: v ?? this.v,
    bestShorts: bestShorts ?? this.bestShorts,
    dob: dob ?? this.dob,
    education: education ?? this.education,
    gender: gender ?? this.gender,
    jobTitle: jobTitle ?? this.jobTitle,
    lifestyleLikes: lifestyleLikes ?? this.lifestyleLikes,
    pronouns: pronouns ?? this.pronouns,
    sexualOrientation: sexualOrientation ?? this.sexualOrientation,
    shortBio: shortBio ?? this.shortBio,
    vibes: vibes ?? this.vibes,
    countryCode: countryCode ?? this.countryCode,
    firebaseUserId: firebaseUserId ?? this.firebaseUserId,
    userImage: userImage ?? this.userImage,
    verifiedAt: verifiedAt ?? this.verifiedAt,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    address: address ?? this.address,
    zipCode: zipCode ?? this.zipCode,
    fcmToken: fcmToken ?? this.fcmToken,
    qrCode: qrCode ?? this.qrCode,
    subscriptionActive: subscriptionActive ?? this.subscriptionActive,
    pokeBalance: pokeBalance ?? this.pokeBalance,
    accountStatus: accountStatus ?? this.accountStatus,
    notificationSettings: notificationSettings ?? this.notificationSettings,
    privacyPermissions: privacyPermissions ?? this.privacyPermissions,
    subscriptionExpiresAt: subscriptionExpiresAt ?? this.subscriptionExpiresAt,
  );

  factory LoginUser.fromJson(Map<String, dynamic> json) => LoginUser(
    authType: validateString(json["authType"]),
    isVerified: json["isVerified"],
    id: validateString(json["_id"]),
    firstName: validateString(json["firstName"]),
    lastName: validateString(json["lastName"]),
    email: validateString(json["email"]),
    phone: validateString(json["phone"]),
    isPhoneVerified: json["isPhoneVerified"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    v: validateInt(json["__v"]),
    bestShorts: json["bestShorts"] == null
        ? []
        : List<String>.from(json["bestShorts"].map((x) => x)),
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    education: validateString(json["education"]),
    gender: validateString(json["gender"]),
    jobTitle: validateString(json["jobTitle"]),
    lifestyleLikes: json["lifestyleLikes"] == null
        ? []
        : List<String>.from(json["lifestyleLikes"].map((x) => x)),
    pronouns: validateString(json["pronouns"]),
    sexualOrientation: json["sexualOrientation"] == null
        ? []
        : List<String>.from(json["sexualOrientation"].map((x) => x)),
    shortBio: validateString(json["shortBio"]),
    vibes: json["vibes"] == null ? null : Vibes.fromJson(json["vibes"]),

    /// NEW PARSING
    countryCode: json["countryCode"]?.toString(),
    firebaseUserId: json["firebaseUserId"]?.toString(),
    userImage: json["userImage"]?.toString(),
    verifiedAt: json["verifiedAt"]?.toString(),
    latitude: json["latitude"]?.toString(),
    longitude: json["longitude"]?.toString(),
    address: json["address"]?.toString(),
    zipCode: json["zipCode"]?.toString(),
    fcmToken: json["fcmToken"]?.toString(),
    qrCode: json["qrCode"]?.toString(),
    subscriptionActive: json["subscriptionActive"],
    pokeBalance: json["pokeBalance"]?.toString(),
    accountStatus: json["accountStatus"]?.toString(),
    notificationSettings: json["notificationSettings"] == null
        ? null
        : NotificationSettings.fromJson(json["notificationSettings"]),
    privacyPermissions: json["privacyPermissions"] == null
        ? null
        : PrivacyPermissions.fromJson(json["privacyPermissions"]),
    subscriptionExpiresAt: json["subscriptionExpiresAt"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "authType": authType,
    "isVerified": isVerified,
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "phone": phone,
    "isPhoneVerified": isPhoneVerified,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "bestShorts": bestShorts,
    "dob": dob?.toIso8601String(),
    "education": education,
    "gender": gender,
    "jobTitle": jobTitle,
    "lifestyleLikes": lifestyleLikes,
    "pronouns": pronouns,
    "sexualOrientation": sexualOrientation,
    "shortBio": shortBio,
    "vibes": vibes?.toJson(),

    /// NEW
    "countryCode": countryCode,
    "firebaseUserId": firebaseUserId,
    "userImage": userImage,
    "verifiedAt": verifiedAt,
    "latitude": latitude,
    "longitude": longitude,
    "address": address,
    "zipCode": zipCode,
    "fcmToken": fcmToken,
    "qrCode": qrCode,
    "subscriptionActive": subscriptionActive,
    "pokeBalance": pokeBalance,
    "accountStatus": accountStatus,
    "notificationSettings": notificationSettings?.toJson(),
    "privacyPermissions": privacyPermissions?.toJson(),
    "subscriptionExpiresAt": subscriptionExpiresAt,
  };
}

class NotificationSettings {
  String? groupMatches;
  String? newLikes;
  String? newPokes;
  String? newMessages;
  String? callsAndMissedCalls;
  String? messageReactions;
  String? mentionsAndReplies;
  String? groupInvitesAndRequests;
  String? appAnnouncements;
  String? email;

  NotificationSettings({
    this.groupMatches,
    this.newLikes,
    this.newPokes,
    this.newMessages,
    this.callsAndMissedCalls,
    this.messageReactions,
    this.mentionsAndReplies,
    this.groupInvitesAndRequests,
    this.appAnnouncements,
    this.email,
  });

  NotificationSettings copyWith({
    String? groupMatches,
    String? newLikes,
    String? newPokes,
    String? newMessages,
    String? callsAndMissedCalls,
    String? messageReactions,
    String? mentionsAndReplies,
    String? groupInvitesAndRequests,
    String? appAnnouncements,
    String? email,
  }) => NotificationSettings(
    groupMatches: groupMatches ?? this.groupMatches,
    newLikes: newLikes ?? this.newLikes,
    newPokes: newPokes ?? this.newPokes,
    newMessages: newMessages ?? this.newMessages,
    callsAndMissedCalls: callsAndMissedCalls ?? this.callsAndMissedCalls,
    messageReactions: messageReactions ?? this.messageReactions,
    mentionsAndReplies: mentionsAndReplies ?? this.mentionsAndReplies,
    groupInvitesAndRequests:
        groupInvitesAndRequests ?? this.groupInvitesAndRequests,
    appAnnouncements: appAnnouncements ?? this.appAnnouncements,
    email: email ?? this.email,
  );

  factory NotificationSettings.fromJson(Map<String, dynamic> json) =>
      NotificationSettings(
        groupMatches: json["groupMatches"]?.toString(),
        newLikes: json["newLikes"]?.toString(),
        newPokes: json["newPokes"]?.toString(),
        newMessages: json["newMessages"]?.toString(),
        callsAndMissedCalls: json["callsAndMissedCalls"]?.toString(),
        messageReactions: json["messageReactions"]?.toString(),
        mentionsAndReplies: json["mentionsAndReplies"]?.toString(),
        groupInvitesAndRequests: json["groupInvitesAndRequests"]?.toString(),
        appAnnouncements: json["appAnnouncements"]?.toString(),
        email: json["email"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
    "groupMatches": groupMatches,
    "newLikes": newLikes,
    "newPokes": newPokes,
    "newMessages": newMessages,
    "callsAndMissedCalls": callsAndMissedCalls,
    "messageReactions": messageReactions,
    "mentionsAndReplies": mentionsAndReplies,
    "groupInvitesAndRequests": groupInvitesAndRequests,
    "appAnnouncements": appAnnouncements,
    "email": email,
  };
}

class Vibes {
  List<String>? sportsAndOutdoor;
  List<String>? foodAndDrink;
  List<String>? musicAndArts;
  List<String>? travelAndAdventure;
  List<String>? techAndGaming;
  dynamic readingAndLearning;
  dynamic otherFunInterests;
  Vibes({
    this.sportsAndOutdoor,
    this.foodAndDrink,
    this.musicAndArts,
    this.travelAndAdventure,
    this.techAndGaming,
    this.readingAndLearning,
    this.otherFunInterests,
  });
  Vibes copyWith({
    List<String>? sportsAndOutdoor,
    List<String>? foodAndDrink,
    List<String>? musicAndArts,
    List<String>? travelAndAdventure,
    List<String>? techAndGaming,
    dynamic readingAndLearning,
    dynamic otherFunInterests,
  }) => Vibes(
    sportsAndOutdoor: sportsAndOutdoor ?? this.sportsAndOutdoor,
    foodAndDrink: foodAndDrink ?? this.foodAndDrink,
    musicAndArts: musicAndArts ?? this.musicAndArts,
    travelAndAdventure: travelAndAdventure ?? this.travelAndAdventure,
    techAndGaming: techAndGaming ?? this.techAndGaming,
    readingAndLearning: readingAndLearning ?? this.readingAndLearning,
    otherFunInterests: otherFunInterests ?? this.otherFunInterests,
  );
  factory Vibes.fromJson(Map<String, dynamic> json) => Vibes(
    sportsAndOutdoor: json["sports and outdoor"] == null
        ? []
        : List<String>.from(json["sports and outdoor"]!.map((x) => x)),
    foodAndDrink: json["food and drink"] == null
        ? []
        : List<String>.from(json["food and drink"]!.map((x) => x)),
    musicAndArts: json["music and arts"] == null
        ? []
        : List<String>.from(json["music and arts"]!.map((x) => x)),
    travelAndAdventure: json["travel and adventure"] == null
        ? []
        : List<String>.from(json["travel and adventure"]!.map((x) => x)),
    techAndGaming: json["tech and gaming"] == null
        ? []
        : List<String>.from(json["tech and gaming"]!.map((x) => x)),
    readingAndLearning: json["reading and learning"],
    otherFunInterests: json["other fun interests"],
  );
  Map<String, dynamic> toJson() => {
    "sports and outdoor": sportsAndOutdoor == null
        ? []
        : List<dynamic>.from(sportsAndOutdoor!.map((x) => x)),
    "food and drink": foodAndDrink == null
        ? []
        : List<dynamic>.from(foodAndDrink!.map((x) => x)),
    "music and arts": musicAndArts == null
        ? []
        : List<dynamic>.from(musicAndArts!.map((x) => x)),
    "travel and adventure": travelAndAdventure == null
        ? []
        : List<dynamic>.from(travelAndAdventure!.map((x) => x)),
    "tech and gaming": techAndGaming == null
        ? []
        : List<dynamic>.from(techAndGaming!.map((x) => x)),
    "reading and learning": readingAndLearning,
    "other fun interests": otherFunInterests,
  };
}

class PrivacyPermissions {
  String? activityStatusEnabled;
  String? locationSharingEnabled;
  String? contactAccessEnabled;
  String? mediaPermissionsEnabled;

  PrivacyPermissions({
    this.activityStatusEnabled,
    this.locationSharingEnabled,
    this.contactAccessEnabled,
    this.mediaPermissionsEnabled,
  });

  PrivacyPermissions copyWith({
    String? activityStatusEnabled,
    String? locationSharingEnabled,
    String? contactAccessEnabled,
    String? mediaPermissionsEnabled,
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
        activityStatusEnabled: json["activityStatusEnabled"]?.toString(),
        locationSharingEnabled: json["locationSharingEnabled"]?.toString(),
        contactAccessEnabled: json["contactAccessEnabled"]?.toString(),
        mediaPermissionsEnabled: json["mediaPermissionsEnabled"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
    "activityStatusEnabled": activityStatusEnabled,
    "locationSharingEnabled": locationSharingEnabled,
    "contactAccessEnabled": contactAccessEnabled,
    "mediaPermissionsEnabled": mediaPermissionsEnabled,
  };
}
