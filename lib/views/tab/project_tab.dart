import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../../widgets/product_card.dart';
// update this path

class ProjectTab extends StatefulWidget {
  final List<Product> products;
  final Function(Product) onSave;
  final Function(Product) onShare;

  const ProjectTab({
    Key? key,
    required this.products,
    required this.onSave,
    required this.onShare,
  }) : super(key: key);

  @override
  _ProjectTabState createState() => _ProjectTabState();
}

class _ProjectTabState extends State<ProjectTab> {
  late List<Product> filteredProducts;
  String searchQuery = '';
  String selectedFilter = 'All';

  final List<String> filters = ['All', '< ₹50', '₹50 - ₹100', '> ₹100'];

  @override
  void initState() {
    super.initState();
    filteredProducts = widget.products;
  }

  void updateSearch(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      applyFilters();
    });
  }

  void updateFilter(String filter) {
    setState(() {
      selectedFilter = filter;
      applyFilters();
    });
  }

  void applyFilters() {
    filteredProducts = widget.products.where((product) {
      final matchesSearch = product.title.toLowerCase().contains(searchQuery);

      bool matchesFilter = false;
      switch (selectedFilter) {
        case '< ₹50':
          matchesFilter = product.price < 50;
          break;
        case '₹50 - ₹100':
          matchesFilter = product.price >= 50 && product.price <= 100;
          break;
        case '> ₹100':
          matchesFilter = product.price > 100;
          break;
        case 'All':
        default:
          matchesFilter = true;
      }

      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search products...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onChanged: updateSearch,
          ),
        ),

        // Filter chips for price ranges
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final filter = filters[index];
              final isSelected = filter == selectedFilter;
              return ChoiceChip(
                label: Text(filter),
                selected: isSelected,
                onSelected: (_) => updateFilter(filter),
                selectedColor: Colors.deepOrange,
                labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
              );
            },
          ),
        ),

        const SizedBox(height: 10),

        // Product list
        Expanded(
          child: ListView.builder(
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              return GestureDetector(
                onTap: () {}, // Optional tap on card
                child: ProductCard(product: product),
              );
            },
          ),
        ),
      ],
    );
  }
}
