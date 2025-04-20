import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_com/providers/cart_provider.dart';
import 'package:shop_com/widgets/loading_widget.dart';

import '../../../widgets/button_widget.dart';
import '../../../widgets/product_bag_item.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      ref.read(cartProvider.notifier).fetchCart();
    },);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(cartProvider);
    print('state: ${state.cart.products}');
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Cart',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),

              Expanded(
                child: state.cart.products!.isEmpty ? _buildEmptyCart() : ListView.separated(
                  itemCount: state.cart.products?.length ?? 0,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 28),
                  itemBuilder: (context, index) => ProductBagItem(
                    index: index,
                    imageUrl: state.cart.products?[index].variantProduct?[0].images?[0],
                    name: state.cart.products?[index].productName,
                    color: state.cart.products?[index].variantProduct?[0].color,
                    ram: state.cart.products?[index].variantProduct?[0].ram,
                    rom: state.cart.products?[index].variantProduct?[0].rom,
                    price: state.cart.products?[index].variantProduct?[0].price.toString()
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              // Promo code
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your promo code',
                  border: UnderlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  suffixIcon: Icon(Icons.arrow_forward, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 12),

              // Total amount
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total amount:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    '124\$',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const SizedBox(
                  width: double.infinity,
                  child: CommonButtonWidget(
                    callBack: null,
                    label: 'CHECK OUT',
                    style: TextStyle(color: Colors.white),
                    buttonStyle: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.black)),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyCart(){
    return Center(child: Text('Giỏ hàng trống'),);
  }
}
