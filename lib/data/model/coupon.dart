import 'package:shop_com_admin_web/utils/util.dart';

class Coupon {
  String? id;
  String? code;
  String? discountType;
  int? discountValue;
  int? minOrderValue;
  int? maxDiscountAmount;
  DateTime? expirationDate;
  bool? isActive;
  int? usageLimit;
  int? usedCount;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Coupon({
    this.id,
    this.code,
    this.discountType,
    this.discountValue,
    this.minOrderValue,
    this.maxDiscountAmount,
    this.expirationDate,
    this.isActive,
    this.usageLimit,
    this.usedCount,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Coupon.empty() => Coupon(
      id: '',
      code: '',
      discountType: '',
      discountValue: 0,
      minOrderValue: 0,
      maxDiscountAmount: 0,
      expirationDate: DateTime.now(),
      isActive: true,
      usageLimit: 0,
      usedCount: 0);

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        id: json["_id"],
        code: json["code"],
        discountType: json["discountType"],
        discountValue: json["discountValue"],
        minOrderValue: json["minOrderValue"],
        maxDiscountAmount: json["maxDiscountAmount"],
        expirationDate: DateTime.parse(json["expirationDate"]),
        isActive: json["isActive"],
        usageLimit: json["usageLimit"],
        usedCount: json["usedCount"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        // "_id": id,
        "Mã khuyến mãi": code,
        "Loại giảm giá": discountType,
        "Giá trị giảm giá": discountValue,
        "Đơn hàng tối thiểu": minOrderValue,
        "Giảm tối đa": maxDiscountAmount,
        "Ngày hết hạn": getStringFromDateTime(expirationDate ?? DateTime.now(), 'dd/MM/yyyy hh:mm:ss'),
        "Trạng thái": isActive,
        "Số lượng": usageLimit,
        "Đã sử dụng": usedCount,
        "Ngày tạo": getStringFromDateTime(createdAt ?? DateTime.now(), 'dd/MM/yyyy hh:mm:ss'),
        "Cập nhật": getStringFromDateTime(updatedAt ?? DateTime.now(), 'dd/MM/yyyy hh:mm:ss'),
      };
}
