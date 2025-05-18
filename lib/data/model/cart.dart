import 'dart:convert';

import 'package:shop_com_admin_web/data/model/product_cart.dart';

class Cart {
  String? id;
  String? userId;
  List<ProductCart>? products;
  double? totalPrice;
  bool? isCheckoutCompleted;
  DateTime? createdAt;
  int? v;

  Cart({
    this.id,
    this.userId,
    this.products,
    this.totalPrice,
    this.isCheckoutCompleted,
    this.createdAt,
    this.v,
  });

  factory Cart.empty() => Cart(id: '', products: [], totalPrice: 0);

  factory Cart.fromRawJson(String str) => Cart.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["_id"],
        userId: json["userId"],
        products: List<ProductCart>.from(
            json["products"].map((x) => ProductCart.fromJson(x))),
        totalPrice: (json["totalPrice"] as num?)?.toDouble() ?? 0.0,
        isCheckoutCompleted: json["isCheckoutCompleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
        "totalPrice": totalPrice,
        "isCheckoutCompleted": isCheckoutCompleted,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
      };
}
