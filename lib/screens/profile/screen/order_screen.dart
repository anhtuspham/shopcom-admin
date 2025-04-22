import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_com/providers/order_provider.dart';
import 'package:shop_com/screens/profile/widgets/order_item.dart';
import 'package:shop_com/utils/util.dart';
import 'package:shop_com/widgets/loading_widget.dart';

class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen({super.key});

  @override
  ConsumerState<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        ref.read(orderProvider.notifier).fetchOrder();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderProvider);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(context),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabBar(
                        labelPadding: EdgeInsets.zero,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        labelStyle:
                            const TextStyle(fontWeight: FontWeight.bold),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.black,
                        ),
                        unselectedLabelStyle:
                            const TextStyle(fontWeight: FontWeight.w700),
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: const [
                          Tab(
                              child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            child: Text('Pending'),
                          )),
                          Tab(
                              child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            child: Text('Processing'),
                          )),
                          Tab(
                              child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            child: Text('Delivered'),
                          )),
                          Tab(
                              child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            child: Text('Canceled'),
                          )),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                          child: TabBarView(
                        children: [
                          _buildOrderItemSection(state, 'pending'),
                          _buildOrderItemSection(state, 'processing'),
                          _buildOrderItemSection(state, 'delivered'),
                          _buildOrderItemSection(state, 'cancelled')
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refresh() {
    return ref.read(orderProvider.notifier).refresh();
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
            'My Orders',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Widget _buildOrderItemSection(OrderState state, String status) {
    if (state.isLoading) return const LoadingWidget();
    final filtered =
        state.orders?.where((element) => element.status == status).toList();
    if (filtered!.isEmpty) return _buildEmptyOrderItemSection();

    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.separated(
        itemBuilder: (context, index) {
          final order = filtered[index];
          return OrderItem(
            orderId: order.id,
            numberProducts: order.products?.length,
            orderStatus: order.status,
            orderTime: getStringFromDateTime(
                order.createdAt ?? DateTime.now(), 'HH:mm - dd/MM/yyyy'),
            totalAmount: order.totalAmount,
          );
        },
        itemCount: filtered.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
      ),
    );
  }

  Widget _buildEmptyOrderItemSection() {
    return ListView.separated(
      itemBuilder: (context, index) => const Offstage(),
      itemCount: 0,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
    );
  }
}
