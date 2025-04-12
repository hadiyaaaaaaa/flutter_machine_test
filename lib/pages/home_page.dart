import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import '../models/product_model.dart';

class HomePage extends StatelessWidget {
  final productCtrl = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () => showFilterDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Get.toNamed('/profile'),
          ),
        ],
      ),
      body: Obx(() {
        if (productCtrl.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (productCtrl.filteredList.isEmpty) {
          return const Center(child: Text("No products match the filter."));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: productCtrl.filteredList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 per row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (_, index) {
            final Product product = productCtrl.filteredList[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed('/detail', arguments: product);
              },
              child: Card(
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 1.2,
                      child: Image.network(product.thumbnail, fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        product.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('₹${product.price}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('⭐ ${product.rating}'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void showFilterDialog(BuildContext context) {
    final ctrl = Get.find<ProductController>();

    Get.defaultDialog(
      title: "Filter Products",
      content: Column(
        children: [
          DropdownButton<String>(
            hint: const Text('Select Category'),
            value: ctrl.selectedCategory.value.isEmpty
                ? null
                : ctrl.selectedCategory.value,
            onChanged: (val) {
              ctrl.selectedCategory.value = val!;
            },
            items: ctrl.productList
                .map((p) => p.category)
                .toSet()
                .map((category) => DropdownMenuItem(
                value: category, child: Text(category)))
                .toList(),
          ),
          const SizedBox(height: 10),
          DropdownButton<String>(
            hint: const Text('Select Price Range'),
            value: ctrl.selectedPriceRange.value.isEmpty
                ? null
                : ctrl.selectedPriceRange.value,
            onChanged: (val) {
              ctrl.selectedPriceRange.value = val!;
            },
            items: ['Below 500', 'Above 1000']
                .map((range) =>
                DropdownMenuItem(value: range, child: Text(range)))
                .toList(),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              ctrl.applyFilters();
              Get.back();
            },
            child: const Text("Apply"),
          )
        ],
      ),
    );
  }
}
