import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/config/app_config.dart';
import '../data/model/order.dart';

class OrderState {
  final List<Order> order;
  final bool isLoading;
  final bool isError;
  final String? errorMessage;

  const OrderState(
      {required this.order,
      this.isLoading = false,
      this.isError = false,
      this.errorMessage});

  factory OrderState.initial() => const OrderState(order: []);

  OrderState copyWith(
      {List<Order>? order,
      bool? isLoading,
      bool? isError,
      String? errorMessage}) {
    return OrderState(
        order: order ?? this.order,
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}

class OrderNotifier extends StateNotifier<OrderState> {
  OrderNotifier() : super(OrderState.initial());

  Future<void> fetchOrders() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, isError: false);
    try {
      final order = await api.fetchOrders();
      state = state.copyWith(order: order, isLoading: false);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, isError: false, errorMessage: null);
    await _updateOrderState();
  }

  Future<bool> updateOrderStatus({
    required String orderId,
    String? status,
  }) async {
    state = state.copyWith(isLoading: true, isError: false);
    try {
      final result =
          await api.updateOrderStatus(orderId: orderId, status: status);
      if (result.isValue) {
        await _updateOrderState();
        return true;
      } else {
        state = state.copyWith(
            isLoading: false,
            isError: true,
            errorMessage: "Failed to update info");
        return false;
      }
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
      return false;
    }
  }

  // Future<bool> deleteOrder({
  //   required String id,
  // }) async {
  //   state = state.copyWith(isLoading: true, isError: false);
  //   try{
  //     final result = await api.deleteOrder(id: id);
  //     if (result.isValue) {
  //       await _updateOrderState();
  //       return true;
  //     } else {
  //       state = state.copyWith(isLoading: false, isError: true, errorMessage: "Failed to delete order");
  //       return false;
  //     }
  //   } catch(e){
  //     state = state.copyWith(isLoading: false, isError: true, errorMessage: e.toString());
  //     return false;
  //   }
  // }

  Future<void> _updateOrderState() async {
    try {
      final order = await api.fetchOrders();
      state = state.copyWith(order: order, isLoading: false);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }
}

final orderProvider = StateNotifierProvider<OrderNotifier, OrderState>((ref) {
  final notifier = OrderNotifier();
  notifier.fetchOrders();
  return notifier;
});
