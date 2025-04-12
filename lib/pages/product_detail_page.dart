import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(product.thumbnail, height: 200),
            ),
            SizedBox(height: 16),
            Text(product.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Price: \$${product.price}", style: TextStyle(fontSize: 16)),
            Text("Rating: ${product.rating}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text("Category: ${product.category}", style: TextStyle(fontSize: 14, color: Colors.grey)),
            SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Text("Product description goes here...", style: TextStyle(fontSize: 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
