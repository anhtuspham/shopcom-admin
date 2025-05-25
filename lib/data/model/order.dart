import 'dart:convert';

import 'package:shop_com_admin_web/data/model/product_cart.dart';
import 'package:shop_com_admin_web/utils/util.dart';

import 'coupon.dart';

class Order {
  String? id;
  UserId? userId;
  List<ProductCart>? products;
  double? totalAmount;
  double? discountAmount;
  double? finalAmount;
  Coupon? coupon;
  String? status;
  String? address;
  String? paymentMethod;
  DateTime? createdAt;

  int? v;

  Order({
    this.id,
    this.userId,
    this.products,
    this.totalAmount,
    this.discountAmount,
    this.finalAmount,
    this.coupon,
    this.status,
    this.address,
    this.paymentMethod,
    this.createdAt,
    this.v,
  });

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  factory Order.empty() => Order();

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["_id"],
    userId: UserId.fromJson(json['userId']),
    products: List<ProductCart>.from(
        json["products"].map((x) => ProductCart.fromJson(x))),
    totalAmount: json["totalAmount"].toDouble(),
    discountAmount: json["discountAmount"].toDouble(),
    finalAmount: json["finalAmount"].toDouble(),
    coupon: json['coupon'] != null ? Coupon.fromJson(json['coupon']) : Coupon.empty(),
    status: json["status"],
    address: json["address"],
    paymentMethod: json["paymentMethod"] ?? '',
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "Tên người dùng": userId?.name,
    // "products": List<dynamic>.from(products!.map((x) => x.toJson())),
    "Tiền đơn hàng": totalAmount,
    "Giảm giá": discountAmount,
    "Tổng tiền": finalAmount,
    "Mã giảm giá": coupon?.code,
    "Trạng thái": status,
    "Địa chỉ": address,
    "Phương thức thanh toán": paymentMethod,
    "Ngày mua": getStringFromDateTime(createdAt ?? DateTime.now(), 'dd/MM/yyyy hh:mm:ss'),
  };
}

class UserId {
  String id;
  String name;
  String email;

  UserId({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
  };
}
