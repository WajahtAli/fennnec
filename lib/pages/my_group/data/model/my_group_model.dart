// To parse this JSON data, do
//
//     final myGroupModel = myGroupModelFromJson(jsonString);

import 'dart:convert';

MyGroupModel myGroupModelFromJson(String str) =>
    MyGroupModel.fromJson(json.decode(str));

String myGroupModelToJson(MyGroupModel data) => json.encode(data.toJson());

class MyGroupModel {
  bool? success;
  String? message;
  MyGroupData? data;
  List<MyGroupData>? groupList;

  MyGroupModel({this.success, this.message, this.data, this.groupList});

  MyGroupModel copyWith({bool? success, String? message, MyGroupData? data}) =>
      MyGroupModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory MyGroupModel.fromJson(Map<String, dynamic> json) {
    MyGroupData? groupData;
    List<MyGroupData>? groupList;

    if (json["data"] != null) {
      if (json["data"] is List) {
        final dataList = json["data"] as List;
        if (dataList.isNotEmpty) {
          groupList = dataList.map((x) => MyGroupData.fromJson(x)).toList();
        }
      } else {
        groupData = MyGroupData.fromJson(json["data"]);
      }
    }

    return MyGroupModel(
      success: json["success"],
      message: json["message"],
      data: groupData,
      groupList: groupList,
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class MyGroupData {
  String? id;
  List<CreatedBy>? members;
  CreatedBy? createdBy;
  String? qrCode;
  String? titleMembers;
  String? bio;
  String? fitsForGroup;
  GroupSettings? groupSettings;
  List<String>? photosVideos;
  List<GroupPrompt>? groupPrompts;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  MyGroupData({
    this.id,
    this.members,
    this.createdBy,
    this.qrCode,
    this.titleMembers,
    this.bio,
    this.fitsForGroup,
    this.groupSettings,
    this.photosVideos,
    this.groupPrompts,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  MyGroupData copyWith({
    String? id,
    List<CreatedBy>? members,
    CreatedBy? createdBy,
    String? qrCode,
    String? titleMembers,
    String? bio,
    String? fitsForGroup,
    GroupSettings? groupSettings,
    List<String>? photosVideos,
    List<GroupPrompt>? groupPrompts,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) => MyGroupData(
    id: id ?? this.id,
    members: members ?? this.members,
    createdBy: createdBy ?? this.createdBy,
    qrCode: qrCode ?? this.qrCode,
    titleMembers: titleMembers ?? this.titleMembers,
    bio: bio ?? this.bio,
    fitsForGroup: fitsForGroup ?? this.fitsForGroup,
    groupSettings: groupSettings ?? this.groupSettings,
    photosVideos: photosVideos ?? this.photosVideos,
    groupPrompts: groupPrompts ?? this.groupPrompts,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    v: v ?? this.v,
  );

  factory MyGroupData.fromJson(Map<String, dynamic> json) => MyGroupData(
    id: json["_id"],
    members: json["members"] == null
        ? []
        : List<CreatedBy>.from(
            json["members"]!.map((x) => CreatedBy.fromJson(x)),
          ),
    createdBy: json["createdBy"] == null
        ? null
        : CreatedBy.fromJson(json["createdBy"]),
    qrCode: json["qrCode"],
    titleMembers: json["title_members"] ?? json["title"],
    bio: json["bio"],
    fitsForGroup: json["fitsForGroup"],
    groupSettings: json["groupSettings"] == null
        ? null
        : GroupSettings.fromJson(json["groupSettings"]),
    photosVideos: json["photosVideos"] == null
        ? []
        : List<String>.from(json["photosVideos"]!.map((x) => x)),
    groupPrompts: json["groupPrompts"] == null
        ? []
        : List<GroupPrompt>.from(
            json["groupPrompts"]!.map((x) => GroupPrompt.fromJson(x)),
          ),
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "members": members == null
        ? []
        : List<dynamic>.from(members!.map((x) => x.toJson())),
    "createdBy": createdBy?.toJson(),
    "qrCode": qrCode,
    "title_members": titleMembers,
    "bio": bio,
    "fitsForGroup": fitsForGroup,
    "groupSettings": groupSettings?.toJson(),
    "photosVideos": photosVideos == null
        ? []
        : List<dynamic>.from(photosVideos!.map((x) => x)),
    "groupPrompts": groupPrompts == null
        ? []
        : List<dynamic>.from(groupPrompts!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class CreatedBy {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? image;
  List<String>? bestShorts;

  CreatedBy({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.image,
    this.bestShorts,
  });

  CreatedBy copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? image,
    List<String>? bestShorts,
  }) => CreatedBy(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    image: image ?? this.image,
    bestShorts: bestShorts ?? this.bestShorts,
  );

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    final shorts = json["bestShorts"] == null
        ? <String>[]
        : List<String>.from(json["bestShorts"].map((x) => x.toString()));

    final image =
        (json["image"] as String?) ?? (shorts.isNotEmpty ? shorts.first : null);

    return CreatedBy(
      id: json["_id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      image: image,
      bestShorts: shorts,
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "image": image,
    "bestShorts": bestShorts == null
        ? []
        : List<dynamic>.from(bestShorts!.map((x) => x)),
  };
}

class GroupPrompt {
  String? id;
  String? promptTitle;
  String? promptAnswer;
  String? type;
  List<double>? waves;
  String? duration;

  GroupPrompt({
    this.id,
    this.promptTitle,
    this.promptAnswer,
    this.type,
    this.waves,
    this.duration,
  });

  GroupPrompt copyWith({
    String? id,
    String? promptTitle,
    String? promptAnswer,
    String? type,
    List<double>? waves,
    String? duration,
  }) => GroupPrompt(
    id: id ?? this.id,
    promptTitle: promptTitle ?? this.promptTitle,
    promptAnswer: promptAnswer ?? this.promptAnswer,
    type: type ?? this.type,
    waves: waves ?? this.waves,
    duration: duration ?? this.duration,
  );

  factory GroupPrompt.fromJson(Map<String, dynamic> json) => GroupPrompt(
    id: json["_id"],
    promptTitle: json["promptTitle"],
    promptAnswer: json["promptAnswer"],
    type: json["type"],
    waves: json["waves"] == null
        ? []
        : List<double>.from(json["waves"]!.map((x) => x?.toDouble())),
    duration: json["duration"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "promptTitle": promptTitle,
    "promptAnswer": promptAnswer,
    "type": type,
    "waves": waves == null ? [] : List<dynamic>.from(waves!.map((x) => x)),
    "duration": duration,
  };
}

class GroupSettings {
  bool? anyoneCanInviteMembers;
  bool? anyoneCanUpdatePhotosVideos;
  bool? anyoneCanUpdatePrompts;
  String? id;

  GroupSettings({
    this.anyoneCanInviteMembers,
    this.anyoneCanUpdatePhotosVideos,
    this.anyoneCanUpdatePrompts,
    this.id,
  });

  GroupSettings copyWith({
    bool? anyoneCanInviteMembers,
    bool? anyoneCanUpdatePhotosVideos,
    bool? anyoneCanUpdatePrompts,
    String? id,
  }) => GroupSettings(
    anyoneCanInviteMembers:
        anyoneCanInviteMembers ?? this.anyoneCanInviteMembers,
    anyoneCanUpdatePhotosVideos:
        anyoneCanUpdatePhotosVideos ?? this.anyoneCanUpdatePhotosVideos,
    anyoneCanUpdatePrompts:
        anyoneCanUpdatePrompts ?? this.anyoneCanUpdatePrompts,
    id: id ?? this.id,
  );

  factory GroupSettings.fromJson(Map<String, dynamic> json) => GroupSettings(
    anyoneCanInviteMembers: json["anyoneCanInviteMembers"],
    anyoneCanUpdatePhotosVideos: json["anyoneCanUpdatePhotosVideos"],
    anyoneCanUpdatePrompts: json["anyoneCanUpdatePrompts"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "anyoneCanInviteMembers": anyoneCanInviteMembers,
    "anyoneCanUpdatePhotosVideos": anyoneCanUpdatePhotosVideos,
    "anyoneCanUpdatePrompts": anyoneCanUpdatePrompts,
    "_id": id,
  };
}
