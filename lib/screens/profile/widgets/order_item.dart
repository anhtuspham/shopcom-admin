import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';

class OrderItem extends StatefulWidget {

  const OrderItem({super.key});

  @override
  State<StatefulWidget> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      borderRadius: BorderRadius.circular(8),
      elevation: 2,
      shadowColor: Colors.grey.withValues(),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white),
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 3,
              children: [
                const Row(
                  children: [
                    Text('Order: No1999'),
                    Spacer(),
                    Text('12/12/2023'),
                  ],
                ),
                const Text('Tracking number: IW3452344'),
                Row(
                  children: [
                    const Text('Quantity: 3'),
                    const Spacer(),
                    RichText(
                        text: const TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                          TextSpan(text: 'Total Amount: '),
                          TextSpan(
                              text: '112\$',
                              style: TextStyle(fontWeight: FontWeight.w700))
                        ])),
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        context.push('/orderDetail');
                      },
                      style: ButtonStyle(
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                              side: BorderSide(color: Colors.black)))),
                      child: Text('Details'),
                    ),
                    const Spacer(),
                    const Text('Delivered',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.green))
                  ],
                )
              ],
            )),
      ),
    );
  }
}
