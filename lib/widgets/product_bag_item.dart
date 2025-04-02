import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductBagItem extends StatefulWidget{
  final String? imageUrl;
  final String? brand;
  final String? name;
  final String? color;
  final String? size;
  const ProductBagItem({super.key, this.imageUrl, this.brand, this.name, this.color, this.size});

  @override
  State<ProductBagItem> createState() => _ProductBagItemState();
}

class _ProductBagItemState extends State<ProductBagItem> {
  @override
  Widget build(BuildContext context) {
    print('url ${widget.imageUrl}');
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
          height: 120,
          // decoration: BoxDecoration(
          //   color: Colors.grey[200],
          //   borderRadius: BorderRadius.circular(12),
          // ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              widget.imageUrl ?? '',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error);
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name ?? '',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Color ${widget.color}',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 4),
              Text(
                'Size ${widget.size}',
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