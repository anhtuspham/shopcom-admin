import 'package:flutter/material.dart';
import '../widgets/product_cart.dart';

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
              Stack(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300], // Placeholder color if image fails to load
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
                      'Hello, Apple Intelligence',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
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
              ),

              // Sale section
              Padding(
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
                      'Super summer sale',
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
                          label: const Text('-20%'),
                          backgroundColor: Colors.red[400],
                          labelStyle: const TextStyle(color: Colors.white),
                        ),
                        Chip(
                          label: const Text('-15%'),
                          backgroundColor: Colors.red[400],
                          labelStyle: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Sale products horizontal list
              SizedBox(
                height: 320,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: const [
                    ProductCard(
                      isNew: true,
                      imageUrl: 'assets/images/1.jpg',
                      discount: '-20%',
                      rating: 5.0,
                      reviewCount: 10,
                      brand: 'Apple',
                      title: 'Iphone 14',
                      originalPrice: 450,
                      discountedPrice: 440,
                    ),
                    SizedBox(width: 16),
                    ProductCard(
                      isNew: true,
                      imageUrl: 'assets/images/2.jpg',
                      discount: '-15%',
                      rating: 5.0,
                      reviewCount: 10,
                      brand: 'Apple',
                      title: 'Iphone 13',
                      originalPrice: 380,
                      discountedPrice: 350,
                    ),
                    SizedBox(width: 16,),
                    ProductCard(
                      isNew: true,
                      imageUrl: 'assets/images/1.jpg',
                      discount: '-20%',
                      rating: 5.0,
                      reviewCount: 10,
                      brand: 'Apple',
                      title: 'Iphone 14',
                      originalPrice: 450,
                      discountedPrice: 440,
                    ),
                  ],
                ),
              ),

              // New section
              Padding(
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
                          label: const Text('NEW'),
                          backgroundColor: Colors.grey[200],
                        ),
                        Chip(
                          label: const Text('NEW'),
                          backgroundColor: Colors.grey[200],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // New products grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  ProductCard(
                    imageUrl: 'assets/images/3.jpg',
                    isNew: true,
                    rating: 4.5,
                    discount: '-10%',
                    reviewCount: 8,
                    brand: 'Apple',
                    title: 'Iphone 15',
                    originalPrice: 35,
                    discountedPrice: 350,
                  ),
                  ProductCard(
                    imageUrl: 'assets/images/4.jpg',
                    isNew: true,
                    rating: 4.0,
                    reviewCount: 5,
                    discount: '-11%',
                    brand: 'Apple',
                    title: 'Iphone 15 Pro',
                    originalPrice: 28,
                    discountedPrice: 20,
                  ),
                  ProductCard(
                    imageUrl: 'assets/images/4.jpg',
                    isNew: true,
                    rating: 4.0,
                    reviewCount: 5,
                    discount: '-11%',
                    brand: 'Apple',
                    title: 'Iphone 15 Pro',
                    originalPrice: 28,
                    discountedPrice: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}