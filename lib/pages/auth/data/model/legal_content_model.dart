class LegalContentModel {
  bool? success;
  String? message;
  Data? data;

  LegalContentModel({this.success, this.message, this.data});

  LegalContentModel copyWith({bool? success, String? message, Data? data}) =>
      LegalContentModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory LegalContentModel.fromJson(Map<String, dynamic> json) =>
      LegalContentModel(
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
  List<LegalContent>? legalContent;

  Data({this.legalContent});

  Data copyWith({List<LegalContent>? legalContent}) =>
      Data(legalContent: legalContent ?? this.legalContent);

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    legalContent: json["legalContent"] == null
        ? []
        : List<LegalContent>.from(
            json["legalContent"]!.map((x) => LegalContent.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "legalContent": legalContent == null
        ? []
        : List<dynamic>.from(legalContent!.map((x) => x.toJson())),
  };
}

class LegalContent {
  String? id;
  String? title;
  String? content;
  String? status;
  String? addedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? updatedBy;

  LegalContent({
    this.id,
    this.title,
    this.content,
    this.status,
    this.addedBy,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.updatedBy,
  });

  LegalContent copyWith({
    String? id,
    String? title,
    String? content,
    String? status,
    String? addedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    String? updatedBy,
  }) => LegalContent(
    id: id ?? this.id,
    title: title ?? this.title,
    content: content ?? this.content,
    status: status ?? this.status,
    addedBy: addedBy ?? this.addedBy,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    v: v ?? this.v,
    updatedBy: updatedBy ?? this.updatedBy,
  );

  factory LegalContent.fromJson(Map<String, dynamic> json) => LegalContent(
    id: json["_id"],
    title: json["title"],
    content: json["content"],
    status: json["status"],
    addedBy: json["addedBy"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    updatedBy: json["updatedBy"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "content": content,
    "status": status,
    "addedBy": addedBy,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "updatedBy": updatedBy,
  };
}
