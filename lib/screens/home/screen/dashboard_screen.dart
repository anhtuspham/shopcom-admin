import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:shop_com_admin_web/providers/product_provider.dart';
import '../../../data/model/product.dart';
import '../../../providers/favorite_provider.dart';
import '../../../utils/widgets/error_widget.dart';
import '../../../utils/widgets/loading_widget.dart';
import '../../../utils/widgets/product_card.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        ref.read(productProvider.notifier).fetchProduct();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productProvider);
    final favoriteState = ref.watch(favoriteProvider);
    final favoriteList = favoriteState.favorite.map((e) => e.id).toList();
    if (state.isLoading) return const LoadingWidget();
    if (state.isError) return const ErrorsWidget();
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

              _productsGrid(state),
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
              isFavorite: false,
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

  Widget _productsGrid(ProductState state) {
    final newestProduct = state.products.take(4).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          mainAxisSpacing: 12,
          crossAxisSpacing: 6,
        ),
        itemCount: newestProduct.length,
        itemBuilder: (context, index) =>
            _buildProductCard(newestProduct[index]),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return ProductCard(
      id: product.id ?? '',
      imageUrl: product.defaultVariant?.images?[0] ?? '',
      rating: product.ratings?.average ?? 0,
      reviewCount: product.ratings?.count ?? 0,
      brand: product.brand ?? '',
      title: product.name,
      originalPrice: product.defaultVariant?.price ?? 0,
      isNew: true,
      isFavorite: false,
      showToggleFavorite: false,
    );
  }
}
