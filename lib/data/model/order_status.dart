class OrderStatus {
  int? count;
  String? status;

  OrderStatus({
    this.count,
     this.status,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
    count: json["count"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "status": status,
  };
}