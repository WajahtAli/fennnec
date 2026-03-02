// To parse this JSON data, do
//
//     final pockModel = pockModelFromJson(jsonString);

import 'dart:convert';

PockModel pockModelFromJson(String str) => PockModel.fromJson(json.decode(str));

String pockModelToJson(PockModel data) => json.encode(data.toJson());

class PockModel {
  final bool? success;
  final String? message;
  final PokeData? data;

  PockModel({this.success, this.message, this.data});

  PockModel copyWith({bool? success, String? message, PokeData? data}) =>
      PockModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory PockModel.fromJson(Map<String, dynamic> json) => PockModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : PokeData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class PokeData {
  final List<Product>? products;

  PokeData({this.products});

  PokeData copyWith({List<Product>? products}) =>
      PokeData(products: products ?? this.products);

  factory PokeData.fromJson(Map<String, dynamic> json) => PokeData(
    products: json["products"] == null
        ? []
        : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "products": products == null
        ? []
        : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Product {
  final String? id;
  final String? name;
  final int? pokeCount;
  final double? priceUsd;

  Product({this.id, this.name, this.pokeCount, this.priceUsd});

  Product copyWith({
    String? id,
    String? name,
    int? pokeCount,
    double? priceUsd,
  }) => Product(
    id: id ?? this.id,
    name: name ?? this.name,
    pokeCount: pokeCount ?? this.pokeCount,
    priceUsd: priceUsd ?? this.priceUsd,
  );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"] ?? json["_id"],
    name: json["name"],
    pokeCount: json["pokeCount"] is int
        ? json["pokeCount"]
        : int.tryParse('${json["pokeCount"] ?? 0}'),
    priceUsd: json["priceUsd"] is num
        ? (json["priceUsd"] as num).toDouble()
        : double.tryParse('${json["priceUsd"] ?? 0}'),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "pokeCount": pokeCount,
    "priceUsd": priceUsd,
  };
}
