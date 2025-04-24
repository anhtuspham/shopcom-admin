import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:shop_com/providers/product_provider.dart';
import 'package:shop_com/screens/shop/widgets/search_product.dart';
import 'package:shop_com/widgets/error_widget.dart';
import 'package:shop_com/widgets/product_card.dart';

import '../../../widgets/loading_widget.dart';

class ShopScreen extends ConsumerStatefulWidget {
  const ShopScreen({super.key});

  @override
  ConsumerState<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends ConsumerState<ShopScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
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
    if (state.isLoading) return const LoadingWidget();
    if (state.isError) return const ErrorsWidget();

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
                child: _buildProductGrid(state),
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

  Widget _buildProductGrid(ProductState state) {
    return RawScrollbar(
      trackVisibility: false,
      thumbVisibility: false,
      thumbColor: Colors.grey,
      controller: _scrollController,
      padding: const EdgeInsets.only(top: 7, left: 2),
      crossAxisMargin: 0,
      radius: const Radius.circular(10),
      thickness: 3,
      child: Container(
        margin: const EdgeInsets.only(left: 4.0, right: 8, bottom: 8),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
        ),
        child: RefreshIndicator(
            onRefresh: _refresh,
            child: GridView.builder(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 6,
                ),
                itemCount: state.filtered.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                      id: state.filtered[index].id ?? '',
                      imageUrl:
                          state.filtered[index].defaultVariant?.images?[0] ??
                              '',
                      rating: state.filtered[index].ratings?.average ?? 0,
                      reviewCount: state.filtered[index].ratings?.count ?? 0,
                      brand: state.filtered[index].brand ?? '',
                      title: state.filtered[index].name,
                      originalPrice:
                          state.filtered[index].defaultVariant?.price ?? 0,
                      isNew: true);
                })),
      ),
    );
  }

  Future<void> _refresh() async {
    return ref.read(productProvider.notifier).refresh();
  }
}
