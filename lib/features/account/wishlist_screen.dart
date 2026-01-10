import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../product/models/product.dart';
import '../../shared/widgets/product_card.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Wishlist Data
    final List<Product> wishlistProducts = [
      Product(
        id: '1',
        title: 'Casual Shirt',
        category: 'Mens',
        imageUrl: 'https://via.placeholder.com/150',
        price: 799,
        originalPrice: 999,
        rating: 4.2,
        reviews: 120,
        description: 'Comfortable cotton shirt',
        brand: 'FashionHub',
      ),
      Product(
        id: '2',
        title: 'Calvin Klein CK One',
        price: 49,
        originalPrice: 50,
        imageUrl:
            'https://images.unsplash.com/photo-1587017539504-67cfbddac569?q=80&w=200&auto=format&fit=crop',
        rating: 4.4,
        reviews: 482,
        category: 'Beauty',
        description: 'Classic fragrance',
        brand: 'Calvin Klein',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: wishlistProducts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Your wishlist is empty',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text('Save items you want to buy later!'),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Start Shopping'),
                  ),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65, // Adjusted for ProductCard
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: wishlistProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(product: wishlistProducts[index]);
              },
            ),
    );
  }
}
