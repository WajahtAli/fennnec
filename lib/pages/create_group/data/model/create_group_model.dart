class CreateGroupResponseModel {
  bool? success;
  String? message;
  Data? data;

  CreateGroupResponseModel({this.success, this.message, this.data});

  factory CreateGroupResponseModel.fromJson(Map<String, dynamic> json) =>
      CreateGroupResponseModel(
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
  List<String>? members;
  String? createdBy;
  String? qrCode;
  String? titleMembers;
  String? bio;
  String? fitsForGroup;
  GroupSettings? groupSettings;
  List<String>? photosVideos;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? v;

  Data({
    this.members,
    this.createdBy,
    this.qrCode,
    this.titleMembers,
    this.bio,
    this.fitsForGroup,
    this.groupSettings,
    this.photosVideos,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    members: json["members"] == null
        ? []
        : List<String>.from(json["members"]!.map((x) => x)),
    createdBy: json["createdBy"],
    qrCode: json["qrCode"],
    titleMembers: json["title_members"],
    bio: json["bio"],
    fitsForGroup: json["fitsForGroup"],
    groupSettings: json["groupSettings"] == null
        ? null
        : GroupSettings.fromJson(json["groupSettings"]),
    photosVideos: json["photosVideos"] == null
        ? []
        : List<String>.from(json["photosVideos"]!.map((x) => x)),
    id: json["_id"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "members": members == null
        ? []
        : List<dynamic>.from(members!.map((x) => x)),
    "createdBy": createdBy,
    "qrCode": qrCode,
    "title_members": titleMembers,
    "bio": bio,
    "fitsForGroup": fitsForGroup,
    "groupSettings": groupSettings?.toJson(),
    "photosVideos": photosVideos == null
        ? []
        : List<dynamic>.from(photosVideos!.map((x) => x)),
    "_id": id,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
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
