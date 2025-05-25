class Coupon {
  String? id;
  String? code;
  String? discountType;
  int? discountValue;
  int? minOrderValue;
  DateTime? expirationDate;

  Coupon({
    this.id,
    this.code,
    this.discountType,
    this.discountValue,
    this.minOrderValue,
    this.expirationDate,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
    id: json["_id"],
    code: json["code"],
    discountType: json["discountType"],
    discountValue: json["discountValue"],
    minOrderValue: json["minOrderValue"],
    expirationDate: DateTime.parse(json["expirationDate"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "code": code,
    "discountType": discountType,
    "discountValue": discountValue,
    "minOrderValue": minOrderValue,
    "expirationDate": expirationDate?.toIso8601String(),
  };
}