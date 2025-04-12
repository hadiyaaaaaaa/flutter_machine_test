import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductController extends GetxController {
  var productList = <Product>[].obs;
  var filteredList = <Product>[].obs;
  var isLoading = true.obs;

  var selectedCategory = ''.obs;
  var selectedPriceRange = ''.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse('https://dummyjson.com/products'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List products = jsonData['products'];
        productList.value = products.map((e) => Product.fromJson(e)).toList();
        filteredList.assignAll(productList);
      } else {
        Get.snackbar('Error', 'Failed to load products');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void applyFilters() {
    List<Product> results = productList;

    if (selectedCategory.value.isNotEmpty) {
      results = results.where((p) => p.category == selectedCategory.value).toList();
    }

    if (selectedPriceRange.value == 'Below 500') {
      results = results.where((p) => p.price < 500).toList();
    } else if (selectedPriceRange.value == 'Above 1000') {
      results = results.where((p) => p.price > 1000).toList();
    }

    filteredList.assignAll(results);
  }
}
