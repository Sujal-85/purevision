import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'mock_product_service.dart';
import '../../features/product/models/product.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final Dio _dio = Dio(
    BaseOptions(
      // Use 10.0.2.2 for Android Emulator, localhost for iOS/Web
      baseUrl: 'http://10.164.207.157:5000/api',
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
    ),
  );

  String? _authToken;

  void setAuthToken(String token) {
    _authToken = token;
    _dio.options.headers['x-auth-token'] = token;
  }

  Future<void> syncUser(User firebaseUser) async {
    try {
      final response = await _dio.post(
        '/auth/sync',
        data: {
          'uid': firebaseUser.uid,
          'email': firebaseUser.email,
          'name': firebaseUser.displayName,
          'phone': firebaseUser.phoneNumber,
        },
      );

      if (response.statusCode == 200) {
        final token = response.data['token'];
        setAuthToken(token);
        debugPrint('Backend Sync Success: $token');
      }
    } catch (e) {
      debugPrint('Backend Sync Error: $e');
      // Handle error (maybe retry or show snackbar)
    }
  }

  Future<void> updateUserProfile({
    required String name,
    required String email,
  }) async {
    // Assuming we reuse sync for update or have a specific update endpoint
    // For now reusing sync logic or could add specific /user/update
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) return;

      // Update Firebase Auth Cache
      if (name != currentUser.displayName) {
        await currentUser.updateDisplayName(name);
      }
      if (email != currentUser.email && email.isNotEmpty) {
        // Note: This often requires recent login. If it fails, we might catch it.
        try {
          await currentUser.verifyBeforeUpdateEmail(email);
        } catch (e) {
          debugPrint('Error updating email: $e');
        }
      }

      // Force reload to ensure local user object is fresh
      await currentUser.reload();
      final updatedUser = FirebaseAuth.instance.currentUser;

      final response = await _dio.post(
        '/auth/sync',
        data: {
          'uid': updatedUser?.uid,
          'email': email,
          'name': name,
          'phone': updatedUser?.phoneNumber,
        },
      );

      if (response.statusCode == 200) {
        final token = response.data['token'];
        setAuthToken(token);
      }
    } catch (e) {
      debugPrint('Update Profile Error: $e');
    }
  }

  Future<bool> createOrder(Map<String, dynamic> orderData) async {
    try {
      // Ensure auth token is set
      if (_authToken == null) return false;

      final response = await _dio.post('/orders', data: orderData);

      return response.statusCode == 200;
    } catch (e) {
      debugPrint('Create Order Error: $e');
      return false;
    }
  }

  Future<List<dynamic>> getOrders(String userId) async {
    try {
      if (_authToken == null) return [];
      final response = await _dio.get('/orders/$userId');

      if (response.statusCode == 200) {
        return response.data;
      }
      return [];
    } catch (e) {
      debugPrint('Get Orders Error: $e');
      return [];
    }
  }

  Future<List<dynamic>> getProducts({String? category, String? search}) async {
    // 1. Try to fetch from Mock Service first if it looks like a UI category
    if (category != null) {
      final mockProducts = MockProductService().getProductsByFilter(category);
      if (mockProducts.isNotEmpty) {
        return mockProducts.map((p) => p.toJson()).toList();
      }
    }

    // Also check search query against mocks
    if (search != null && search.isNotEmpty) {
      final mockProducts = MockProductService().getProductsByFilter(search);
      if (mockProducts.isNotEmpty) {
        return mockProducts.map((p) => p.toJson()).toList();
      }
    }

    try {
      final response = await _dio.get(
        '/products',
        queryParameters: {
          if (category != null) 'category': category,
          if (search != null) 'search': search,
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      }
      return [];
    } catch (e) {
      debugPrint('Get Products Error: $e');
      // Fallback to mock data if backend fails?
      // Maybe not generally, but for specific dev/demo purposes clearly desired.
      return [];
    }
  }

  Future<dynamic> getProductById(String id) async {
    // Check if it's a mock product ID (we used simple ids like 'f1', 'm1')
    if ([
      'f',
      'e',
      'a',
      'm',
      'h',
      'b',
      't',
      'k',
      'g',
    ].contains(id.substring(0, 1))) {
      // It's likely a mock product. scan all?
      // This is inefficient but fine for mock.
      final allMocks = MockProductService().getProductsByCategory('all');
      final product = allMocks.firstWhere(
        (p) => p.id == id,
        orElse: () => Product(
          id: 'err',
          title: 'Not Found',
          price: 0,
          imageUrl: '',
          category: '',
          description: '',
          originalPrice: 0,
          rating: 0,
          reviews: 0,
          brand: '',
        ),
      );
      if (product.id != 'err') {
        return product.toJson();
      }
    }

    try {
      final response = await _dio.get('/products/$id');
      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } catch (e) {
      debugPrint('Get Product Details Error: $e');
      return null;
    }
  }
}
