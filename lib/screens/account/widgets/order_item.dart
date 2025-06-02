import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_com_admin_web/providers/currency_provider.dart';
import 'package:shop_com_admin_web/utils/util.dart';

import '../../../utils/widgets/button_widget.dart';
import '../../../utils/widgets/custom_header_info.dart';

class OrderItem extends ConsumerStatefulWidget {
  final String? orderId;
  final String? orderStatus;
  final String? orderTime;
  final int? numberProducts;
  final double? totalAmount;

  const OrderItem(
      {super.key,
      this.orderId,
      this.orderStatus,
      this.orderTime,
      this.numberProducts,
      this.totalAmount});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderItemState();
}

class _OrderItemState extends ConsumerState<OrderItem> {
  final List statusOrder = ["pending", "processing", "delivered", "cancelled"];
  final List statusColor = [
    Colors.orange[600],
    Colors.blue[400],
    Colors.green[600],
    Colors.red[600]
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white, border: Border.all(color: Colors.grey)),
      child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 3,
            children: [
              CustomHeaderInfo(title: 'OrderID', value: '#${widget.orderId}'),
              CustomHeaderInfo(
                  title: 'Order time', value: widget.orderTime ?? ''),
              CustomHeaderInfo(
                  title: 'Total amount',
                  value:
                      formatMoney(money: widget.totalAmount ?? 0, currency: ref.watch(currencyProvider)),
                  headerFontWeight: FontWeight.w700,
                  fontSize: 16,
                  valueFontWeight: FontWeight.w700),
              Row(
                children: [
                  CommonButtonWidget(
                      callBack: () {
                        context.push('/orderDetail', extra: widget.orderId);
                      },
                      label: 'Details'),
                  const Spacer(),
                  Text(upperCaseFirstLetter(widget.orderStatus ?? ''),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: statusColor[
                              statusOrder.indexOf(widget.orderStatus)]))
                ],
              )
            ],
          )),
    );
  }
}
