import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_com/providers/order_detail_provider.dart';
import 'package:shop_com/providers/order_provider.dart';
import 'package:shop_com/utils/util.dart';
import 'package:shop_com/widgets/button_widget.dart';
import 'package:shop_com/widgets/error_widget.dart';
import 'package:shop_com/widgets/loading_widget.dart';
import '../../../widgets/custom_header_info.dart';
import '../widgets/order_product_item.dart';

class OrderDetailScreen extends ConsumerStatefulWidget {
  final String id;

  const OrderDetailScreen({super.key, required this.id});

  @override
  ConsumerState<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends ConsumerState<OrderDetailScreen> {
  final List statusOrder = ["pending", "processing", "delivered", "cancelled"];
  final List statusColor = [
    Colors.orange[600],
    Colors.blue[400],
    Colors.green[600],
    Colors.red[600]
  ];

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderDetailProvider(widget.id));
    if (state.isLoading) return const LoadingWidget();
    if (state.isError) return const ErrorsWidget();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderInfo(state),
                    const SizedBox(height: 24),
                    _buildOrderItems(state),
                    const SizedBox(height: 20),
                    _buildOrderInformation(),
                    const SizedBox(height: 20),
                    _buildButtonSection()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          const SizedBox(width: 4),
          const Text(
            'Order Details',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Widget _buildHeaderInfo(OrderDetailState state) {
    return Column(
      children: [
        CustomHeaderInfo(title: 'OrderID', value: state.order.id ?? ''),
        CustomHeaderInfo(
            title: 'Order time',
            value: getStringFromDateTime(
                state.order.createdAt ?? DateTime.now(), 'HH:mm - dd/MM/yyyy')),
        CustomHeaderInfo(
          title: 'Status',
          value: upperCaseFirstLetter(state.order.status ?? ''),
          valueFontWeight: FontWeight.w700,
          valueColor: statusColor[statusOrder.indexOf(state.order.status)],
        )
      ],
    );
  }

  Widget _buildOrderItems(OrderDetailState state) {
    final items = List.generate(state.order.products?.length ?? 0, (index) {
      return OrderProductItem(
          index: index,
          imageUrl: state.order.products?[index].variantProduct?[0].images?[0],
          unit: state.order.products?[index].quantity.toString(),
          name: state.order.products?[index].productName,
          color: state.order.products?[index].variantProduct?[0].color,
          ram: state.order.products?[index].variantProduct?[0].ram,
          price: state.order.products?[index].price.toString());
    });

    return Column(
      children: List.generate(
        items.length,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: items[index],
        ),
      ),
    );
  }

  Widget _buildOrderInformation() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Information',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 12),
        CustomHeaderInfo(
            title: 'Shipping Address',
            value: 'Ho Chi Minh city',
            valueFontWeight: FontWeight.w700),
        SizedBox(height: 8),
        CustomHeaderInfo(
            title: 'Payment Method',
            value: 'Momo',
            valueFontWeight: FontWeight.w700),
        SizedBox(height: 8),
        CustomHeaderInfo(
            title: 'Delivery Method',
            value: 'Fast Delivery',
            valueFontWeight: FontWeight.w700),
        SizedBox(height: 8),
        CustomHeaderInfo(
            title: 'Discount', value: '', valueFontWeight: FontWeight.w700),
        SizedBox(height: 8),
        CustomHeaderInfo(
            title: 'Total Amount',
            value: '\$2453',
            valueFontWeight: FontWeight.w700),
      ],
    );
  }

  Widget _buildButtonSection() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 35,
        children: [
          Expanded(
            child: CommonButtonWidget(
              callBack: () {},
              label: 'Reorder',
            ),
          ),
          Expanded(
            child: CommonButtonWidget(
                callBack: () {},
                label: 'Leave feedback',
                style: const TextStyle(color: Colors.white),
                buttonStyle: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.green))),
          )
        ]);
  }
}
