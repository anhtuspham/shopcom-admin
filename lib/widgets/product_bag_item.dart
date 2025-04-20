import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductBagItem extends StatefulWidget {
  final String? imageUrl;
  final String? brand;
  final String? name;
  final String? color;
  final String? price;
  final String? ram;
  final String? rom;
  final bool? isFavorite;
  final int index;

  const ProductBagItem(
      {super.key,
      this.imageUrl,
      this.brand,
      this.name,
      this.color,
      this.ram,
      this.rom,
      this.price,
      required this.index,
      this.isFavorite = false});

  @override
  State<ProductBagItem> createState() => _ProductBagItemState();
}

class _ProductBagItemState extends State<ProductBagItem> {
  ValueNotifier<int> countProduct = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.index.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red[400],
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirm"),
              content: const Text(
                  "Are you sure you want to remove this item from cart?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("Delete"),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${widget.name} removed from cart')),
        );
      },
      child: Container(
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
            const SizedBox(width: 12),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.name ?? '',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 8),
                          IconButton(
                            onPressed: () {},
                            icon: widget.isFavorite == true
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : const Icon(Icons.favorite_border_outlined),
                            constraints: const BoxConstraints(),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Color ${widget.color}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Ram ${widget.ram}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${widget.price}\$',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                          widget.isFavorite == true
                              ? _buildAddCartButton()
                              : _buildQuantityControl()
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddCartButton() {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.add_shopping_cart_sharp,
        color: Colors.blue[600],
      ),
      style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.white),
          shape: WidgetStatePropertyAll(
              CircleBorder(side: BorderSide(color: Colors.black12)))),
    );
  }

  Widget _buildQuantityControl() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _increment,
          color: Colors.grey[600],
          style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              shape: WidgetStatePropertyAll(
                  CircleBorder(side: BorderSide(color: Colors.black12)))),
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
              onPressed: countProduct.value > 0 ? _decrement : null,
              color: Colors.grey[600],
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.white),
                  shape: WidgetStatePropertyAll(
                      CircleBorder(side: BorderSide(color: Colors.black12)))),
            );
          },
        )
      ],
    );
  }

  void _increment() => countProduct.value++;

  void _decrement() {
    if (countProduct.value > 0) {
      countProduct.value--;
    }
  }
}
