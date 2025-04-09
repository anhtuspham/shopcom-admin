import 'package:flutter/material.dart';

import '../../../widgets/button_widget.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Bag',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),

              Expanded(
                child: ListView.separated(
                  itemCount: 3,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 28),
                  itemBuilder: (context, index) => ProductBagItem(
                    index: index,
                    imageUrl: [
                      'https://res.cloudinary.com/dcfihmhw7/image/upload/v1744133884/felix-fischer-1m0BBZpeSUs-unsplash_pjtywt.jpg',
                      'https://res.cloudinary.com/dcfihmhw7/image/upload/v1744133884/dimitri-karastelev-DjkYRklN0QI-unsplash_qrycsa.jpg',
                      'https://res.cloudinary.com/dcfihmhw7/image/upload/v1744133883/anh-nhat-uCqMa_s-JDg-unsplash_dvy4ii.jpg',
                    ][index],
                    name: ['Iphone 15', 'IPhone 14', 'Samsung S21 Ultra'][index],
                    color: ['Blue', 'Gray', 'Black'][index],
                    ram: ['8', '8', '16'][index],
                    price: ['755', '699', '999'][index]
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
}
