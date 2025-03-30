import 'package:flutter/material.dart';

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
    final products = List.generate(10, (index) => _ProductItem(
      name: 'Product ${index + 1}',
      price: '\$${(50 + index * 10)}',
      discountedPrice: index.isEven ? '\$${(40 + index * 10)}' : null,
      rating: (index % 5) + 1,
      reviews: (index + 1) * 10,
    ));

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) => _buildProductCard(products[index]),
    );
  }

  Widget _buildProductCard(_ProductItem product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Container(
              height: 150,
              color: Colors.grey[200],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ...List.generate(
                      product.rating,
                          (index) => const Icon(Icons.star,
                          color: Colors.amber, size: 16),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '(${product.reviews})',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                // Giá
                Row(
                  children: [
                    if(product.discountedPrice != null)
                      Text(
                        product.discountedPrice!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    const SizedBox(width: 8),
                    Text(
                      product.price,
                      style: TextStyle(
                        decoration: product.discountedPrice != null
                            ? TextDecoration.lineThrough
                            : null,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: Colors.grey[300]!),
                    ),
                    onPressed: () {},
                    child: const Text('Add to Bag'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductItem {
  final String name;
  final String price;
  final String? discountedPrice;
  final int rating;
  final int reviews;

  _ProductItem({
    required this.name,
    required this.price,
    this.discountedPrice,
    required this.rating,
    required this.reviews,
  });
}