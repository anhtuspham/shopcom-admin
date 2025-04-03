import 'package:flutter/material.dart';

import '../../../widgets/product_bag_item.dart';

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

              Expanded(
                child: ListView.separated(
                  itemCount: 3,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 32),
                  itemBuilder: (context, index) => ProductBagItem(
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
                ),
              ),

              const SizedBox(height: 10,),


              // Promo code
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your promo code',
                  border: UnderlineInputBorder(),
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
              const SizedBox(height: 12),

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
}
