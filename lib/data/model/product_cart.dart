import 'dart:convert';

import 'package:shop_com_admin_web/data/model/variant.dart';

class ProductCart {
  String? productId;
  int? variantIndex;
  List<Variant>? variantProduct;
  double? price;
  int? quantity;
  String? id;
  String? productName;
  String? productDescription;
  String? productCategory;
  String? productBrand;

  ProductCart(
      {this.productId,
      this.variantIndex,
      this.variantProduct,
      this.price,
      this.quantity,
      this.id,
      this.productName,
      this.productDescription,
      this.productCategory,
      this.productBrand});

  factory ProductCart.fromRawJson(String str) =>
      ProductCart.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductCart.fromJson(Map<String, dynamic> json) => ProductCart(
        productId: json["productId"],
        variantIndex: json["variantIndex"],
        variantProduct: json["variantProduct"] != null
            ? List<Variant>.from(
                (json["variantProduct"] as List).map(
                  (x) => Variant.fromJson(x),
                ),
              )
            : [],
        price: (json["price"] as num?)?.toDouble() ?? 0.0,
        quantity: json["quantity"],
        id: json["_id"],
        productName: json["productName"],
        productDescription: json["productDescription"],
        productCategory: json["productCategory"],
        productBrand: json["productBrand"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "variantIndex": variantIndex,
        "variantProduct":
            List<dynamic>.from(variantProduct!.map((x) => x.toJson())),
        "price": price,
        "quantity": quantity,
        "_id": id,
        "productName": productName,
        "productDescription": productDescription,
        "productCategory": productCategory,
        "productBrand": productBrand
      };
}
