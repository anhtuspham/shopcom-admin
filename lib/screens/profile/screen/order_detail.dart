import 'package:flutter/material.dart';
import 'package:shop_com/screens/profile/widgets/order_item.dart';
import 'package:shop_com/widgets/order_product_item.dart';

import '../../../widgets/product_bag_item.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Order Details',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(child: _buildOrderSection())
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItemSection() {
    return ListView.separated(
      itemBuilder: (context, index) => OrderItem(),
      itemCount: 3,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
    );
  }

  Widget _buildEmptyOrderItemSection() {
    return ListView.separated(
      itemBuilder: (context, index) => const Offstage(),
      itemCount: 0,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
    );
  }

  Widget _buildOrderSection() {
    return ListView.separated(
      itemCount: 3,
      separatorBuilder: (context, index) => const Divider(height: 28),
      itemBuilder: (context, index) => OrderProductItem(
        index: index,
        imageUrl: [
          'https://res.cloudinary.com/dcfihmhw7/image/upload/v1739206400/ssndwy0dpvuoowzchfk9.jpg',
          'https://res.cloudinary.com/dcfihmhw7/image/upload/v1739206400/ssndwy0dpvuoowzchfk9.jpg',
          'https://res.cloudinary.com/dcfihmhw7/image/upload/v1739206400/ssndwy0dpvuoowzchfk9.jpg',
          'https://res.cloudinary.com/dcfihmhw7/image/upload/v1739206400/ssndwy0dpvuoowzchfk9.jpg',
          'https://res.cloudinary.com/dcfihmhw7/image/upload/v1739206400/ssndwy0dpvuoowzchfk9.jpg'
        ][index],
        unit: ['1', '2', '2'][index],
        name: ['Iphone 15', 'IPhone 14', 'Samsung S23'][index],
        color: ['Black', 'Gray', 'Black'][index],
        ram: ['8', '8', '16'][index],
      ),
    );
  }
}
