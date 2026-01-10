import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'models/category_model.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({super.key});

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Get current category and its sub-items
    final selectedCategory = CategoryData.categories[_selectedIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Categories'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.mic)),
        ],
      ),
      body: Row(
        children: [
          // Sidebar (Left)
          Container(
            width: 90,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F5FF), // Light blue-ish sidebar
              border: Border(right: BorderSide(color: Colors.grey[300]!)),
            ),
            child: ListView.builder(
              itemCount: CategoryData.categories.length,
              itemBuilder: (context, index) {
                final category = CategoryData.categories[index];
                final isSelected = _selectedIndex == index;

                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    color: isSelected ? Colors.white : Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 8,
                    ),
                    child: Column(
                      children: [
                        // Highlight indicator
                        if (isSelected) ...[
                          // You can add a vertical bar or something here if needed
                        ],

                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected
                                ? AppColors.primaryBlue.withOpacity(0.1)
                                : Colors.white,
                            border: isSelected
                                ? Border.all(color: AppColors.primaryBlue)
                                : null,
                          ),
                          child: Icon(
                            category.iconData ?? Icons.category,
                            color: isSelected
                                ? AppColors.primaryBlue
                                : Colors.grey[600],
                            size: 24,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                            color: isSelected
                                ? AppColors.primaryBlue
                                : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Content Area (Right)
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Header for the section
                  Text(
                    selectedCategory.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Subcategories Grid
                  if (selectedCategory.subCategories.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Center(child: Text("No items here")),
                    )
                  else
                    GridView.builder(
                      physics:
                          const NeverScrollableScrollPhysics(), // Scroll parent ListView
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.7,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 12,
                          ),
                      itemCount: selectedCategory.subCategories.length,
                      itemBuilder: (context, index) {
                        final subCat = selectedCategory.subCategories[index];
                        return InkWell(
                          onTap: () {
                            // Check if it has Level 3 children
                            if (subCat.childCategories.isNotEmpty) {
                              // Navigate to SubCategory Screen
                              context.push('/subcategory', extra: subCat);
                            } else {
                              // Go directly to Products with filter
                              context.push(
                                '/products',
                                extra: {
                                  'category': subCat.filterKey ?? subCat.title,
                                },
                              );
                            }
                          },
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    shape: BoxShape.circle,
                                    // image: DecorationImage(image: CachedNetworkImageProvider(subCat.imageUrl))
                                  ),
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: subCat.imageUrl,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          Container(color: Colors.grey[200]),
                                      errorWidget: (context, url, err) =>
                                          const Icon(
                                            Icons.image_not_supported,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                subCat.title,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
