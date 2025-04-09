import 'package:flutter/material.dart';
import 'package:shop_com/widgets/button_widget.dart';
import '../../../widgets/custom_header_info.dart';
import '../../../widgets/order_product_item.dart';

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
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderInfo(),
                    const SizedBox(height: 24),
                    const Text(
                      '3 items',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 12),
                    _buildOrderItems(),
                    const SizedBox(height: 20),
                    _buildOrderInformation(),
                    const SizedBox(height: 20),
                    _buildButtonSection()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          const SizedBox(width: 4),
          const Text(
            'Order Details',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Widget _buildHeaderInfo() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 200,
              child: CustomHeaderInfo(
                title: 'Order',
                value: '19234',
                headerWidth: 70,
                headerFontWeight: FontWeight.w700,
                infoFontWeight: FontWeight.w700,
              ),
            ),
            Text('01-04-2025'),
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 250,
              child: CustomHeaderInfo(
                title: 'Tracking number',
                value: 'IW3452344',
                headerWidth: 150,
                fontSize: 16,
                infoFontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Delivered',
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.w700),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildOrderItems() {
    final items = List.generate(3, (index) {
      return OrderProductItem(
          index: index,
          imageUrl: [
            'https://res.cloudinary.com/dcfihmhw7/image/upload/v1744133884/felix-fischer-1m0BBZpeSUs-unsplash_pjtywt.jpg',
            'https://res.cloudinary.com/dcfihmhw7/image/upload/v1744133884/dimitri-karastelev-DjkYRklN0QI-unsplash_qrycsa.jpg',
            'https://res.cloudinary.com/dcfihmhw7/image/upload/v1744133883/anh-nhat-uCqMa_s-JDg-unsplash_dvy4ii.jpg',
          ][index],
          unit: ['1', '1', '1'][index],
          name: ['Iphone 15', 'IPhone 14', 'Samsung S21 Ultra'][index],
          color: ['Blue', 'Gray', 'Black'][index],
          ram: ['8', '8', '16'][index],
          price: ['755', '699', '999'][index]);
    });

    return Column(
      children: List.generate(
        items.length,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: items[index],
        ),
      ),
    );
  }

  Widget _buildOrderInformation() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Information',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 12),
        CustomHeaderInfo(
            title: 'Shipping Address',
            value: 'Ho Chi Minh city',
            infoFontWeight: FontWeight.w700),
        SizedBox(height: 8),
        CustomHeaderInfo(
            title: 'Payment Method',
            value: 'Momo',
            infoFontWeight: FontWeight.w700),
        SizedBox(height: 8),
        CustomHeaderInfo(
            title: 'Delivery Method',
            value: 'Fast Delivery',
            infoFontWeight: FontWeight.w700),
        SizedBox(height: 8),
        CustomHeaderInfo(
            title: 'Discount', value: '', infoFontWeight: FontWeight.w700),
        SizedBox(height: 8),
        CustomHeaderInfo(
            title: 'Total Amount',
            value: '\$2453',
            infoFontWeight: FontWeight.w700),
      ],
    );
  }

  Widget _buildButtonSection() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 35,
        children: [
          Expanded(
            child: CommonButtonWidget(
              callBack: () {},
              label: 'Reorder',
            ),
          ),
          Expanded(
            child: CommonButtonWidget(
                callBack: () {},
                label: 'Leave feedback',
                style: const TextStyle(color: Colors.white),
                buttonStyle: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.green))),
          )
        ]);
  }
}
