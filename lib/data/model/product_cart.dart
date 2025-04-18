import 'dart:convert';

class ProductCart {
  ProductCart? productId;
  int? variantIndex;
  double? price;
  int? quantity;
  String? id;

  ProductCart({
    this.productId,
    this.variantIndex,
    this.price,
    this.quantity,
    this.id,
  });

  factory ProductCart.fromRawJson(String str) => ProductCart.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductCart.fromJson(Map<String, dynamic> json) => ProductCart(
    productId: ProductCart.fromJson(json["productId"]),
    variantIndex: json["variantIndex"],
    price: (json["price"] as num?)?.toDouble() ?? 0.0,
    quantity: json["quantity"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId?.toJson(),
    "variantIndex": variantIndex,
    "price": price,
    "quantity": quantity,
    "_id": id,
  };
}