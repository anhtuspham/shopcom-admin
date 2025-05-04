import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_com/providers/cart_provider.dart';
import 'package:shop_com/providers/currency_provider.dart';
import 'package:shop_com/utils/util.dart';

import '../providers/favorite_provider.dart';

class ProductBagItem extends ConsumerStatefulWidget {
  final int? quantity;
  final String productId;
  final String? imageUrl;
  final int? variantIndex;
  final String? brand;
  final String? name;
  final String? color;
  final double? price;
  final String? ram;
  final String? rom;
  final bool? isFavorite;
  final int index;

  const ProductBagItem(
      {super.key,
      this.quantity,
      required this.productId,
      this.imageUrl,
      this.variantIndex,
      this.brand,
      this.name,
      this.color,
      this.ram,
      this.rom,
      this.price,
      required this.index,
      this.isFavorite = false});

  @override
  ConsumerState<ProductBagItem> createState() => _ProductBagItemState();
}

class _ProductBagItemState extends ConsumerState<ProductBagItem> {
  late ValueNotifier<int> countProduct;

  @override
  void initState() {
    super.initState();
    countProduct = ValueNotifier(widget.quantity ?? 1);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.index.toString()),
      direction: widget.isFavorite == false
          ? DismissDirection.endToStart
          : DismissDirection.none,
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
                  onPressed: () async {
                    ref.invalidate(cartProvider);
                    await ref.read(cartProvider.notifier).removeProductFromCart(
                        productId: widget.productId,
                        variantIndex: widget.variantIndex ?? 0);
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('${widget.name} removed from cart')),
                      );
                    }
                    Navigator.of(context).pop(true);
                  },
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
                                fontSize: 16,
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
                                ? InkWell(
                                    onTap: () async {
                                      await ref
                                          .read(favoriteProvider.notifier)
                                          .removeProductFromFavorite(
                                              productId: widget.productId);
                                      if (!mounted) return;
                                      ref.invalidate(favoriteProvider);
                                    },
                                    child: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
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
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Ram ${widget.ram}',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              formatMoney(widget.price ?? 0,
                                  ref.watch(currencyProvider)),
                              style: const TextStyle(
                                fontSize: 16,
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
          padding: const EdgeInsets.all(1.0),
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
              onPressed: countProduct.value > 1 ? _decrement : null,
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

  Future<void> _increment() async {
    countProduct.value++;
    final notifier = ref.read(cartProvider.notifier);
    await notifier.addProductToCart(
        productId: widget.productId,
        variantIndex: widget.variantIndex ?? 0,
        quantity: 1);
    if (!mounted) return;
    ref.invalidate(cartProvider);
  }

  Future<void> _decrement() async {
    if (countProduct.value > 1) {
      countProduct.value--;
      final notifier = ref.read(cartProvider.notifier);
      await notifier.addProductToCart(
          productId: widget.productId,
          variantIndex: widget.variantIndex ?? 0,
          quantity: -1);
      if (!mounted) return;
      ref.invalidate(cartProvider);
    }
  }
}
