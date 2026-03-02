// To parse this JSON data, do
//
//     final customPromptModel = customPromptModelFromJson(jsonString);

import 'dart:convert';

CustomPromptModel customPromptModelFromJson(String str) =>
    CustomPromptModel.fromJson(json.decode(str));

String customPromptModelToJson(CustomPromptModel data) =>
    json.encode(data.toJson());

class CustomPromptModel {
  bool? success;
  String? message;
  Data? data;

  CustomPromptModel({this.success, this.message, this.data});

  CustomPromptModel copyWith({bool? success, String? message, Data? data}) =>
      CustomPromptModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory CustomPromptModel.fromJson(Map<String, dynamic> json) =>
      CustomPromptModel(
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
  String? userId;
  String? promptTitle;
  String? type;
  String? promptAnswer;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Data({
    this.userId,
    this.promptTitle,
    this.type,
    this.promptAnswer,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Data copyWith({
    String? userId,
    String? promptTitle,
    String? type,
    String? promptAnswer,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) => Data(
    userId: userId ?? this.userId,
    promptTitle: promptTitle ?? this.promptTitle,
    type: type ?? this.type,
    promptAnswer: promptAnswer ?? this.promptAnswer,
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    v: v ?? this.v,
  );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["userId"],
    promptTitle: json["promptTitle"],
    type: json["type"],
    promptAnswer: json["promptAnswer"],
    id: json["_id"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "promptTitle": promptTitle,
    "type": type,
    "promptAnswer": promptAnswer,
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
