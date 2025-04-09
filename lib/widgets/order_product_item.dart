import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_com/widgets/custom_header_info.dart';

class OrderProductItem extends StatefulWidget {
  final String? imageUrl;
  final String? brand;
  final String? name;
  final String? color;
  final String? unit;
  final String? ram;
  final String? price;
  final bool? isFavorite;
  final int index;

  const OrderProductItem(
      {super.key,
      this.imageUrl,
      this.brand,
      this.name,
      this.color,
      this.price,
      this.unit,
      this.ram,
      required this.index,
      this.isFavorite = false});

  @override
  State<OrderProductItem> createState() => _OrderProductItemState();
}

class _OrderProductItemState extends State<OrderProductItem> {
  ValueNotifier<int> countProduct = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 140,
            // decoration: BoxDecoration(
            //   color: Colors.grey[200],
            //   borderRadius: BorderRadius.circular(12),
            // ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.imageUrl ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Color ${widget.color}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Ram ${widget.ram}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 50,
                        child: CustomHeaderInfo(
                          title: 'Unit',
                          value: widget.unit ?? '',
                          headerWidth: 30,
                          fontSize: 14,
                          infoFontWeight: FontWeight.w700,
                        )),
                    Text('${widget.price}\$',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
