import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductBagItem extends StatefulWidget {
  final String? imageUrl;
  final String? brand;
  final String? name;
  final String? color;
  final String? ram;

  const ProductBagItem(
      {super.key, this.imageUrl, this.brand, this.name, this.color, this.ram});

  @override
  State<ProductBagItem> createState() => _ProductBagItemState();
}

class _ProductBagItemState extends State<ProductBagItem> {
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
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border_outlined)),
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '124\$',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold, )),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: _increment,
                          color: Colors.grey[600],
                          style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.white),
                              shape: WidgetStatePropertyAll(CircleBorder(
                                  side: BorderSide(color: Colors.black12)))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ValueListenableBuilder(
                            valueListenable: countProduct,
                            builder: (context, value, child) {
                              return Text('$value');
                            },
                          ),
                        ),
                        // const Spacer(),
                        ValueListenableBuilder(
                          valueListenable: countProduct,
                          builder: (context, value, child) {
                            return IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed:
                                  countProduct.value > 0 ? _decrement : null,
                              color: Colors.grey[600],
                              style: const ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(Colors.white),
                                  shape: WidgetStatePropertyAll(CircleBorder(
                                      side:
                                          BorderSide(color: Colors.black12)))),
                            );
                          },
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _increment() => countProduct.value++;

  void _decrement() {
    if (countProduct.value > 0) {
      countProduct.value--;
    }
  }
}
