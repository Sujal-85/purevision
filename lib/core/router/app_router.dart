import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/product/product_listing_screen.dart';
import '../../features/product/product_detail_screen.dart';
import '../../features/categories/all_categories_screen.dart';
import '../../features/categories/sub_category_screen.dart';
import '../../features/categories/models/category_model.dart';
import '../../features/search/search_screen.dart';
import '../../features/account/profile_screen.dart';
import '../../features/cart/cart_screen.dart';
import '../../features/play/play_screen.dart';
import 'scaffold_with_nav_bar.dart';
import '../../features/orders/orders_screen.dart';
import '../../features/orders/order_tracking_screen.dart';
import '../../features/orders/models/order_model.dart';
import '../../features/checkout/checkout_screen.dart';
import '../../features/support/feedback_screen.dart';
import '../../features/support/complaints_screen.dart';
import '../../features/account/secure_vault_screen.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/user_info_screen.dart';
import '../../features/account/settings_screen.dart';
import '../../features/account/saved_addresses_screen.dart';
import '../../features/account/edit_profile_screen.dart';
import '../../features/account/wishlist_screen.dart';
import '../../features/account/coupons_screen.dart';
import '../../features/account/notification_settings_screen.dart';
import '../../features/account/privacy_center_screen.dart';
import '../../features/account/language_screen.dart';
import '../../features/account/my_reviews_screen.dart';
import '../../features/account/my_qa_screen.dart';
import '../../features/account/sell_on_flipkart_screen.dart';
import '../../features/support/terms_policies_screen.dart';
import '../../features/support/faqs_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async'; // For StreamSubscription

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellHome',
);
final _shellNavigatorPlayKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellPlay',
);
final _shellNavigatorCategoriesKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellCategories',
);
final _shellNavigatorCartKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellCart',
);
final _shellNavigatorAccountKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellAccount',
);

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  refreshListenable: GoRouterRefreshStream(
    FirebaseAuth.instance.authStateChanges(),
  ),
  redirect: (context, state) {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    final isLoggingIn = state.uri.toString() == '/login';
    final isSplash = state.uri.toString() == '/';

    if (!isLoggedIn && !isLoggingIn && !isSplash) return '/login';

    return null;
  },
  debugLogDiagnostics: true,
  errorPageBuilder: (context, state) => const MaterialPage(
    child: Scaffold(body: Center(child: CircularProgressIndicator())),
  ),
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    // ShellRoute for Bottom Navigation
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        // 1. Home Branch
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                child: const HomeScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
              ),
            ),
          ],
        ),

        // 2. Play (Shorts) Branch
        StatefulShellBranch(
          navigatorKey: _shellNavigatorPlayKey,
          routes: [
            GoRoute(
              path: '/play',
              builder: (context, state) => const PlayScreen(),
            ),
          ],
        ),

        // 3. Categories Branch
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCategoriesKey,
          routes: [
            GoRoute(
              path: '/categories',
              builder: (context, state) => const AllCategoriesScreen(),
            ),
          ],
        ),

        // 4. Cart Branch
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCartKey,
          routes: [
            GoRoute(
              path: '/cart',
              builder: (context, state) => const CartScreen(),
            ),
          ],
        ),

        // 5. Account Branch
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAccountKey,
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),

    // Other top-level routes (e.g., Search, Product Details) that might hide the bottom bar
    GoRoute(
      path: '/search',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: '/orders',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const OrdersScreen(),
    ),
    GoRoute(
      path: '/order_tracking',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) =>
          OrderTrackingScreen(order: state.extra as OrderModel),
    ),
    GoRoute(
      path: '/checkout',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => CheckoutScreen(
        totalAmount: (state.extra as Map<String, dynamic>?)?['total'] ?? 0.0,
      ),
    ),
    GoRoute(
      path: '/login',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/feedback',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const FeedbackScreen(),
    ),
    GoRoute(
      path: '/complaints',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ComplaintsScreen(),
    ),
    GoRoute(
      path: '/user_info',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const UserInfoScreen(),
    ),
    GoRoute(
      path: '/secure_vault',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SecureVaultScreen(),
    ),
    GoRoute(
      path: '/settings',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/saved_addresses',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SavedAddressesScreen(),
    ),
    GoRoute(
      path: '/subcategory',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final subCategory = state.extra as SubCategory;
        return SubCategoryScreen(subCategory: subCategory);
      },
    ),
    GoRoute(
      path: '/products',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final category = extra?['category'] as String?;
        return ProductListingScreen(category: category);
      },
    ),
    GoRoute(
      path: '/product_detail',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) =>
          ProductDetailScreen(product: state.extra as Map<String, dynamic>),
    ),
    GoRoute(
      path: '/edit_profile',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(
      path: '/wishlist',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const WishlistScreen(),
    ),
    GoRoute(
      path: '/coupons',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const CouponsScreen(),
    ),
    GoRoute(
      path: '/language',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const LanguageScreen(),
    ),
    GoRoute(
      path: '/notification_settings',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const NotificationSettingsScreen(),
    ),
    GoRoute(
      path: '/privacy_center',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const PrivacyCenterScreen(),
    ),
    GoRoute(
      path: '/my_reviews',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const MyReviewsScreen(),
    ),
    GoRoute(
      path: '/my_qa',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const MyQaScreen(),
    ),
    GoRoute(
      path: '/sell',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SellOnFlipkartScreen(),
    ),
    GoRoute(
      path: '/terms',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const TermsPoliciesScreen(),
    ),
    GoRoute(
      path: '/faqs',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const FaqsScreen(),
    ),
  ],
);

// GoRouter Refresh Stream Class
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
