

import 'package:flutter/material.dart';
import '../../../models/product.dart';
import '../../../widgets/product_card.dart';

class SharedTab extends StatelessWidget {
  final List<Product> sharedProducts;

  const SharedTab({Key? key, required this.sharedProducts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return sharedProducts.isEmpty
        ? Center(child: Text("No shared products"))
        : ListView.builder(
      itemCount: sharedProducts.length,
      itemBuilder: (context, index) {
        return ProductCard(product: sharedProducts[index]);
      },
    );
  }
}
