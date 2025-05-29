import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onSave;
  final VoidCallback? onShare;

  const ProductCard({
    super.key,
    required this.product,
    this.onSave,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Image.network(
            product.image,
            height: 80,
            width: 80,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // Fallback in case image doesn't load
              return Container(
                height: 80,
                width: 80,
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image),
              );
            },
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ListTile(
              title: Text(
                product.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text("₹ ${product.price.toStringAsFixed(2)}"),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            color: Colors.deepOrange,
            onPressed: onSave,
            tooltip: 'Save',
          ),
          IconButton(
            icon: const Icon(Icons.share),
            color: Colors.deepOrange,
            onPressed: onShare,
            tooltip: 'Share',
          ),
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'A',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
