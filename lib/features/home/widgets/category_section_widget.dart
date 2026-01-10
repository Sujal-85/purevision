import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:purevision/shared/widgets/product_card.dart';
import '../../product/models/product.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

enum CategoryLayoutType { horizontalList, masonryGrid, fixedGrid }

class CategorySectionWidget extends StatelessWidget {
  final String title;
  final String category; // Used for "View All" navigation
  final List<Product> products;
  final CategoryLayoutType layoutType;
  final Color? backgroundColor;

  const CategorySectionWidget({
    super.key,
    required this.title,
    required this.category,
    required this.products,
    this.layoutType = CategoryLayoutType.horizontalList,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(12),
        // Subtle shadow like Amazon/Flipkart cards
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.push(
                      '/products',
                      extra: {
                        'category': category,
                      }, // Passing category for filtering
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Body based on Layout Type
          _buildBody(context),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    switch (layoutType) {
      case CategoryLayoutType.horizontalList:
        return SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: SizedBox(
                  width: 160,
                  child: ProductCard(product: products[index]),
                ),
              );
            },
          ),
        );

      case CategoryLayoutType.masonryGrid:
        // For a section within a scroll view, we can't easily use a sliver grid inside unless we are careful.
        // Since this widget is likely used inside a SliverList or Column, we use simple StaggeredGrid
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: products.map((product) {
              return StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                child: ProductCard(product: product),
              );
            }).toList(),
          ),
        );

      case CategoryLayoutType.fixedGrid:
        // A simple 2x2 grid (taking first 4 items)
        final displayProducts = products.take(4).toList();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              return ProductCard(product: displayProducts[index]);
            },
          ),
        );
    }
  }
}
