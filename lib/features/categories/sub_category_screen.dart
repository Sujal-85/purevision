import 'package:flutter/material.dart';
import 'models/category_model.dart';
import 'package:go_router/go_router.dart';

class SubCategoryScreen extends StatelessWidget {
  final SubCategory subCategory;

  const SubCategoryScreen({super.key, required this.subCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subCategory.title),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: subCategory.childCategories.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final childCatTitle = subCategory.childCategories[index];

          return ListTile(
            title: Text(
              childCatTitle,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
              // Filter products by this specific sub-category name
              context.push('/products', extra: {'category': childCatTitle});
            },
          );
        },
      ),
    );
  }
}
