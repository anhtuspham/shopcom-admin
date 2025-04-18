import 'dart:convert';

class ProductId {
  String? id;
  String? name;
  String? category;
  String? brand;

  ProductId({
    this.id,
    this.name,
    this.category,
    this.brand,
  });

  factory ProductId.fromRawJson(String str) => ProductId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
    id: json["_id"],
    name: json["name"],
    category: json["category"],
    brand: json["brand"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "category": category,
    "brand": brand,
  };
}