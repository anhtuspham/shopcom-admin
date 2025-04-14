import 'package:flutter/material.dart';
import '../../../widgets/product_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner image with "Street clothes" text
              _bannerSection(),

              // Sale section
              _salesSection(),

              // Sale products horizontal list
              _productSlideSection(),

              // New section
              _newSection(),

              _buildProductGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bannerSection() {
    return Stack(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            // Placeholder color if image fails to load
            image: const DecorationImage(
              image: AssetImage('assets/images/banner.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Positioned(
          bottom: 20,
          left: 20,
          child: Text(
            'Welcome to SHOPCOM',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 10,
                  color: Colors.black,
                  offset: Offset(2, 2),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _salesSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sale',
            style: TextStyle(
              fontSize: 24, // Reduced from 34 for better hierarchy
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tech day',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              Chip(
                label: const Text('-5%'),
                backgroundColor: Colors.red[400],
                labelStyle: const TextStyle(color: Colors.white),
              ),
              Chip(
                label: const Text('-10%'),
                backgroundColor: Colors.red[400],
                labelStyle: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _productSlideSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 280,
        child: ListView.separated(
          itemCount: 3,
          itemBuilder: (context, index) {
            return ProductCard(
              id: '123',
              imageUrl: [
                'https://res.cloudinary.com/dcfihmhw7/image/upload/v1744135352/samuel-angor-HoThEebqSdY-unsplash_omuea5.jpg',
                'https://res.cloudinary.com/dcfihmhw7/image/upload/v1744135352/amanz-VP_FOpy5G68-unsplash_d4chmi.jpg',
                'https://res.cloudinary.com/dcfihmhw7/image/upload/v1744135352/samuel-angor-RPiEdud0dcw-unsplash_mpsvmd.jpg',
              ][index],
              isNew: true,
              rating: 4.0,
              reviewCount: 5,
              discount: ['-5%', '-5%', '-10%'][index],
              brand: 'Apple',
              title: [
                'Iphone 15 Pro',
                'Iphone 14 Pro',
                'Iphone 15 Pro Max'
              ][index],
              originalPrice: [400, 500, 600][index].toDouble(),
              discountedPrice: [380, 450, 540][index].toDouble(),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(width: 8);
          },
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
        ),
      ),
    );
  }

  Widget _newSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'New',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'You\'ve never seen it before!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              Chip(
                label: const Text('Apple'),
                backgroundColor: Colors.grey[200],
              ),
              Chip(
                label: const Text('Samsung'),
                backgroundColor: Colors.grey[200],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    final products = List.generate(
        6,
        (index) => _ProductItem(
            name: [
              'Samsung S23',
              'Samsung S22',
              'Samsung S21',
              'Iphone 14',
              'Iphone 13',
              'Iphone 15'
            ][index],
            price: ['450', '440', '430', '430', '550', '510'][index],
            discountedPrice: null,
            rating: (index % 5) + 1,
            reviews: (index + 1) * 10,
            brand: [
              'Samsung',
              'Samsung',
              'Samsung',
              'Apple',
              'Apple',
              'Apple'
            ][index]));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          mainAxisSpacing: 12,
          crossAxisSpacing: 6,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) => _buildProductCard(products[index]),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }

  Widget _buildProductCard(_ProductItem product) {
    return ProductCard(
        id: '123',
        imageUrl:
            'https://res.cloudinary.com/dcfihmhw7/image/upload/v1744135352/samuel-angor-HoThEebqSdY-unsplash_omuea5.jpg',
        rating: product.rating,
        reviewCount: product.reviews,
        brand: product.brand,
        title: 'Iphone 15 Pro',
        originalPrice: 400,
        isNew: true);
  }
}

class _ProductItem {
  final String name;
  final String price;
  final String? discountedPrice;
  final double rating;
  final int reviews;
  final String brand;

  _ProductItem({
    required this.name,
    required this.price,
    this.discountedPrice,
    required this.rating,
    required this.reviews,
    required this.brand,
  });
}
