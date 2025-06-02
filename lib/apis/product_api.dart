import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
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

  Future<Result> createProduct({
    required String name,
    required String description,
    required String category,
    required String brand,
    required List<Map<String, dynamic>> variants,
    required List<List<Uint8List>> variantImageBytes,
  }) async {
    return await handleRequest(
      request: () async {
        final formData = FormData.fromMap({
          'name': name,
          'description': description,
          'category': category,
          'brand': brand,
          'variants': jsonEncode(variants),
        });

        // Add images for each variant
        for (int i = 0; i < variantImageBytes.length; i++) {
          for (int j = 0; j < variantImageBytes[i].length; j++) {
            formData.files.add(MapEntry(
              'images-$i',
              MultipartFile.fromBytes(
                variantImageBytes[i][j],
                filename: 'image-$i-$j.jpg', // Provide a filename
              ),
            ));
          }
        }

        return post('/api/product/create', formData: formData);
      },
    );
  }

  Future<Result> updateProductInfo({
    required String id,
    String? name,
    String? description,
    String? category,
    String? brand,
    List<Map<String, dynamic>>? variants,
    List<List<Uint8List>>? variantImageBytes,
  }) async {
    return await handleRequest(
      request: () async {
        final formData = FormData.fromMap({
          if (name != null) 'name': name,
          if (description != null) 'description': description,
          if (category != null) 'category': category,
          if (brand != null) 'brand': brand,
          if (variants != null) 'variants': jsonEncode(variants),
        });

        // Add images for each variant
        if (variantImageBytes != null) {
          for (int i = 0; i < variantImageBytes.length; i++) {
            for (int j = 0; j < variantImageBytes[i].length; j++) {
              formData.files.add(MapEntry(
                'images-$i',
                MultipartFile.fromBytes(
                  variantImageBytes[i][j],
                  filename: 'image-$i-$j.jpg', // Provide a filename
                ),
              ));
            }
          }
        }

        return put('/api/product/update/$id', data: formData);
      },
    );
  }
}
