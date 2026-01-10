import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import 'widgets/banner_carousel.dart';
import 'widgets/image_grid.dart';
import 'widgets/promo_slider.dart';
import 'widgets/home_widgets.dart';
import 'widgets/address_bottom_sheet.dart';
import '../../shared/widgets/product_card.dart';
import '../../core/services/api_service.dart';
import '../../core/data/csv_service.dart'; // Import CsvService
import 'widgets/category_section_widget.dart';
import 'widgets/fashion_styling_section.dart';
import 'widgets/new_collection_section.dart';
import '../../features/product/models/product.dart';
import 'widgets/sales_timer_banner.dart';
import 'widgets/top_selection_widget.dart';
import 'widgets/suggested_for_you_widget.dart';
import '../../features/categories/models/category_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  final CsvService _csvService = CsvService(); // Instance of CsvService

  List<Product> _products = []; // Strongly typed list
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      // 1. Try fetching from API
      final apiData = await _apiService.getProducts();

      if (apiData.isNotEmpty) {
        setState(() {
          _products = apiData
              .map((e) => Product.fromJson(e))
              .toList(); // Map using fromJson
          _isLoading = false;
        });
      } else {
        // 2. Fallback to CSV if API returns empty/fails
        debugPrint('API empty, falling back to CSV');
        final csvProducts = await _csvService.loadProducts();
        setState(() {
          _products = csvProducts;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
      // Final fallback attempt
      final csvProducts = await _csvService.loadProducts();
      if (mounted) {
        setState(() {
          _products = csvProducts;
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primaryBlue),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF1F3F6),
      body: RefreshIndicator(
        onRefresh: _fetchData,
        color: AppColors.primaryBlue,
        child: CustomScrollView(
          slivers: [
            // 1. Floating App Bar
            SliverAppBar(
              floating: false,
              pinned: true,
              snap: false,
              backgroundColor: const Color(0xFFFDF003), // Fallback Yellow
              elevation: 1,
              titleSpacing: 0,
              toolbarHeight: 100,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFDF003), // Vibrant Yellow (Flipkart-ish)
                      Color(0xFFFFEB3B), // Yellow 500
                      Color(0xFFFFF9C4), // Yellow 100 (Fade near categories)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Row 1: Brand & Location
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        Image.asset('assets/logo.png', height: 24),
                        const SizedBox(width: 12),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) =>
                                    const AddressBottomSheet(),
                              );
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 16,
                                  color: Colors.black54,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '400606, Thane',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 13,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 16,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Row 2: Search Bar
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: GestureDetector(
                      onTap: () => context.push('/search'),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.transparent),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: const Row(
                          children: [
                            Icon(Icons.search, color: Colors.grey),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Search for products...',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Icon(Icons.mic_none, color: Colors.grey),
                            SizedBox(width: 12),
                            Icon(Icons.camera_alt_outlined, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(110),
                child: Container(
                  height: 110,
                  padding: const EdgeInsets.only(top: 12, bottom: 8),
                  alignment: Alignment.center,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: CategoryData.categories.length,
                    itemBuilder: (context, index) {
                      final category = CategoryData.categories[index];
                      return _buildCircleCategory(
                        category.title,
                        category.iconUrl ?? 'https://via.placeholder.com/150',
                        category.id,
                      );
                    },
                  ),
                ),
              ),
            ),

            // 3. Top Banner Carousel
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 8),
                child: BannerCarousel(),
              ),
            ),

            // 3.1. Local Grid Assets (Banners)
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(
            //       horizontal: 16.0,
            //       vertical: 8,
            //     ),
            //     child: Column(
            //       children: [
            //         ClipRRect(
            //           borderRadius: BorderRadius.circular(12),
            //           child: Image.asset(
            //             'assets/grids/grid.png',
            //             width: double.infinity,
            //             fit: BoxFit.cover,
            //             errorBuilder: (ctx, _, __) => const SizedBox(),
            //           ),
            //         ),
            //         const SizedBox(height: 12),
            //         ClipRRect(
            //           borderRadius: BorderRadius.circular(12),
            //           child: Image.asset(
            //             'assets/grids/grid1.png', // Assuming this is grid1.png
            //             width: double.infinity,
            //             fit: BoxFit.cover,
            //             errorBuilder: (ctx, _, __) => const SizedBox(),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            // 4. Pro Layout Integration (Timer, Top Selection, Suggested)
            SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 8),

                // Sales Timer
                SalesTimerBanner(
                  endTime: DateTime.now().add(
                    const Duration(hours: 2, minutes: 45),
                  ),
                ),
                const SizedBox(height: 12),

                // Top Selection Widget
                // Top Selection Widget
                if (_products.isNotEmpty)
                  TopSelectionWidget(
                    title: 'Top Selection',
                    items: _products.take(4).toList(),
                  ),
                const SizedBox(height: 16),

                // Promo Inject 1
                const PromoSlider(
                  height: 250,
                  viewportFraction: 0.85,
                  images: [
                    'assets/banners/image2.png',
                    'https://images.unsplash.com/photo-1555529669-e69e7aa0ba9a?auto=format&fit=crop&w=1000&q=80',
                    'assets/banners/image4.png',
                  ],
                ),
                const SizedBox(height: 16),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                  child: Text(
                    'New Collection',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),


                const NewCollectionSection(),
                const SizedBox(height: 16),

                // Suggested For You
                if (_products.isNotEmpty)
                  SuggestedForYouWidget(
                    title: 'Suggested For You',
                    products: _products.take(6).toList(),
                  ),
                const SizedBox(height: 16),

                // Promo Inject 2
                const PromoSlider(
                  height: 250,
                  viewportFraction: 0.85,
                  images: [
                    'https://images.unsplash.com/photo-1483985988355-763728e1935b?auto=format&fit=crop&w=1000&q=80',
                    'assets/banners/image.png',
                    'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?auto=format&fit=crop&w=1000&q=80',
                  ],
                ),
                const SizedBox(height: 16),

                

                // 3.2. Dynamic Image Grid (Canva Girls)
                // 3.2. Dynamic Image Grid (Canva Girls)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: ImageGrid(),
                ),
                const SizedBox(height: 24),

                // 5. Category: Grocery (Foodgrains) - Horizontal List
                if (_products.any(
                  (p) =>
                      p.subCategory == 'Foodgrains' || p.category == 'Grocery',
                ))
                  CategorySectionWidget(
                    title: 'Daily Essentials',
                    category: 'Foodgrains', // Or 'Grocery'
                    products: _products
                        .where(
                          (p) =>
                              p.subCategory == 'Foodgrains' ||
                              p.category == 'Grocery',
                        )
                        .take(6)
                        .toList(),
                    layoutType: CategoryLayoutType.horizontalList,
                  ),
                const SizedBox(height: 12),

                // 6. Category: Fashion - Masonry Grid
                if (_products.any(
                  (p) => p.category == 'Clothing' || p.category == 'Fashion',
                ))
                  CategorySectionWidget(
                    title: 'Trending Styles',
                    category: 'Clothing',
                    products: _products
                        .where(
                          (p) =>
                              p.category == 'Clothing' ||
                              p.category == 'Fashion',
                        )
                        .take(4)
                        .toList(),
                    layoutType: CategoryLayoutType.masonryGrid,
                  ),
                const SizedBox(height: 24),

                // 7. Category: Snacks - Horizontal List
                if (_products.any((p) => p.category == 'Snacks'))
                  CategorySectionWidget(
                    title: 'Snack Time',
                    category: 'Snacks',
                    products: _products
                        .where((p) => p.category == 'Snacks')
                        .take(6)
                        .toList(),
                    layoutType: CategoryLayoutType.horizontalList,
                  ),
                const SizedBox(height: 16),

                // 8. Category: Household - Fixed Grid
                if (_products.any(
                  (p) => p.category == 'Household' || p.category == 'Home',
                ))
                  CategorySectionWidget(
                    title: 'Home & Decor',
                    category: 'Household',
                    products: _products
                        .where(
                          (p) =>
                              p.category == 'Household' || p.category == 'Home',
                        )
                        .take(4)
                        .toList(),
                    layoutType: CategoryLayoutType.fixedGrid,
                  ),
                const SizedBox(height: 20),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                  child: Text(
                    'Styling Tips',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                // 8. Fashion Styling Tips Collage
                const FashionStylingSection(),

                const SizedBox(height: 20),

                // Header for Explore More (Infinite Grid)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                  child: Text(
                    'Explore More',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                // Promo Inject 3 (Before Infinite Grid)
                const PromoSlider(
                  height: 230,
                  viewportFraction: 1.0,
                  images: [
                    'assets/banners/image1.png',
                    'assets/banners/image2.png',
                    'assets/banners/image6.png',
                  ],
                ),
                const SizedBox(height: 16),
              ]),
            ),

            // 9. Infinite Grid (Explore More)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.58,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
              ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    // Filter out already shown products if needed, but for "Explore More" showing all or random is fine.
                    // For now, listing all products again as a discovery feed.
                    if (_products.isEmpty) return const SizedBox.shrink();
                    final safeIndex = index % _products.length;
                    return ProductCard(product: _products[safeIndex]);
                  },
                  childCount: _products.isNotEmpty ? 100 : 0,
                ), // Infinite scroll limit
              ),
            ),

            // 10. Bottom Spacer
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleCategory(String label, String imgUrl, String id) {
    return GestureDetector(
      onTap: () => context.push('/products', extra: {'category': id}),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[100],
                border: Border.all(color: Colors.grey[300]!),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(imgUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: 70,
              child: Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoBanner(String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CachedNetworkImage(
        imageUrl: url,
        width: double.infinity,
        height: 140,
        fit: BoxFit.cover,
        placeholder: (context, url) =>
            Container(color: Colors.grey[200], height: 140),
        errorWidget: (context, url, err) =>
            Container(color: Colors.grey[200], height: 140),
      ),
    );
  }
}
