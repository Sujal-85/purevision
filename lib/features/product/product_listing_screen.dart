import 'package:flutter/material.dart';
import '../../shared/widgets/product_card.dart';
import '../../shared/widgets/product_card_skeleton.dart';
import '../../core/theme/app_colors.dart';
import '../../core/data/csv_service.dart';
import '../../core/services/api_service.dart';
import '../../features/product/models/product.dart';

class ProductListingScreen extends StatefulWidget {
  final String? category;
  const ProductListingScreen({super.key, this.category});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  final ApiService _apiService = ApiService();
  final CsvService _csvService = CsvService();
  List<Product> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    List<Product> fetchedProducts = [];
    try {
      // 1. Try API (includes Mock Service)
      final apiData = await _apiService.getProducts(category: widget.category);
      if (apiData.isNotEmpty) {
        fetchedProducts = apiData.map((e) => Product.fromJson(e)).toList();
      } else {
        // 2. Fallback to CSV (mainly for Grocery)
        final allCsv = await _csvService.loadProducts();
        if (widget.category != null) {
          fetchedProducts = allCsv.where((p) {
            final cat = p.category.toLowerCase();
            final sub = p.subCategory.toLowerCase();
            final filter = widget.category!.toLowerCase();
            return cat.contains(filter) || sub.contains(filter);
          }).toList();
        } else {
          fetchedProducts = allCsv;
        }
      }
    } catch (e) {
      debugPrint('Error loading products: $e');
    }

    if (mounted) {
      setState(() {
        _products = fetchedProducts;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category ?? 'Products'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
            onPressed: () {},
            icon: Badge(
              label: const Text('2'),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter & Sort Bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(child: _buildFilterOption(Icons.sort, 'Sort')),
                Container(width: 1, height: 24, color: Colors.grey[300]),
                Expanded(
                  child: _buildFilterOption(Icons.filter_list, 'Filter'),
                ),
              ],
            ),
          ),

          // Grid View
          Expanded(
            child: _isLoading
                ? GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.58,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                    itemCount: 6, // 6 skeletons
                    itemBuilder: (context, index) =>
                        const ProductCardSkeleton(),
                  )
                : _products.isEmpty
                ? const Center(child: Text('No products found'))
                : GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.58,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      final product = _products[index];
                      return ProductCard(product: product);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOption(IconData icon, String label) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: AppColors.textPrimary),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
