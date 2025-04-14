import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_com/providers/product_detail_provider.dart';
import 'package:shop_com/widgets/error_widget.dart';
import 'package:shop_com/widgets/loading_widget.dart';

import '../../../widgets/button_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String selectedSize = 'Size';
  String selectedColor = 'Black';

  final List<String> sizes = ['8', '16', '32'];
  final List<String> colors = ['Black', 'White', 'Grey'];
  final List<String> productImages = [
    'https://res.cloudinary.com/dcfihmhw7/image/upload/v1744135352/samuel-angor-HoThEebqSdY-unsplash_omuea5.jpg',
    'https://res.cloudinary.com/dcfihmhw7/image/upload/v1744132448/thai-nguyen-fw_KhcwHmlY-unsplash_frhp4g.jpg',
    'https://res.cloudinary.com/dcfihmhw7/image/upload/v1744132489/thai-nguyen-7uEVvoPzwG4-unsplash_m6l6r0.jpg',
  ];

  int currentPage = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final productDetailProvider = context.watch<ProductDetailProvider>();

    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: productDetailProvider,
          builder: (context, child) {
            if (productDetailProvider.isLoading) {
              return const LoadingWidget();
            }
            if (productDetailProvider.isError) {
              return const ErrorsWidget();
            }
            return Column(
              children: [
                _buildAppBar(productDetailProvider),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildImageSlider(productDetailProvider),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              _buildDropdowns(),
                              const SizedBox(height: 16),
                              _buildTitlePriceSection(),
                              const SizedBox(height: 8),
                              _buildDescription(),
                              const SizedBox(height: 20),
                              _buildAddToCartButton(),
                              const SizedBox(height: 20),
                              _buildAccordion(),
                              const SizedBox(height: 20),
                              // _buildSuggestions(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAppBar(ProductDetailProvider productDetailProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios)),
          Expanded(
            child: Text(
              productDetailProvider.product.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          const Icon(Icons.share),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return AspectRatio(
      aspectRatio: 1,
      child: Image.network(
        'https://res.cloudinary.com/dcfihmhw7/image/upload/v1739206400/ssndwy0dpvuoowzchfk9.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildImageSlider(ProductDetailProvider productDetailProvider) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: PageView.builder(
            controller: _pageController,
            itemCount: productImages.length,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.network(
                productImages[index],
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            productImages.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: currentPage == index ? 12 : 8,
              height: currentPage == index ? 12 : 8,
              decoration: BoxDecoration(
                color:
                    currentPage == index ? Colors.black : Colors.grey.shade400,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdowns() {
    return Row(
      children: [
        Expanded(
            child: _buildDropdown('Size', sizes, selectedSize,
                (value) => setState(() => selectedSize = value))),
        const SizedBox(width: 16),
        Expanded(
            child: _buildDropdown('Color', colors, selectedColor,
                (value) => setState(() => selectedColor = value))),
        const SizedBox(width: 16),
        const Icon(Icons.favorite_border),
      ],
    );
  }

  Widget _buildDropdown(String hint, List<String> items, String selected,
      ValueChanged<String> onChanged) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selected,
          isExpanded: true,
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
          items: [hint, ...items].map((value) {
            return DropdownMenuItem<String>(
              value: value,
              enabled: value != hint,
              child: Text(
                value,
                style: TextStyle(
                    color: value == hint ? Colors.grey : Colors.black),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTitlePriceSection() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Apple',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('Iphone 15 Pro',
                style: TextStyle(color: Colors.grey, fontSize: 14)),
          ],
        ),
        Text('\$380',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ],
    );
  }

  Widget _buildDescription() {
    return const Text(
      '48MP Main: 26 mm, ƒ/1.6 aperture, sensor‑shift optical image stabilization, 100% Focus Pixels, support for super-high-resolution photos (24MP and 48MP)',
      style: TextStyle(fontSize: 14),
    );
  }

  Widget _buildAddToCartButton() {
    return const SizedBox(
        width: double.infinity,
        child: CommonButtonWidget(
          callBack: null,
          label: 'CHECK OUT',
          style: TextStyle(color: Colors.white),
          buttonStyle: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.black)),
        ));
  }

  Widget _buildAccordion() {
    return Column(
      children: [
        ListTile(
          title: const Text('Shipping info'),
          trailing: const Icon(Icons.keyboard_arrow_right),
          onTap: () {},
        ),
        ListTile(
          title: const Text('Support'),
          trailing: const Icon(Icons.keyboard_arrow_right),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildSuggestions() {
    final suggestions = [
      {
        'image':
            'https://res.cloudinary.com/dcfihmhw7/image/upload/v1744132489/thai-nguyen-7uEVvoPzwG4-unsplash_m6l6r0.jpg',
        'title': 'Evening Dress',
        'brand': 'Dorothy Perkins',
        'price': '\$12',
        'oldPrice': '\$15',
        'discount': '-20%',
      },
      {
        'image':
            'https://res.cloudinary.com/dcfihmhw7/image/upload/v1744132489/thai-nguyen-7uEVvoPzwG4-unsplash_m6l6r0.jpg',
        'title': 'T-Shirt Sailing',
        'brand': 'Mango Boy',
        'price': '\$10',
        'discount': 'NEW',
      },
      {
        'image':
            'https://res.cloudinary.com/dcfihmhw7/image/upload/v1744132489/thai-nguyen-7uEVvoPzwG4-unsplash_m6l6r0.jpg',
        'title': 'T-Shirt Sailing',
        'brand': 'Mango Boy',
        'price': '\$10',
        'discount': 'NEW',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'You can also like this',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 230,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: suggestions.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final item = suggestions[index];
              return Container(
                width: 140,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            item['image']!,
                            width: 130,
                            height: 130,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 6,
                          left: 6,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: item['discount'] == 'NEW'
                                  ? Colors.black
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              item['discount']!,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                        const Positioned(
                          top: 6,
                          right: 6,
                          child: Icon(Icons.favorite_border,
                              size: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(item['brand']!,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey)),
                    Text(item['title']!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                    Row(
                      children: [
                        Text(item['price']!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14)),
                        if (item['oldPrice'] != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(item['oldPrice']!,
                                style: const TextStyle(
                                    fontSize: 12,
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey)),
                          )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
