import 'package:flutter/material.dart';
import 'package:shop_com/widgets/product_bag_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: _buildFavoriteList(context),
    );
  }

  Widget _buildFavoriteList(BuildContext context) {
    final favoriteProducts = [
      _FavoriteProduct(
        name: 'Evening Dress',
        brand: 'Dorothy Perkins',
        price: '\$15',
        discountedPrice: '\$12',
        imageUrl: '',
        size: 'L',
        color: 'Black',
      ),
      _FavoriteProduct(
        name: 'Sport Dress',
        brand: 'Sitily',
        price: '\$22',
        discountedPrice: '\$19',
        imageUrl: '',
        size: 'M',
        color: 'Red',
      ),
      _FavoriteProduct(
        name: 'Summer T-Shirt',
        brand: 'Zara',
        price: '\$25',
        imageUrl: '',
        size: 'S',
        color: 'White',
      ),
    ];

    if (favoriteProducts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.favorite_border, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'No favorites yet',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tap the heart icon to save items',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: favoriteProducts.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      // itemBuilder: (context, index) => _buildFavoriteItem(context, favoriteProducts[index]),
      itemBuilder: (context, index) => ProductBagItem(
          productId: '1',
          index: index,
          isFavorite: true,
          imageUrl: [
            'https://res.cloudinary.com/dcfihmhw7/image/upload/v1744134810/igor-omilaev-lDWTfYhZ85w-unsplash_yjswfd.jpg',
            'https://res.cloudinary.com/dcfihmhw7/image/upload/v1744134811/amanz-FkEfFVrbM3o-unsplash_xe2nwr.jpg',
            'https://res.cloudinary.com/dcfihmhw7/image/upload/v1744133883/anh-nhat-PdALQmfEqvE-unsplash_qfvuhv.jpg',
          ][index],
          name: ['Iphone 15', 'IPhone 16', 'Samsung S23'][index],
          color: ['Black', 'Blue', 'Grey'][index],
          ram: ['8', '8', '16'][index],
          price: ['899', '1099', '999'][index]),
    );
  }

  Widget _buildFavoriteItem(BuildContext context, _FavoriteProduct product) {
    return Dismissible(
      key: Key(product.name),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirm"),
              content: const Text(
                  "Are you sure you want to remove this item from favorites?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("Delete"),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${product.name} removed')),
        );
      },
      child: Container(
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(12),
              ),
              child: Container(
                width: 100,
                height: 120,
                color: Colors.grey[200],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.favorite, color: Colors.red),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Text(
                      product.brand,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Color: ${product.color}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    Text(
                      'Size: ${product.size}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (product.discountedPrice != null)
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
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Add to Bag',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoriteProduct {
  final String name;
  final String brand;
  final String price;
  final String? discountedPrice;
  final String imageUrl;
  final String size;
  final String color;

  _FavoriteProduct({
    required this.name,
    required this.brand,
    required this.price,
    this.discountedPrice,
    required this.imageUrl,
    required this.size,
    required this.color,
  });
}
