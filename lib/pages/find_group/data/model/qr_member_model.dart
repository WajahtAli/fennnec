import 'dart:convert';

QrMemberModel qrMemberModelFromJson(String str) =>
    QrMemberModel.fromJson(json.decode(str));

String qrMemberModelToJson(QrMemberModel data) => json.encode(data.toJson());

class QrMemberModel {
  bool? success;
  String? message;
  QrMemberData? data;

  QrMemberModel({this.success, this.message, this.data});

  QrMemberModel copyWith({
    bool? success,
    String? message,
    QrMemberData? data,
  }) => QrMemberModel(
    success: success ?? this.success,
    message: message ?? this.message,
    data: data ?? this.data,
  );

  factory QrMemberModel.fromJson(Map<String, dynamic> json) => QrMemberModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : QrMemberData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class QrMemberData {
  String? id;
  String? firstName;
  String? lastName;
  String? image;
  String? qrCode;

  QrMemberData({
    this.id,
    this.firstName,
    this.lastName,
    this.image,
    this.qrCode,
  });

  factory QrMemberData.fromJson(Map<String, dynamic> json) => QrMemberData(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    image: json["image"],
    qrCode: json["qrCode"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "image": image,
    "qrCode": qrCode,
  };
}
