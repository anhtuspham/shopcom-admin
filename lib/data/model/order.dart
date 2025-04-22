import 'dart:convert';

import 'package:shop_com/data/model/product_cart.dart';

class Order {
  String? userId;
  List<ProductCart>? products;
  double? totalAmount;
  String? status;
  String? paymentMethod;
  String? id;
  DateTime? createdAt;
  int? v;

  Order({
    this.userId,
    this.products,
    this.totalAmount,
    this.status,
    this.paymentMethod,
    this.id,
    this.createdAt,
    this.v,
  });

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  factory Order.empty() => Order();

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    userId: json["userId"],
    products: List<ProductCart>.from(
        json["products"].map((x) => ProductCart.fromJson(x))),
    totalAmount: json["totalAmount"].toDouble(),
    status: json["status"],
    paymentMethod: json["paymentMethod"],
    id: json["_id"],
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "products": List<dynamic>.from(products!.map((x) => x.toJson())),
    "totalAmount": totalAmount,
    "status": status,
    "paymentMethod": paymentMethod,
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "__v": v,
  };
}