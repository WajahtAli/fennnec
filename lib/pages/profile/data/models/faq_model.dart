import 'package:fennac_app/models/dummy/faq_item_model.dart';

class FaqResponseModel {
  bool? success;
  String? message;
  FaqData? data;

  FaqResponseModel({this.success, this.message, this.data});

  factory FaqResponseModel.fromJson(Map<String, dynamic> json) =>
      FaqResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : FaqData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class FaqData {
  List<FaqModel>? faqs;
  PaginationModel? pagination;

  FaqData({this.faqs, this.pagination});

  factory FaqData.fromJson(Map<String, dynamic> json) => FaqData(
    faqs: json["faqs"] == null
        ? []
        : List<FaqModel>.from(json["faqs"]!.map((x) => FaqModel.fromJson(x))),
    pagination: json["pagination"] == null
        ? null
        : PaginationModel.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "faqs": faqs == null
        ? []
        : List<dynamic>.from(faqs!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class FaqModel {
  String? id;
  String? question;
  String? answer;
  String? status;
  String? addedBy;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? updatedBy;

  FaqModel({
    this.id,
    this.question,
    this.answer,
    this.status,
    this.addedBy,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.updatedBy,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
    id: json["_id"],
    question: json["question"],
    answer: json["answer"],
    status: json["status"],
    addedBy: json["addedBy"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    v: json["__v"],
    updatedBy: json["updatedBy"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "question": question,
    "answer": answer,
    "status": status,
    "addedBy": addedBy,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
    "updatedBy": updatedBy,
  };

  // Convert FaqModel to FaqItem for UI
  FaqItem toFaqItem() {
    return FaqItem(
      question: question ?? '',
      answer: _stripHtmlTags(answer ?? ''),
    );
  }

  // Helper method to strip HTML tags from answer
  String _stripHtmlTags(String htmlString) {
    final RegExp exp = RegExp(
      r"<[^>]*>",
      multiLine: true,
      caseSensitive: false,
    );
    return htmlString.replaceAll(exp, '').trim();
  }
}

class PaginationModel {
  int? page;
  int? limit;
  int? total;
  int? totalPages;

  PaginationModel({this.page, this.limit, this.total, this.totalPages});

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      PaginationModel(
        page: json["page"],
        limit: json["limit"],
        total: json["total"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "total": total,
    "totalPages": totalPages,
  };
}
