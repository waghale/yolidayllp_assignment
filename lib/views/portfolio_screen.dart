import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'tab/project_tab.dart';
import 'tab/saved_tab.dart';
import 'tab/shared_tab.dart';
import 'tab/achievement_tab.dart';
import '../../models/product.dart'; // Import your Product model

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}
class _PortfolioScreenState extends State<PortfolioScreen> {
  List<Product> allProducts = [];
  List<Product> savedProducts = [];
  List<Product> sharedProducts = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      final products = await ApiService.fetchProducts();
      setState(() {
        allProducts = products;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(child: Text('Error: $errorMessage'));
    }

    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Portfolio', style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white,
            elevation: 0,
            bottom: const TabBar(
              labelColor: Colors.deepOrange,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.deepOrange,
              tabs: [
                Tab(text: 'Project'),
                Tab(text: 'Saved'),
                Tab(text: 'Shared'),
                Tab(text: 'Achievement'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ProjectTab(
                products: allProducts,
                onSave: (product) {
                  setState(() {
                    savedProducts.add(product);
                  });
                },
                onShare: (product) {
                  setState(() {
                    sharedProducts.add(product);
                  });
                },
              ),
              SavedTab(savedProducts: savedProducts),
              SharedTab(sharedProducts: sharedProducts),
              AchievementTab(
                savedCount: savedProducts.length,
                sharedCount: sharedProducts.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}