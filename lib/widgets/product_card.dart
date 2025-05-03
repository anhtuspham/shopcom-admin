import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductCard extends StatefulWidget {
  final String id;
  final String imageUrl;
  final String? discount;
  final double rating;
  final int reviewCount;
  final String brand;
  final String title;
  final double originalPrice;
  final double? discountedPrice;
  final bool isNew;

  const ProductCard({
    super.key,
    required this.id,
    required this.imageUrl,
    this.discount,
    required this.rating,
    required this.reviewCount,
    required this.brand,
    required this.title,
    required this.originalPrice,
    this.discountedPrice,
    required this.isNew,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return InkWell(
      onTap: () => context.push('/productDetail', extra: widget.id),
      child: Container(
        width: width * 0.45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image and discount badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: SizedBox(
                    height: height * 0.2,
                    child: Image.network(
                      widget.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(Icons.image_not_supported, size: 40),
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ),
                if (widget.discount != null)
                  Positioned(
                    left: 10,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        widget.discount ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.favorite_outline,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),

            // Product rating
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 8),
              child: Row(
                children: [
                  for (int i = 0; i < 5; i++)
                    Icon(
                      i < widget.rating ? Icons.star : Icons.star_border,
                      size: 14,
                      color: Colors.amber,
                    ),
                  const SizedBox(width: 4),
                  Text(
                    '(${widget.reviewCount})',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            // Brand name
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 4),
              child: Text(
                widget.brand,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Product title
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 2),
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Price information
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 2, bottom: 8),
              child: Row(
                children: [
                  Text(
                    '${widget.originalPrice}\$',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      decoration: widget.discountedPrice != null
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  if (widget.discountedPrice != null) ...[
                    const SizedBox(width: 4),
                    Text(
                      '${widget.discountedPrice}\$',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
