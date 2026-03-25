class GroupInvitationModel {
  bool? success;
  String? message;
  Data? data;

  GroupInvitationModel({this.success, this.message, this.data});

  GroupInvitationModel copyWith({bool? success, String? message, Data? data}) =>
      GroupInvitationModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GroupInvitationModel.fromJson(Map<String, dynamic> json) =>
      GroupInvitationModel(
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
  List<Invitation>? invitations;
  DefaultScreen? defaultScreen;

  Data({this.invitations, this.defaultScreen});

  Data copyWith({
    List<Invitation>? invitations,
    DefaultScreen? defaultScreen,
  }) => Data(
    invitations: invitations ?? this.invitations,
    defaultScreen: defaultScreen ?? this.defaultScreen,
  );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    invitations: json["invitations"] == null
        ? []
        : List<Invitation>.from(
            json["invitations"]!.map((x) => Invitation.fromJson(x)),
          ),
    defaultScreen: json["defaultScreen"] == null
        ? null
        : DefaultScreen.fromJson(json["defaultScreen"]),
  );

  Map<String, dynamic> toJson() => {
    "invitations": invitations == null
        ? []
        : List<dynamic>.from(invitations!.map((x) => x.toJson())),
    "defaultScreen": defaultScreen?.toJson(),
  };
}

class DefaultScreen {
  String? coverImage;
  List<String>? membersImages;
  String? groupTitle;
  String? groupDesc;
  String? label;
  String? detail;

  DefaultScreen({
    this.coverImage,
    this.membersImages,
    this.groupTitle,
    this.groupDesc,
    this.label,
    this.detail,
  });

  DefaultScreen copyWith({
    String? coverImage,
    List<String>? membersImages,
    String? groupTitle,
    String? groupDesc,
    String? label,
    String? detail,
  }) => DefaultScreen(
    coverImage: coverImage ?? this.coverImage,
    membersImages: membersImages ?? this.membersImages,
    groupTitle: groupTitle ?? this.groupTitle,
    groupDesc: groupDesc ?? this.groupDesc,
    label: label ?? this.label,
    detail: detail ?? this.detail,
  );

  factory DefaultScreen.fromJson(Map<String, dynamic> json) => DefaultScreen(
    coverImage: json["coverImage"],
    membersImages: json["membersImages"] == null
        ? []
        : List<String>.from(json["membersImages"]!.map((x) => x)),
    groupTitle: json["groupTitle"],
    groupDesc: json["groupDesc"],
    label: json["label"],
    detail: json["detail"],
  );

  Map<String, dynamic> toJson() => {
    "coverImage": coverImage,
    "membersImages": membersImages == null
        ? []
        : List<dynamic>.from(membersImages!.map((x) => x)),
    "groupTitle": groupTitle,
    "groupDesc": groupDesc,
    "label": label,
    "detail": detail,
  };
}

class Invitation {
  String? invitationId;
  String? invitedVia;
  DateTime? sentAt;
  Inviter? inviter;
  bool? isAlreadyMember;
  Group? group;

  Invitation({
    this.invitationId,
    this.invitedVia,
    this.sentAt,
    this.inviter,
    this.isAlreadyMember,
    this.group,
  });

  Invitation copyWith({
    String? invitationId,
    String? invitedVia,
    DateTime? sentAt,
    Inviter? inviter,
    bool? isAlreadyMember,
    Group? group,
  }) => Invitation(
    invitationId: invitationId ?? this.invitationId,
    invitedVia: invitedVia ?? this.invitedVia,
    sentAt: sentAt ?? this.sentAt,
    inviter: inviter ?? this.inviter,
    isAlreadyMember: isAlreadyMember ?? this.isAlreadyMember,
    group: group ?? this.group,
  );

  factory Invitation.fromJson(Map<String, dynamic> json) => Invitation(
    invitationId: json["invitationId"],
    invitedVia: json["invitedVia"],
    sentAt: json["sentAt"] == null ? null : DateTime.parse(json["sentAt"]),
    inviter: json["inviter"] == null ? null : Inviter.fromJson(json["inviter"]),
    isAlreadyMember: json["isAlreadyMember"],
    group: json["group"] == null ? null : Group.fromJson(json["group"]),
  );

  Map<String, dynamic> toJson() => {
    "invitationId": invitationId,
    "invitedVia": invitedVia,
    "sentAt": sentAt?.toIso8601String(),
    "inviter": inviter?.toJson(),
    "isAlreadyMember": isAlreadyMember,
    "group": group?.toJson(),
  };
}

class Group {
  String? id;
  String? name;
  String? title;
  String? titleMembers;
  String? bio;
  String? fitsForGroup;
  List<String>? photosVideos;
  List<Member>? members;

  Group({
    this.id,
    this.name,
    this.title,
    this.titleMembers,
    this.bio,
    this.fitsForGroup,
    this.photosVideos,
    this.members,
  });

  Group copyWith({
    String? id,
    String? name,
    String? title,
    String? titleMembers,
    String? bio,
    String? fitsForGroup,
    List<String>? photosVideos,
    List<Member>? members,
  }) => Group(
    id: id ?? this.id,
    name: name ?? this.name,
    title: title ?? this.title,
    titleMembers: titleMembers ?? this.titleMembers,
    bio: bio ?? this.bio,
    fitsForGroup: fitsForGroup ?? this.fitsForGroup,
    photosVideos: photosVideos ?? this.photosVideos,
    members: members ?? this.members,
  );

  factory Group.fromJson(Map<String, dynamic> json) => Group(
    id: json["_id"],
    name: json["name"],
    title: json["title"],
    titleMembers: json["titleMembers"],
    bio: json["bio"],
    fitsForGroup: json["fitsForGroup"],
    photosVideos: json["photosVideos"] == null
        ? []
        : List<String>.from(json["photosVideos"]!.map((x) => x)),
    members: json["members"] == null
        ? []
        : List<Member>.from(json["members"]!.map((x) => Member.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "title": title,
    "titleMembers": titleMembers,
    "bio": bio,
    "fitsForGroup": fitsForGroup,
    "photosVideos": photosVideos == null
        ? []
        : List<dynamic>.from(photosVideos!.map((x) => x)),
    "members": members == null
        ? []
        : List<dynamic>.from(members!.map((x) => x.toJson())),
  };
}

class Member {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? image;

  Member({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.image,
  });

  Member copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? image,
  }) => Member(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    image: image ?? this.image,
  );

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    phone: json["phone"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "phone": phone,
    "image": image,
  };
}

class Inviter {
  String? id;
  String? firstName;
  String? lastName;
  String? email;

  Inviter({this.id, this.firstName, this.lastName, this.email});

  Inviter copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
  }) => Inviter(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
  );

  factory Inviter.fromJson(Map<String, dynamic> json) => Inviter(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
  };
}
