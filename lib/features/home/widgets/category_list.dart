import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  final List<Map<String, dynamic>> categories = const [
    {'name': 'Offers', 'icon': Icons.local_offer_outlined},
    {'name': 'Grocery', 'icon': Icons.shopping_basket_outlined},
    {'name': 'Mobiles', 'icon': Icons.smartphone},
    {'name': 'Fashion', 'icon': Icons.checkroom},
    {'name': 'Electronics', 'icon': Icons.laptop},
    {'name': 'Home', 'icon': Icons.chair_outlined},
    {'name': 'Beauty', 'icon': Icons.face},
    {'name': 'Appliances', 'icon': Icons.kitchen},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // Navigate to All Categories
              GoRouter.of(context).push('/categories');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.lightGrey,
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Icon(
                      categories[index]['icon'] as IconData,
                      color: AppColors.primaryBlue,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    categories[index]['name'] as String,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
