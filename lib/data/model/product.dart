import 'dart:convert';

import 'package:shop_com/data/model/rating.dart';
import 'package:shop_com/data/model/variant.dart';
import 'package:shop_com/utils/util.dart';

class Product {
  String? id;
  String? name;
  String? description;
  String? category;
  String? brand;
  Variant? defaultVariant;
  List<Variant>? variants;
  Ratings? ratings;
  bool? isActive;
  DateTime? createdAt;

  Product({
    this.id,
    this.name,
    this.description,
    this.category,
    this.brand,
    this.defaultVariant,
    this.variants,
    this.ratings,
    this.isActive,
    this.createdAt,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["_id"],
    name: json["name"],
    description: json["description"],
    category: json["category"],
    brand: json["brand"],
    defaultVariant: Variant.fromJson(json["defaultVariant"]),
    variants: List<Variant>.from(json["variants"].map((x) => Variant.fromJson(x))),
    ratings: Ratings.fromJson(json["ratings"]),
    isActive: json["isActive"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "description": description,
    "category": category,
    "brand": brand,
    "defaultVariant": defaultVariant?.toJson(),
    "variants": List<dynamic>.from(variants!.map((x) => x.toJson())),
    "ratings": ratings?.toJson(),
    "isActive": isActive,
    "createdAt": getStringFromDateTime(createdAt ?? DateTime(0), 'dd/MM/yyyy'),
  };
}