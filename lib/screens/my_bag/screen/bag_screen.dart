import 'package:flutter/material.dart';

class MyBagScreen extends StatefulWidget {
  const MyBagScreen({super.key});

  @override
  State<MyBagScreen> createState() => _MyBagScreenState();
}

class _MyBagScreenState extends State<MyBagScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tiêu đề
              const Text(
                'My Bag',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // Danh sách sản phẩm
              Expanded(
                child: ListView.separated(
                  itemCount: 3,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 32),
                  itemBuilder: (context, index) => _buildProductItem(
                    productName: ['Pullover', 'T-Shirt', 'Sport Dress'][index],
                    color: ['Black', 'Gray', 'Black'][index],
                    size: ['L', 'L', 'M'][index],
                  ),
                ),
              ),

              // Promo code
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your promo code',
                  border: UnderlineInputBorder(),
                  suffixIcon: Icon(Icons.arrow_forward, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 24),

              // Total amount
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Total amount:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    '124\$',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Checkout button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'CHECK OUT',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductItem({
    required String productName,
    required String color,
    required String size,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hình ảnh sản phẩm
        Container(
          width: 100,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(width: 16),

        // Thông tin sản phẩm
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Color $color',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 4),
              Text(
                'Size $size',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {},
                    color: Colors.grey[600],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {},
                    color: Colors.grey[600],
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
