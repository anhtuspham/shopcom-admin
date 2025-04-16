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
  String? selectedRAM;
  String? selectedROM;
  String? selectedColors;
  List<String> ramOptions = [];
  List<String> romOptions = [];
  List<String> colorOptions = [];
  List<String> images = [];

  final Map<String, List<String>> categoryOptions = {
    'laptop': ['RAM', 'ROM'],
    'headphone': ['Color'],
    'smartphone': ['RAM', 'ROM', 'Color'],
    'tablet': ['RAM', 'ROM', 'Color']
  };

  int currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ProductDetailProvider>();
      if (provider.ram.isNotEmpty) selectedRAM = provider.ram.first;
      if (provider.rom.isNotEmpty) selectedROM = provider.rom.first;
      if (provider.color.isNotEmpty) selectedColors = provider.color.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    final productDetailProvider = context.watch<ProductDetailProvider>();
    images = productDetailProvider.images;
    ramOptions = productDetailProvider.ram;
    romOptions = productDetailProvider.rom;
    colorOptions = productDetailProvider.color;

    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: productDetailProvider,
          builder: (context, child) {
            if (productDetailProvider.isLoading ||
                productDetailProvider.product.variants == null) {
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
                        _buildImageSlider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              _buildDropdowns(productDetailProvider),
                              const SizedBox(height: 16),
                              _buildTitlePriceSection(productDetailProvider),
                              const SizedBox(height: 8),
                              _buildDescription(productDetailProvider),
                              const SizedBox(height: 20),
                              _buildAddToCartButton(),
                              const SizedBox(height: 20),
                              _buildAccordion(),
                              const SizedBox(height: 20),
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

  Widget _buildAppBar(ProductDetailProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios)),
          Expanded(
            child: Text(
              provider.product.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          const Icon(Icons.share),
        ],
      ),
    );
  }

  Widget _buildImageSlider() {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            onPageChanged: (index) => setState(() => currentPage = index),
            itemBuilder: (context, index) => Image.network(
              images[index],
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) =>
                  loadingProgress == null ? child : const LoadingWidget(),
              errorBuilder: (context, error, stackTrace) =>
                  const ErrorsWidget(),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            images.length,
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

  Widget _buildDropdowns(ProductDetailProvider provider) {
    final category = provider.product.category?.toLowerCase() ?? '';
    return _buildDynamicDropdowns(category);
  }

  Widget _buildDynamicDropdowns(String category) {
    final options = categoryOptions[category] ?? [];
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: options.map((option) {
        final list = _getOptions(option);
        final selected = _getSelected(option);
        return SizedBox(
          width: 150,
          child: _buildDropdown(
            hint: option,
            items: list,
            selected: selected,
            onChanged: (value) => _setSelected(option, value),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDropdown(
      {required String hint,
      required List<String> items,
      String? selected,
      required ValueChanged<String> onChanged}) {
    return Row(
      spacing: 4,
      children: [
        Text('$hint: '),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selected != '' ? selected : null,
                hint: const Text('Select'),
                isExpanded: true,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                onChanged: (value) {
                  if (value != null) onChanged(value);
                },
                items: items.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<String> _getOptions(String type) {
    switch (type) {
      case 'RAM':
        return ramOptions;
      case 'ROM':
        return romOptions;
      case 'Color':
        return colorOptions;
      default:
        return [];
    }
  }

  String? _getSelected(String type) {
    switch (type) {
      case 'RAM':
        return selectedRAM;
      case 'ROM':
        return selectedROM;
      case 'Color':
        return selectedColors;
      default:
        return null;
    }
  }

  void _setSelected(String type, String value) {
    setState(() {
      switch (type) {
        case 'RAM':
          selectedRAM = value;
          break;
        case 'ROM':
          selectedROM = value;
          break;
        case 'Color':
          selectedColors = value;
          break;
      }
    });
  }

  Widget _buildTitlePriceSection(ProductDetailProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(provider.product.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(provider.product.brand ?? '',
                style: TextStyle(color: Colors.grey, fontSize: 14)),
          ],
        ),
        Text('\$${provider.product.defaultVariant?.price}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ],
    );
  }

  Widget _buildDescription(ProductDetailProvider productDetailProvider) {
    return Text(
      productDetailProvider.product.description ?? '',
      style: const TextStyle(fontSize: 14),
    );
  }

  Widget _buildAddToCartButton() {
    return const SizedBox(
      width: double.infinity,
      child: CommonButtonWidget(
        callBack: null,
        label: 'Add to cart',
        style: TextStyle(color: Colors.white),
        buttonStyle: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.black),
        ),
        isUppercase: true,
      ),
    );
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
}
