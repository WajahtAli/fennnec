// To parse this JSON data, do
//
//     final getMembersModel = getMembersModelFromJson(jsonString);

import 'dart:convert';

GetMembersModel getMembersModelFromJson(String str) =>
    GetMembersModel.fromJson(json.decode(str));

String getMembersModelToJson(GetMembersModel data) =>
    json.encode(data.toJson());

class GetMembersModel {
  bool? success;
  String? message;
  Data? data;

  GetMembersModel({this.success, this.message, this.data});

  GetMembersModel copyWith({bool? success, String? message, Data? data}) =>
      GetMembersModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetMembersModel.fromJson(Map<String, dynamic> json) =>
      GetMembersModel(
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
  List<Member>? members;
  List<NotFennecMember>? notFennecMembers;
  Pagination? pagination;

  Data({this.members, this.notFennecMembers, this.pagination});

  Data copyWith({
    List<Member>? members,
    List<NotFennecMember>? notFennecMembers,
    Pagination? pagination,
  }) => Data(
    members: members ?? this.members,
    notFennecMembers: notFennecMembers ?? this.notFennecMembers,
    pagination: pagination ?? this.pagination,
  );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    members: json["members"] == null
        ? []
        : List<Member>.from(json["members"]!.map((x) => Member.fromJson(x))),
    notFennecMembers: json["not_fennec_members"] == null
        ? []
        : List<NotFennecMember>.from(
            json["not_fennec_members"]!.map((x) => NotFennecMember.fromJson(x)),
          ),
    pagination: json["pagination"] == null
        ? null
        : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "members": members == null
        ? []
        : List<dynamic>.from(members!.map((x) => x.toJson())),
    "not_fennec_members": notFennecMembers == null
        ? []
        : List<dynamic>.from(notFennecMembers!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Member {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;

  Member({this.id, this.firstName, this.lastName, this.email, this.phone});

  Member copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
  }) => Member(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    phone: phone ?? this.phone,
  );

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "phone": phone,
  };
}

class NotFennecMember {
  String? phone;
  String? invitePhone;

  NotFennecMember({this.phone, this.invitePhone});

  NotFennecMember copyWith({String? phone, String? invitePhone}) =>
      NotFennecMember(
        phone: phone ?? this.phone,
        invitePhone: invitePhone ?? this.invitePhone,
      );

  factory NotFennecMember.fromJson(Map<String, dynamic> json) =>
      NotFennecMember(phone: json["phone"], invitePhone: json["invitePhone"]);

  Map<String, dynamic> toJson() => {"phone": phone, "invitePhone": invitePhone};
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
