import 'package:flutter/material.dart';
import 'package:shop_com/screens/profile/widgets/order_item.dart';

import '../../../widgets/product_bag_item.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
                        'My Orders',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 14),
                      TabBar(
                        labelPadding: EdgeInsets.zero,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        labelStyle:
                            const TextStyle(fontWeight: FontWeight.bold),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.black,
                        ),
                        unselectedLabelStyle:
                            const TextStyle(fontWeight: FontWeight.w700),
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: const [
                          Tab(
                              child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 4),
                            child: Text('Delivered'),
                          )),
                          Tab(
                              child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 8),
                            child: Text('Processing'),
                          )),
                          Tab(
                              child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 8),
                            child: Text('Canceled'),
                          )),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                          child: TabBarView(
                        children: [
                          _buildOrderItemSection(),
                          _buildEmptyOrderItemSection(),
                          _buildEmptyOrderItemSection(),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ],
          ),
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
      itemBuilder: (context, index) => ProductBagItem(
        index: index,
        imageUrl: [
          'https://res.cloudinary.com/dcfihmhw7/image/upload/v1739206400/ssndwy0dpvuoowzchfk9.jpg',
          'https://res.cloudinary.com/dcfihmhw7/image/upload/v1739206400/ssndwy0dpvuoowzchfk9.jpg',
          'https://res.cloudinary.com/dcfihmhw7/image/upload/v1739206400/ssndwy0dpvuoowzchfk9.jpg',
          'https://res.cloudinary.com/dcfihmhw7/image/upload/v1739206400/ssndwy0dpvuoowzchfk9.jpg',
          'https://res.cloudinary.com/dcfihmhw7/image/upload/v1739206400/ssndwy0dpvuoowzchfk9.jpg'
        ][index],
        name: ['Iphone 15', 'IPhone 14', 'Samsung S23'][index],
        color: ['Black', 'Gray', 'Black'][index],
        ram: ['8', '8', '16'][index],
      ),
    );
  }
}
