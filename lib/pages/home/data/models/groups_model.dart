// To parse this JSON data, do
//
//     final groupsModel = groupsModelFromJson(jsonString);

import 'dart:convert';

GroupsModel groupsModelFromJson(String str) =>
    GroupsModel.fromJson(json.decode(str));

String groupsModelToJson(GroupsModel data) => json.encode(data.toJson());

class GroupsModel {
  bool? success;
  String? message;
  GroupsData? data;

  GroupsModel({this.success, this.message, this.data});

  GroupsModel copyWith({bool? success, String? message, GroupsData? data}) =>
      GroupsModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GroupsModel.fromJson(Map<String, dynamic> json) => GroupsModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : GroupsData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class GroupsData {
  List<Group>? groups;
  Pagination? pagination;

  GroupsData({this.groups, this.pagination});

  GroupsData copyWith({List<Group>? groups, Pagination? pagination}) =>
      GroupsData(
        groups: groups ?? this.groups,
        pagination: pagination ?? this.pagination,
      );

  factory GroupsData.fromJson(Map<String, dynamic> json) => GroupsData(
    groups: json["groups"] == null
        ? []
        : List<Group>.from(json["groups"]!.map((x) => Group.fromJson(x))),
    pagination: json["pagination"] == null
        ? null
        : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "groups": groups == null
        ? []
        : List<dynamic>.from(groups!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Group {
  String? id;
  String? name;
  String? description;
  String? coverImage;
  String? groupTag;
  List<String>? photosVideos;
  List<GroupMember>? groupMembers;
  List<GroupPrompt>? groupPrompts;
  List<Member>? members;

  Group({
    this.id,
    this.name,
    this.description,
    this.coverImage,
    this.groupTag,
    this.photosVideos,
    this.groupMembers,
    this.groupPrompts,
    this.members,
  });

  Group copyWith({
    String? id,
    String? name,
    String? description,
    String? coverImage,
    String? groupTag,
    List<String>? photosVideos,
    List<GroupMember>? groupMembers,
    List<GroupPrompt>? groupPrompts,
    List<Member>? members,
  }) => Group(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    coverImage: coverImage ?? this.coverImage,
    groupTag: groupTag ?? this.groupTag,
    photosVideos: photosVideos ?? this.photosVideos,
    groupMembers: groupMembers ?? this.groupMembers,
    groupPrompts: groupPrompts ?? this.groupPrompts,
    members: members ?? this.members,
  );

  factory Group.fromJson(Map<String, dynamic> json) => Group(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    coverImage: json["coverImage"],
    groupTag: json["groupTag"],
    photosVideos: json["photosVideos"] == null
        ? []
        : List<String>.from(json["photosVideos"]!.map((x) => x)),
    groupMembers: json["groupMembers"] == null
        ? []
        : List<GroupMember>.from(
            json["groupMembers"]!.map((x) => GroupMember.fromJson(x)),
          ),
    groupPrompts: json["groupPrompts"] == null
        ? []
        : List<GroupPrompt>.from(
            json["groupPrompts"]!.map((x) => GroupPrompt.fromJson(x)),
          ),
    members: json["members"] == null
        ? []
        : List<Member>.from(json["members"]!.map((x) => Member.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "coverImage": coverImage,
    "groupTag": groupTag,
    "photosVideos": photosVideos == null
        ? []
        : List<dynamic>.from(photosVideos!.map((x) => x)),
    "groupMembers": groupMembers == null
        ? []
        : List<dynamic>.from(groupMembers!.map((x) => x.toJson())),
    "groupPrompts": groupPrompts == null
        ? []
        : List<dynamic>.from(groupPrompts!.map((x) => x.toJson())),
    "members": members == null
        ? []
        : List<dynamic>.from(members!.map((x) => x.toJson())),
  };
}

class GroupPrompt {
  String? id;
  String? promptTitle;
  String? promptAnswer;
  String? type;

  GroupPrompt({this.id, this.promptTitle, this.promptAnswer, this.type});

  GroupPrompt copyWith({
    String? id,
    String? promptTitle,
    String? promptAnswer,
    String? type,
  }) => GroupPrompt(
    id: id ?? this.id,
    promptTitle: promptTitle ?? this.promptTitle,
    promptAnswer: promptAnswer ?? this.promptAnswer,
    type: type ?? this.type,
  );

  factory GroupPrompt.fromJson(Map<String, dynamic> json) => GroupPrompt(
    id: json["_id"],
    promptTitle: json["promptTitle"],
    promptAnswer: json["promptAnswer"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "promptTitle": promptTitle,
    "promptAnswer": promptAnswer,
    "type": type,
  };
}

class GroupMember {
  String? id;
  String? name;
  String? image;

  GroupMember({this.id, this.name, this.image});

  GroupMember copyWith({String? id, String? name, String? image}) =>
      GroupMember(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
      );

  factory GroupMember.fromJson(Map<String, dynamic> json) =>
      GroupMember(id: json["_id"], name: json["name"], image: json["image"]);

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "image": image};
}

class Member {
  String? id;
  String? firstName;
  String? name;
  int? age;
  String? bio;
  String? coverImage;
  String? gender;
  String? orientation;
  String? pronouns;
  dynamic location;
  dynamic distance;
  String? education;
  String? profession;
  List<String>? interests;
  List<String>? images;
  List<String>? bestShorts;
  dynamic promptTitle;
  dynamic promptAnswer;
  List<GroupPrompt>? prompts;
  List<String>? lifestyle;

  Member({
    this.id,
    this.firstName,
    this.name,
    this.age,
    this.bio,
    this.coverImage,
    this.gender,
    this.orientation,
    this.pronouns,
    this.location,
    this.distance,
    this.education,
    this.profession,
    this.interests,
    this.images,
    this.bestShorts,
    this.promptTitle,
    this.promptAnswer,
    this.prompts,
    this.lifestyle,
  });

  Member copyWith({
    String? id,
    String? firstName,
    String? name,
    int? age,
    String? bio,
    String? coverImage,
    String? gender,
    String? orientation,
    String? pronouns,
    dynamic location,
    dynamic distance,
    String? education,
    String? profession,
    List<String>? interests,
    List<String>? images,
    List<String>? bestShorts,
    dynamic promptTitle,
    dynamic promptAnswer,
    List<GroupPrompt>? prompts,
    List<String>? lifestyle,
  }) => Member(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    name: name ?? this.name,
    age: age ?? this.age,
    bio: bio ?? this.bio,
    coverImage: coverImage ?? this.coverImage,
    gender: gender ?? this.gender,
    orientation: orientation ?? this.orientation,
    pronouns: pronouns ?? this.pronouns,
    location: location ?? this.location,
    distance: distance ?? this.distance,
    education: education ?? this.education,
    profession: profession ?? this.profession,
    interests: interests ?? this.interests,
    images: images ?? this.images,
    bestShorts: bestShorts ?? this.bestShorts,
    promptTitle: promptTitle ?? this.promptTitle,
    promptAnswer: promptAnswer ?? this.promptAnswer,
    prompts: prompts ?? this.prompts,
    lifestyle: lifestyle ?? this.lifestyle,
  );

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    id: json["id"],
    firstName: json["firstName"],
    name: json["name"],
    age: json["age"],
    bio: json["bio"],
    coverImage: json["coverImage"],
    gender: json["gender"],
    orientation: json["orientation"],
    pronouns: json["pronouns"],
    location: json["location"],
    distance: json["distance"],
    education: json["education"],
    profession: json["profession"],
    interests: json["interests"] == null
        ? []
        : List<String>.from(json["interests"]!.map((x) => x)),
    images: json["images"] == null
        ? []
        : List<String>.from(json["images"]!.map((x) => x)),
    bestShorts: json["bestShorts"] == null
        ? []
        : List<String>.from(json["bestShorts"]!.map((x) => x)),
    promptTitle: json["promptTitle"],
    promptAnswer: json["promptAnswer"],
    prompts: json["prompts"] == null
        ? []
        : List<GroupPrompt>.from(
            json["prompts"]!.map((x) => GroupPrompt.fromJson(x)),
          ),
    lifestyle: json["lifestyle"] == null
        ? []
        : List<String>.from(json["lifestyle"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "name": name,
    "age": age,
    "bio": bio,
    "coverImage": coverImage,
    "gender": gender,
    "orientation": orientation,
    "pronouns": pronouns,
    "location": location,
    "distance": distance,
    "education": education,
    "profession": profession,
    "interests": interests == null
        ? []
        : List<dynamic>.from(interests!.map((x) => x)),
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "bestShorts": bestShorts == null
        ? []
        : List<dynamic>.from(bestShorts!.map((x) => x)),
    "promptTitle": promptTitle,
    "promptAnswer": promptAnswer,
    "prompts": prompts == null
        ? []
        : List<dynamic>.from(prompts!.map((x) => x.toJson())),
    "lifestyle": lifestyle == null
        ? []
        : List<dynamic>.from(lifestyle!.map((x) => x)),
  };
}

class Pagination {
  int? currentPage;
  int? limit;
  int? totalPages;
  int? totalItems;
  bool? hasNextPage;
  bool? hasPreviousPage;

  Pagination({
    this.currentPage,
    this.limit,
    this.totalPages,
    this.totalItems,
    this.hasNextPage,
    this.hasPreviousPage,
  });

  Pagination copyWith({
    int? currentPage,
    int? limit,
    int? totalPages,
    int? totalItems,
    bool? hasNextPage,
    bool? hasPreviousPage,
  }) => Pagination(
    currentPage: currentPage ?? this.currentPage,
    limit: limit ?? this.limit,
    totalPages: totalPages ?? this.totalPages,
    totalItems: totalItems ?? this.totalItems,
    hasNextPage: hasNextPage ?? this.hasNextPage,
    hasPreviousPage: hasPreviousPage ?? this.hasPreviousPage,
  );

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    currentPage: json["currentPage"],
    limit: json["limit"],
    totalPages: json["totalPages"],
    totalItems: json["totalItems"],
    hasNextPage: json["hasNextPage"],
    hasPreviousPage: json["hasPreviousPage"],
  );

  Map<String, dynamic> toJson() => {
    "currentPage": currentPage,
    "limit": limit,
    "totalPages": totalPages,
    "totalItems": totalItems,
    "hasNextPage": hasNextPage,
    "hasPreviousPage": hasPreviousPage,
  };
}
