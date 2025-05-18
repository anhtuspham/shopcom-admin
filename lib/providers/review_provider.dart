import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_com_admin_web/data/config/app_config.dart';

import '../data/model/review.dart';

class ReviewNotifier extends FamilyAsyncNotifier<List<Review>, String> {
  @override
  Future<List<Review>> build(String arg) {
    return fetchProductReview(productId: arg);
  }

  Future<List<Review>> fetchProductReview({required String productId}) async {
    final result = await api.fetchProductReview(productId: productId);
    return result;
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async => await fetchProductReview(productId: arg),
    );
  }

  Future<void> addProductReview(
      {required String productId,
      required double rating,
      required String comment}) async {
    try {
      final result = await api.addProductReview(
          productId: productId, rating: rating, comment: comment);
      if (result.isValue) {
        state = const AsyncLoading();
        state = await AsyncValue.guard(
          () async => await fetchProductReview(productId: arg),
        );
      } else {
        state = AsyncError('Lỗi khi thêm đánh giá', StackTrace.current);
      }
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> deleteProductReview(
      {required String reviewId, required String productId}) async {
    try {
      final result = await api.deleteProductReview(reviewId: reviewId);
      if (result.isValue) {
        state = const AsyncLoading();
        state = await AsyncValue.guard(
            () async => await fetchProductReview(productId: arg));
      }
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}

final reviewProvider =
    AsyncNotifierProviderFamily<ReviewNotifier, List<Review>, String>(
        ReviewNotifier.new);
