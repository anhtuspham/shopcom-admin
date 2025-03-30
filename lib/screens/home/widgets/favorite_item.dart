import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteItem extends StatelessWidget {
  final String imageUrl;
  final String brand;
  final String name;
  final String color;
  final String size;
  final int price;
  final double rating;
  final int ratingCount;
  final bool isNew;
  final bool isSoldOut;
  final String? discount;

  const FavoriteItem({
    super.key,
    required this.imageUrl,
    required this.brand,
    required this.name,
    required this.color,
    required this.size,
    required this.price,
    required this.rating,
    required this.ratingCount,
    this.isNew = false,
    this.isSoldOut = false,
    this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image with optional badges
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imageUrl,
                  width: 100,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              if (isNew)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'NEW',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              if (discount != null)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      discount!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(width: 16),

          // Product details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  brand,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      'Color: ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      color,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Size: ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      size,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    for (int i = 0; i < 5; i++)
                      Icon(
                        i < rating ? Icons.star : Icons.star_border,
                        size: 16,
                        color: Colors.amber,
                      ),
                    const SizedBox(width: 4),
                    if (ratingCount > 0)
                      Text(
                        '($ratingCount)',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                if (isSoldOut)
                  const Text(
                    'Sorry, this item is currently sold out',
                    style: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                    ),
                  )
                else
                  Text(
                    '${price}\$',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),

          // Action buttons
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {},
                color: Colors.grey,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
