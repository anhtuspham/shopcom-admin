import 'package:async/async.dart';
import 'package:shop_com_admin_web/apis/base_api.dart';
import 'package:shop_com_admin_web/data/config/app_config.dart';
import 'package:shop_com_admin_web/data/model/product.dart';

import '../data/model/review.dart';

mixin ReviewApi on BaseApi {
  Future<List<Review>> fetchProductReview({required String productId}) async {
    Result result = await handleRequest(
        request: () =>
            get('/api/product/get-review', data: {"productId": productId}));

    try {
      final List rawList = result.asValue!.value;
      return safeParseReviews(rawList);
    } catch (e) {
      return [];
    }
  }

  List<Review> safeParseReviews(List rawList) {
    return rawList
        .map<Review?>(
          (e) {
            try {
              return Review.fromJson(e);
            } catch (e) {
              app_config.printLog(
                "e",
                "API_USER_FETCH_REVIEWS ${e.toString()}",
              );
              return null;
            }
          },
        )
        .whereType<Review>()
        .toList();
  }

  Future<Result> addProductReview(
      {required String productId,
      required double rating,
      required String comment}) {
    return handleRequest(
      request: () => post("/api/product/create-review",
          data: {"productId": productId, "rating": rating, "comment": comment}),
    );
  }

  Future<Result> deleteProductReview({required String reviewId}) {
    return handleRequest(
      request: () =>
          delete("/api/product/delete-review", data: {"reviewId": reviewId}),
    );
  }
}
