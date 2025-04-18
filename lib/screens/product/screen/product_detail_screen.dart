import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/product_detail_provider.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/error_widget.dart';
import '../../../widgets/loading_widget.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final String id;
  const ProductDetailScreen({super.key, required this.id});

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  String? selectedRAM;
  String? selectedROM;
  String? selectedColor;

  int currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = ref.read(productDetailProvider(widget.id));
    if (state.ram.isNotEmpty) selectedRAM ??= state.ram.first;
    if (state.rom.isNotEmpty) selectedROM ??= state.rom.first;
    if (state.color.isNotEmpty) selectedColor ??= state.color.first;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productDetailProvider(widget.id));

    if (state.isLoading) return const LoadingWidget();
    if (state.isError) return const ErrorsWidget();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(state.product.name),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildImageSlider(state.images),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDynamicDropdowns(state),
                          const SizedBox(height: 16),
                          _buildTitlePriceSection(state),
                          const SizedBox(height: 8),
                          _buildDescription(state),
                          const SizedBox(height: 16),
                          _buildAddToCartButton(),
                          const SizedBox(height: 20),
                          _buildAccordion(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(String title) {
    return AppBar(
      title: Text(title),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildImageSlider(List<String> images) {
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
              errorBuilder: (context, error, stackTrace) => const ErrorsWidget(),
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

  Widget _buildDynamicDropdowns(ProductDetailState state) {
    final category = state.product.category?.toLowerCase() ?? '';
    final options = {
      'laptop': ['RAM', 'ROM'],
      'headphone': ['Color'],
      'smartphone': ['RAM', 'ROM', 'Color'],
      'tablet': ['RAM', 'ROM', 'Color'],
    }[category] ?? [];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: options.map((option) {
        final items = _getOptions(state, option);
        final selected = _getSelected(option);
        return SizedBox(
          width: 150,
          child: _buildDropdown(
            hint: option,
            items: items,
            selected: selected,
            onChanged: (value) => _setSelected(option, value),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required List<String> items,
    String? selected,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$hint:'),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: items.contains(selected) ? selected : null,
              hint: const Text('Select'),
              isExpanded: true,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              onChanged: (value) => onChanged(value!),
              items: items
                  .map((value) =>
                  DropdownMenuItem(value: value, child: Text(value)))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitlePriceSection(ProductDetailState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(state.product.name,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(state.product.brand ?? '',
                style: const TextStyle(color: Colors.grey)),
          ],
        ),
        Text('\$${state.product.defaultVariant?.price ?? ''}',
            style: const TextStyle(fontSize: 18)),
      ],
    );
  }

  Widget _buildDescription(ProductDetailState state) => Text(
    state.product.description ?? '',
    style: const TextStyle(fontSize: 14),
  );

  Widget _buildAddToCartButton() => const SizedBox(
    width: double.infinity,
    child: CommonButtonWidget(
      callBack: null,
      label: 'Add to cart',
      style: TextStyle(color: Colors.white),
      buttonStyle: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.black),
      ),
    ),
  );

  Widget _buildAccordion() {
    return Column(
      children: const [
        ListTile(
          title: Text('Shipping info'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        ListTile(
          title: Text('Support'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
      ],
    );
  }

  List<String> _getOptions(ProductDetailState state, String type) {
    switch (type) {
      case 'RAM':
        return state.ram;
      case 'ROM':
        return state.rom;
      case 'Color':
        return state.color;
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
        return selectedColor;
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
          selectedColor = value;
          break;
      }
    });
  }
}
