import 'package:flutter/material.dart';
import '../../../models/product.dart';
import '../../../widgets/product_card.dart';

class SavedTab extends StatelessWidget {
  final List<Product> savedProducts;

  const SavedTab({Key? key, required this.savedProducts}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return savedProducts.isEmpty
        ? Center(child: Text("No saved products"))
        : ListView.builder(
      itemCount: savedProducts.length,
      itemBuilder: (context, index) {
        return ProductCard(product: savedProducts[index]);
      },
    );
  }
}
