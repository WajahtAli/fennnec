import 'package:fennac_app/utils/validators.dart';

class Prompt {
  final String? id;
  final String? userId;
  final String? promptTitle;
  final String? type;
  final String? promptAnswer;
  final double? duration;
  final List<double>? waves;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Prompt({
    this.id,
    this.duration,
    this.userId,
    this.promptTitle,
    this.type,
    this.promptAnswer,
    this.waves,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Prompt.fromJson(Map<String, dynamic> json) => Prompt(
    id: validateString(json["_id"]),
    userId: validateString(json["userId"]),
    promptTitle: validateString(json["promptTitle"]),
    type: validateString(json["type"]),
    promptAnswer: validateString(json["promptAnswer"]),
    duration: validateDouble(json["duration"]),
    waves: (json["waves"] as List?)?.map((x) => validateDouble(x)).toList(),
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    v: validateInt(json["__v"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "promptTitle": promptTitle,
    "type": type,
    "promptAnswer": promptAnswer,
    "duration": duration,
    "waves": waves,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
