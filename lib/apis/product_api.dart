import 'package:shop_com_admin_web/apis/base_api.dart';
import 'package:shop_com_admin_web/data/model/product.dart';
import 'package:async/async.dart';

import '../data/config/app_config.dart';

mixin ProductApi on BaseApi {
  Future<List<Product>> fetchProduct(
      {String? sortBy, String? page, String? limit}) async {
    final query = <String, String>{};
    if (sortBy != null) query['sort'] = sortBy;
    if (page != null) query['page'] = page;
    if (limit != null) query['limit'] = limit;

    Result result = await handleRequest(
      request: () async {
        return get('/api/products', queryParameters: query);
      },
    );
    try {
      final List rawList = result.asValue!.value;
      return safeParseProducts(rawList);
    } catch (e) {
      return [];
    }
  }

  List<Product> safeParseProducts(List rawList) {
    return rawList
        .map<Product?>((e) {
          try {
            return Product.fromJson(e);
          } catch (err) {
            app_config.printLog(
                "e", " API_USER_FETCH_PRODUCT : ${err.toString()} ");
            return null;
          }
        })
        .whereType<Product>()
        .toList();
  }

  Future<Product> fetchProductDetail({required String id}) async {
    Result result = await handleRequest(request: () async {
      return get('/api/product/get/$id');
    });
    try {
      return Product.fromJson(result.asValue!.value);
    } catch (_) {
      return Product.empty();
    }
  }

  Future<Result> deleteProduct({required String id}) async {
    return await handleRequest(
      request: () => delete('/api/product/delete/$id'),
    );
  }

// Future<Result> createProduct({})
}
