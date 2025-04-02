import 'dart:convert';

import 'package:shop_com/data/model/rating.dart';
import 'package:shop_com/data/model/variant.dart';

class Product {
  Ratings? ratings;
  String? id;
  String? name;
  String? description;
  String? category;
  String? brand;
  List<Variant>? variants;
  int? defaultVariant;
  bool? isActive;
  int? v;
  DateTime? createdAt;
  DateTime? updatedAt;

  Product({
    this.ratings,
    this.id,
    this.name,
    this.description,
    this.category,
    this.brand,
    this.variants,
    this.defaultVariant,
    this.isActive,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    ratings: Ratings.fromJson(json["ratings"]),
    id: json["_id"],
    name: json["name"],
    description: json["description"],
    category: json["category"],
    brand: json["brand"],
    variants: List<Variant>.from(json["variants"].map((x) => Variant.fromJson(x))),
    defaultVariant: json["defaultVariant"],
    isActive: json["isActive"],
    v: json["__v"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "ratings": ratings?.toJson(),
    "_id": id,
    "name": name,
    "description": description,
    "category": category,
    "brand": brand,
    "variants": List<dynamic>.from(variants!.map((x) => x.toJson())),
    "defaultVariant": defaultVariant,
    "isActive": isActive,
    "__v": v,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}