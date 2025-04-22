import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/config/app_config.dart';
import '../data/model/order.dart';

class OrderDetailState {
  final Order order;
  final bool isLoading;
  final bool isError;

  OrderDetailState({
    required this.order,
    this.isLoading = false,
    this.isError = false,
  });
}

class OrderDetailNotifier extends StateNotifier<OrderDetailState> {
  OrderDetailNotifier() : super(OrderDetailState(order: Order.empty()));

  Future<void> fetchOrder(String id) async {
    state = OrderDetailState(order: Order.empty(), isLoading: true);
    try {
      final result = await api.fetchOrderDetail(orderId: id);
      state = OrderDetailState(order: result);
    } catch (_) {
      state = OrderDetailState(order: Order.empty(), isError: true);
    }
  }
}

final orderDetailProvider = StateNotifierProvider.autoDispose
    .family<OrderDetailNotifier, OrderDetailState, String>((ref, id) {
  final notifier = OrderDetailNotifier();
  notifier.fetchOrder(id);
  return notifier;
});
