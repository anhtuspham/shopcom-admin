import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_com/providers/product_provider.dart';
import 'package:shop_com/screens/shop/widgets/search_product.dart';
import 'package:shop_com/widgets/error_widget.dart';
import 'package:shop_com/widgets/product_card.dart';

import '../../../widgets/loading_widget.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = ProductProvider.instance;
      if(provider.products.isEmpty){
        provider.fetchProduct();
      }
    },);
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildHeaderSection(),
              const SizedBox(height: 10),
              const SearchProduct(),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: _buildProductGrid(productProvider),
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

  Widget _buildProductGrid(ProductProvider productProvider) {
    return ListenableBuilder(
        listenable: productProvider,
        builder: (context, child) {
          if (productProvider.isError) {
            return const ErrorsWidget();
          }
          if (productProvider.isLoading) {
            return const LoadingWidget();
          }
          return Container(
            margin: const EdgeInsets.only(left: 4.0, right: 8, bottom: 8),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            child: RawScrollbar(
              trackVisibility: false,
              thumbVisibility: true,
              thumbColor: Colors.grey,
              controller: _scrollController,
              padding: const EdgeInsets.only(top: 7, right: 2),
              crossAxisMargin: 0,
              radius: const Radius.circular(10),
              thickness: 6,
              child: RefreshIndicator(
                  onRefresh: _refresh,
                  child: GridView.builder(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 6,
                      ),
                      itemCount: productProvider.filteredProducts.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                            id: productProvider.filteredProducts[index].id ??
                                '',
                            imageUrl: productProvider.filteredProducts[index]
                                    .defaultVariant?.images?[0] ??
                                '',
                            rating: productProvider
                                    .filteredProducts[index].ratings?.average ??
                                0,
                            reviewCount: productProvider
                                    .filteredProducts[index].ratings?.count ??
                                0,
                            brand:
                                productProvider.filteredProducts[index].brand ??
                                    '',
                            title: productProvider.filteredProducts[index].name,
                            originalPrice: productProvider
                                    .filteredProducts[index]
                                    .defaultVariant
                                    ?.price ??
                                0,
                            isNew: true);
                      })),
            ),
          );
        });
  }

  Future<void> _refresh() async {
    await context.read<ProductProvider>().fetchProduct();
    return Future.delayed(const Duration(seconds: 1));
  }
}
