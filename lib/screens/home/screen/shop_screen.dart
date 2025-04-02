import 'package:flutter/material.dart';
import 'package:shop_com/screens/home/widgets/product_card.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildHeaderSection(),
              const SizedBox(height: 20),
              Expanded(
                child: _buildProductGrid(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Shop',
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildFilterButton(Icons.tune, 'Filters'),
            const SizedBox(width: 16),
            _buildFilterButton(Icons.sort, 'Sort by'),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.grid_view),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterButton(IconData icon, String text) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        side: BorderSide(color: Colors.grey[300]!),
      ),
      onPressed: () {},
      icon: Icon(icon, size: 20),
      label: Text(text),
    );
  }

  Widget _buildProductGrid() {
    final products = List.generate(
        10,
        (index) => _ProductItem(
            name: 'Product ${index + 1}',
            price: '\$${(50 + index * 10)}',
            discountedPrice: index.isEven ? '\$${(40 + index * 10)}' : null,
            rating: (index % 5) + 1,
            reviews: (index + 1) * 10,
            brand: 'Samsung'));

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        mainAxisSpacing: 16,
        crossAxisSpacing: 6,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) => _buildProductCard(products[index]),
    );
  }

  Widget _buildProductCard(_ProductItem product) {
    return ProductCard(
        imageUrl:
            'https://res.cloudinary.com/dcfihmhw7/image/upload/v1739206400/ssndwy0dpvuoowzchfk9.jpg',
        rating: product.rating,
        reviewCount: product.reviews,
        brand: product.brand,
        title: 'shop',
        originalPrice: 234,
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
