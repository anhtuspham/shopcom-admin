import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../data/config/app_config.dart';
import '../data/model/product.dart';
import 'dart:typed_data';

class ProductState {
  final List<Product> product;
  final bool isLoading;
  final bool isError;
  final String? errorMessage;

  const ProductState(
      {required this.product,
      this.isLoading = false,
      this.isError = false,
      this.errorMessage});

  factory ProductState.initial() => const ProductState(product: []);

  ProductState copyWith(
      {List<Product>? product,
      bool? isLoading,
      bool? isError,
      String? errorMessage}) {
    return ProductState(
        product: product ?? this.product,
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}

class ProductNotifier extends StateNotifier<ProductState> {
  ProductNotifier() : super(ProductState.initial());

  Future<void> fetchProducts() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, isError: false);
    try {
      final product = await api.fetchProduct();
      state = state.copyWith(product: product, isLoading: false);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, isError: false, errorMessage: null);
    // await _updateProductState();
  }

  Future<bool> createProduct(
      {required String name,
      required String description,
      required String category,
      required String brand,
      required List<Map<String, dynamic>> variants,
      required List<List<XFile>> variantImages}) async {
    state = state.copyWith(isLoading: true, isError: false);
    try {
      final List<List<Uint8List>> variantImageBytes = [];
      for (var images in variantImages) {
        final List<Uint8List> imageBytes = [];
        for (var image in images) {
          final bytes = await image.readAsBytes();
          imageBytes.add(bytes);
        }
        variantImageBytes.add(imageBytes);
      }
      final result = await api.createProduct(
          name: name,
          description: description,
          category: category,
          brand: brand,
          variants: variants,
          variantImageBytes: variantImageBytes);
      print('result ${result.asError?.error}');
      if (result.isValue) {
        await _updateProductState();
        return true;
      } else {
        state = state.copyWith(
            isLoading: false,
            isError: true,
            errorMessage: "Failed to create product");
        return false;
      }
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
      return false;
    }
  }

  Future<bool> updateProduct(
      {required String id,
      String? name,
      String? description,
      String? category,
      String? brand,
      List<Map<String, dynamic>>? variants,
      List<List<XFile>>? variantImages}) async {
    state = state.copyWith(isLoading: true, isError: false);
    try {
      List<List<Uint8List>>? variantImageBytes;
      if (variantImages != null) {
        variantImageBytes = [];
        for (var images in variantImages) {
          final List<Uint8List> imageBytes = [];
          for (var image in images) {
            final bytes = await image.readAsBytes();
            imageBytes.add(bytes);
          }
          variantImageBytes.add(imageBytes);
        }
      }
      final result = await api.updateProductInfo(
          id: id,
          name: name,
          description: description,
          category: category,
          brand: brand,
          variants: variants,
          variantImageBytes: variantImageBytes);
      if (result.isValue) {
        await _updateProductState();
        return true;
      } else {
        state = state.copyWith(
            isLoading: false,
            isError: true,
            errorMessage: "Failed to update product");
        return false;
      }
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
      return false;
    }
  }

  Future<bool> deleteProduct({
    required String id,
  }) async {
    state = state.copyWith(isLoading: true, isError: false);
    try {
      final result = await api.deleteProduct(id: id);
      if (result.isValue) {
        await _updateProductState();
        return true;
      } else {
        state = state.copyWith(
            isLoading: false,
            isError: true,
            errorMessage: "Failed to delete product");
        return false;
      }
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
      return false;
    }
  }

  Future<void> _updateProductState() async {
    try {
      final product = await api.fetchProduct();
      state = state.copyWith(product: product, isLoading: false);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isError: true, errorMessage: e.toString());
    }
  }
}

final productProvider =
    StateNotifierProvider<ProductNotifier, ProductState>((ref) {
  final notifier = ProductNotifier();
  notifier.fetchProducts();
  return notifier;
});
