import 'dart:math';
import '../../features/product/models/product.dart';

class MockProductService {
  static final MockProductService _instance = MockProductService._internal();
  factory MockProductService() => _instance;
  MockProductService._internal();

  final Random _random = Random();

  List<Product> getProductsByCategory(String categoryId) {
    if (categoryId == 'all') {
      return _generateAllProducts();
    }

    switch (categoryId) {
      case 'fashion':
        return _generateFashionProducts();
      case 'electronics':
        return _generateElectronicsProducts();
      case 'appliances':
        return _generateAppliancesProducts();
      case 'mobiles':
        return _generateMobileProducts();
      case 'home':
        return _generateHomeProducts();
      case 'beauty':
        return _generateBeautyProducts();
      case 'toys':
        return _generateToysProducts();
      case 'kitchen':
        return _generateKitchenProducts();
      case 'gadgets':
        return _generateGadgetsProducts();
      case 'gadgets':
        return _generateGadgetsProducts();
      case 'household':
        return _generateHouseholdProducts();
      default:
        return [];
    }
  }

  // Filter by category or subcategory (case insensitive, partial match)
  List<Product> getProductsByFilter(String query) {
    if (query.isEmpty) return [];

    // If it matches a main id, use the optimized getter
    if ([
      'fashion',
      'electronics',
      'appliances',
      'mobiles',
      'home',
      'beauty',
      'toys',
      'kitchen',
      'gadgets',
      'household',
    ].contains(query.toLowerCase())) {
      return getProductsByCategory(query.toLowerCase());
    }

    final all = _generateAllProducts();
    final lowerQuery = query.toLowerCase();

    return all.where((p) {
      return p.category.toLowerCase().contains(lowerQuery) ||
          p.subCategory.toLowerCase().contains(lowerQuery) ||
          p.title.toLowerCase().contains(lowerQuery) ||
          // Also check against filter keys from CategoryModel if we had access,
          // but for now subCategory should match the filter keys.
          p.subCategory.toLowerCase() == lowerQuery;
    }).toList();
  }

  List<Product> _generateAllProducts() {
    return [
      ..._generateFashionProducts(),
      ..._generateElectronicsProducts(),
      ..._generateAppliancesProducts(),
      ..._generateMobileProducts(),
      ..._generateHomeProducts(),
      ..._generateBeautyProducts(),
      ..._generateToysProducts(),
      ..._generateKitchenProducts(),
      ..._generateGadgetsProducts(),
      ..._generateHouseholdProducts(),
    ];
  }

  // Helper to generate a product
  Product _createProduct({
    required String id,
    required String title,
    required String category,
    required String subCategory,
    required String imageUrl,
    required double price,
    double? originalPrice,
    double? rating,
    int? reviewCount,
    String? description,
  }) {
    return Product(
      id: id,
      title: title,
      category: category,
      subCategory: subCategory,
      imageUrl: imageUrl,
      price: price,
      originalPrice: originalPrice ?? price * 1.2,
      // offerPercentage is calculated getter in Product, not a constructor param
      rating: rating ?? (3.5 + _random.nextDouble() * 1.5), // 3.5 to 5.0
      reviews: reviewCount ?? _random.nextInt(500) + 10,
      description: description ?? 'High quality $title from top brands.',
      brand: 'Generic', // Added required brand
    );
  }

  List<Product> _generateFashionProducts() {
    return [
      _createProduct(
        id: 'f1',
        title: 'Men\'s Cotton T-Shirt',
        category: 'fashion',
        subCategory: 'Men',
        imageUrl:
            'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?q=80&w=200',
        price: 499,
      ),
      _createProduct(
        id: 'f2',
        title: 'Blue Denim Jeans',
        category: 'fashion',
        subCategory: 'Men',
        imageUrl:
            'https://images.unsplash.com/photo-1542272454315-4c01d7abdf4a?q=80&w=200',
        price: 1299,
        originalPrice: 2499,
      ),
      _createProduct(
        id: 'f3',
        title: 'Women\'s Floral Dress',
        category: 'fashion',
        subCategory: 'Women',
        imageUrl:
            'https://images.unsplash.com/photo-1618932260643-eee4a2f652a6?q=80&w=200',
        price: 899,
        originalPrice: 1999,
      ),
      _createProduct(
        id: 'f4',
        title: 'Leather Handbag',
        category: 'fashion',
        subCategory: 'Bag',
        imageUrl:
            'https://images.unsplash.com/photo-1584917865442-de89df76afd3?q=80&w=200',
        price: 2999,
        originalPrice: 5999,
      ),
      _createProduct(
        id: 'f5',
        title: 'Running Shoes',
        category: 'fashion',
        subCategory: 'Footwear',
        imageUrl:
            'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=200',
        price: 1599,
        originalPrice: 3599,
      ),
      _createProduct(
        id: 'f6',
        title: 'Classic Wristwatch',
        category: 'fashion',
        subCategory: 'Watch',
        imageUrl:
            'https://images.unsplash.com/photo-1524592094714-0f0654e20314?q=80&w=200',
        price: 2499,
        originalPrice: 4999,
      ),
      _createProduct(
        id: 'f7',
        title: 'Aviator Sunglasses',
        category: 'fashion',
        subCategory: 'Sunglasses',
        imageUrl:
            'https://images.unsplash.com/photo-1511499767150-a48a237f0083?q=80&w=200',
        price: 699,
        originalPrice: 1499,
      ),
    ];
  }

  List<Product> _generateElectronicsProducts() {
    return [
      _createProduct(
        id: 'e1',
        title: 'HP Pavilion Laptop',
        category: 'electronics',
        subCategory: 'Laptop',
        imageUrl:
            'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?q=80&w=200',
        price: 55000,
        originalPrice: 65000,
      ),
      _createProduct(
        id: 'e2',
        title: 'Wireless Mouse',
        category: 'electronics',
        subCategory: 'Accessory',
        imageUrl:
            'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?q=80&w=200',
        price: 899,
        originalPrice: 1499,
      ),
      _createProduct(
        id: 'e3',
        title: 'Gaming Headset',
        category: 'electronics',
        subCategory: 'Gaming',
        imageUrl:
            'https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?q=80&w=200',
        price: 2499,
        originalPrice: 4999,
      ),
      _createProduct(
        id: 'e4',
        title: 'Samsung Galaxy Tab',
        category: 'electronics',
        subCategory: 'Tablet',
        imageUrl:
            'https://images.unsplash.com/photo-1544816155-12df9643f363?q=80&w=200',
        price: 18999,
        originalPrice: 24999,
      ),
      _createProduct(
        id: 'e5',
        title: 'Bluetooth Speaker',
        category: 'electronics',
        subCategory: 'Speaker',
        imageUrl:
            'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?q=80&w=200',
        price: 1299,
        originalPrice: 2999,
      ),
      _createProduct(
        id: 'e6',
        title: 'External SSD 1TB',
        category: 'electronics',
        subCategory: 'Storage',
        imageUrl:
            'https://images.unsplash.com/photo-1628135891394-bb9e5ce6c413?q=80&w=200',
        price: 8999,
        originalPrice: 12999,
      ),
    ];
  }

  List<Product> _generateAppliancesProducts() {
    return [
      _createProduct(
        id: 'a1',
        title: 'LG Double Door Fridge',
        category: 'appliances',
        subCategory: 'Refrigerator',
        imageUrl:
            'https://images.unsplash.com/photo-1571175443880-49e1d58b794a?q=80&w=200',
        price: 25999,
        originalPrice: 35999,
      ),
      _createProduct(
        id: 'a2',
        title: 'Front Load Washing Machine',
        category: 'appliances',
        subCategory: 'Washing Machine',
        imageUrl:
            'https://images.unsplash.com/photo-1626806819282-2c1dc01a5e0c?q=80&w=200',
        price: 32000,
        originalPrice: 40000,
      ),
      _createProduct(
        id: 'a3',
        title: 'Philips Iron',
        category: 'appliances',
        subCategory: 'Iron',
        imageUrl:
            'https://images.unsplash.com/photo-1585659722983-3a675dabf194?q=80&w=200',
        price: 1499,
        originalPrice: 1999,
      ),
      _createProduct(
        id: 'a4',
        title: 'Microwave Oven',
        category: 'appliances',
        subCategory: 'Microwave',
        imageUrl:
            'https://images.unsplash.com/photo-1574269909862-7e1d70bb8078?q=80&w=200',
        price: 8999,
        originalPrice: 12000,
      ),
      _createProduct(
        id: 'a5',
        title: 'Mixer Grinder 750W',
        category: 'appliances',
        subCategory: 'Mixer',
        imageUrl:
            'https://images.unsplash.com/photo-1570222094114-284a441dd846?q=80&w=200',
        price: 3499,
        originalPrice: 5999,
      ),
      _createProduct(
        id: 'a6',
        title: 'Water Purifier RO+UV',
        category: 'appliances',
        subCategory: 'Purifier',
        imageUrl:
            'https://plus.unsplash.com/premium_photo-1663126298656-33616be83c32?q=80&w=200',
        price: 11999,
        originalPrice: 18999,
      ),
    ];
  }

  List<Product> _generateMobileProducts() {
    return [
      _createProduct(
        id: 'm1',
        title: 'iPhone 15 Pro',
        category: 'mobiles',
        subCategory: 'Smartphone',
        imageUrl:
            'https://images.unsplash.com/photo-1696446701796-da61225697cc?q=80&w=200',
        price: 129000,
        originalPrice: 139000,
      ),
      _createProduct(
        id: 'm2',
        title: 'Samsung S24 Ultra',
        category: 'mobiles',
        subCategory: 'Smartphone',
        imageUrl:
            'https://images.unsplash.com/photo-1707227183362-76226ed46944?q=80&w=200',
        price: 114000,
        originalPrice: 134000,
      ),
      _createProduct(
        id: 'm3',
        title: 'Fast Charger 20W',
        category: 'mobiles',
        subCategory: 'Charger',
        imageUrl:
            'https://images.unsplash.com/photo-1583863788434-e58a36330cf0?q=80&w=200',
        price: 1499,
        originalPrice: 1999,
      ),
      _createProduct(
        id: 'm4',
        title: 'Power Bank 20000mAh',
        category: 'mobiles',
        subCategory: 'Power Bank',
        imageUrl:
            'https://images.unsplash.com/photo-1609091839311-d5365f9ff1c5?q=80&w=200',
        price: 1999,
        originalPrice: 3499,
      ),
      _createProduct(
        id: 'm5',
        title: 'Back Cover for iPhone',
        category: 'mobiles',
        subCategory: 'Cover',
        imageUrl:
            'https://images.unsplash.com/photo-1586953229671-e2a5f66387e5?q=80&w=200',
        price: 499,
        originalPrice: 999,
      ),
    ];
  }

  List<Product> _generateHomeProducts() {
    return [
      _createProduct(
        id: 'h1',
        title: 'Modern Sofa Set',
        category: 'home',
        subCategory: 'Furniture',
        imageUrl:
            'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?q=80&w=200',
        price: 29999,
        originalPrice: 45000,
      ),
      _createProduct(
        id: 'h2',
        title: 'King Size Bed',
        category: 'home',
        subCategory: 'Furniture',
        imageUrl:
            'https://images.unsplash.com/photo-1505693416388-b0346efee958?q=80&w=200',
        price: 35000,
        originalPrice: 55000,
      ),
      _createProduct(
        id: 'h3',
        title: 'Wall Painting',
        category: 'home',
        subCategory: 'Decor',
        imageUrl:
            'https://images.unsplash.com/photo-1579783902614-a3fb3927b6a5?q=80&w=200',
        price: 1299,
        originalPrice: 2999,
      ),
      _createProduct(
        id: 'h4',
        title: 'Table Lamp',
        category: 'home',
        subCategory: 'Decor',
        imageUrl:
            'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?q=80&w=200',
        price: 899,
        originalPrice: 1599,
      ),
      _createProduct(
        id: 'h5',
        title: 'Floor Mat',
        category: 'home',
        subCategory: 'Decor',
        imageUrl:
            'https://images.unsplash.com/photo-1588612502334-031fbf2a2559?q=80&w=200',
        price: 499,
        originalPrice: 999,
      ),
    ];
  }

  List<Product> _generateBeautyProducts() {
    return [
      _createProduct(
        id: 'b1',
        title: 'Vitamin C Serum',
        category: 'beauty',
        subCategory: 'Face',
        imageUrl:
            'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?q=80&w=200',
        price: 699,
        originalPrice: 1299,
      ),
      _createProduct(
        id: 'b2',
        title: 'Matte Lipstick',
        category: 'beauty',
        subCategory: 'Makeup',
        imageUrl:
            'https://images.unsplash.com/photo-1586495777744-4413f21062dc?q=80&w=200',
        price: 399,
        originalPrice: 799,
      ),
      _createProduct(
        id: 'b3',
        title: 'Shampoo 1L',
        category: 'beauty',
        subCategory: 'Hair',
        imageUrl:
            'https://images.unsplash.com/photo-1535585209827-a15fcdbc2c2d?q=80&w=200',
        price: 549,
        originalPrice: 999,
      ),
      _createProduct(
        id: 'b4',
        title: 'Perfume for Men',
        category: 'beauty',
        subCategory: 'Perfume',
        imageUrl:
            'https://images.unsplash.com/photo-1594035910387-fea47794261f?q=80&w=200',
        price: 1499,
        originalPrice: 2999,
      ),
      _createProduct(
        id: 'b5',
        title: 'Trimmer',
        category: 'beauty',
        subCategory: 'Tool',
        imageUrl:
            'https://images.unsplash.com/photo-1621607512214-68297480165e?q=80&w=200',
        price: 999,
        originalPrice: 1999,
      ),
    ];
  }

  List<Product> _generateToysProducts() {
    return [
      _createProduct(
        id: 't1',
        title: 'Teddy Bear',
        category: 'toys',
        subCategory: 'Soft Toy',
        imageUrl:
            'https://images.unsplash.com/photo-1559454403-b8fb87521bc8?q=80&w=200',
        price: 599,
        originalPrice: 999,
      ),
      _createProduct(
        id: 't2',
        title: 'LEGO Set',
        category: 'toys',
        subCategory: 'Educational',
        imageUrl:
            'https://images.unsplash.com/photo-1585366119957-e9730b6d0f60?q=80&w=200',
        price: 3499,
        originalPrice: 4999,
      ),
      _createProduct(
        id: 't3',
        title: 'Remote Control Car',
        category: 'toys',
        subCategory: 'RC',
        imageUrl:
            'https://images.unsplash.com/photo-1594787318286-3d835c1d207f?q=80&w=200',
        price: 1299,
        originalPrice: 2499,
      ),
      _createProduct(
        id: 't4',
        title: 'Baby Diapers Pack',
        category: 'toys',
        subCategory: 'Diaper',
        imageUrl:
            'https://images.unsplash.com/photo-1519689680058-324335c77eba?q=80&w=200',
        price: 899,
        originalPrice: 1299,
      ),
      _createProduct(
        id: 't5',
        title: 'Baby Wipes',
        category: 'toys',
        subCategory: 'Diaper',
        imageUrl:
            'https://images.unsplash.com/photo-1616428753235-cb414cb35061?q=80&w=200',
        price: 299,
        originalPrice: 499,
      ),
    ];
  }

  List<Product> _generateKitchenProducts() {
    return [
      _createProduct(
        id: 'k1',
        title: 'Non-Stick Pan',
        category: 'kitchen',
        subCategory: 'Cookware',
        imageUrl:
            'https://images.unsplash.com/photo-1584990347449-a0846b137632?q=80&w=200',
        price: 899,
        originalPrice: 1599,
      ),
      _createProduct(
        id: 'k2',
        title: 'Pressure Cooker 3L',
        category: 'kitchen',
        subCategory: 'Cooker',
        imageUrl:
            'https://images.unsplash.com/photo-1593121925328-369cc802e345?q=80&w=200',
        price: 1599,
        originalPrice: 2499,
      ),
      _createProduct(
        id: 'k3',
        title: 'Knife Set',
        category: 'kitchen',
        subCategory: 'Cutlery',
        imageUrl:
            'https://images.unsplash.com/photo-1593642532400-2682810df593?q=80&w=200',
        price: 599,
        originalPrice: 999,
      ),
      _createProduct(
        id: 'k4',
        title: 'Steel Water Bottle',
        category: 'kitchen',
        subCategory: 'Bottle',
        imageUrl:
            'https://images.unsplash.com/photo-1602143407151-011141920038?q=80&w=200',
        price: 399,
        originalPrice: 799,
      ),
      _createProduct(
        id: 'k5',
        title: 'Glass Container Set',
        category: 'kitchen',
        subCategory: 'Storage',
        imageUrl:
            'https://images.unsplash.com/photo-1613082531388-372b6473c386?q=80&w=200',
        price: 799,
        originalPrice: 1299,
      ),
    ];
  }

  List<Product> _generateGadgetsProducts() {
    return [
      _createProduct(
        id: 'g1',
        title: 'Smart Fitness Band',
        category: 'gadgets',
        subCategory: 'Band',
        imageUrl:
            'https://images.unsplash.com/photo-1575311373937-040b8e1fd5b6?q=80&w=200',
        price: 1999,
        originalPrice: 3999,
      ),
      _createProduct(
        id: 'g2',
        title: 'Smart Bulb RGB',
        category: 'gadgets',
        subCategory: 'Light',
        imageUrl:
            'https://images.unsplash.com/photo-1565814329452-e1efa11c5b89?q=80&w=200',
        price: 699,
        originalPrice: 1499,
      ),
      _createProduct(
        id: 'g3',
        title: 'Security Camera',
        category: 'gadgets',
        subCategory: 'Camera',
        imageUrl:
            'https://images.unsplash.com/photo-1557324232-b8917d3c3d63?q=80&w=200',
        price: 2999,
        originalPrice: 5999,
      ),
      _createProduct(
        id: 'g4',
        title: 'Smart Plug',
        category: 'gadgets',
        subCategory: 'Plug',
        imageUrl:
            'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?q=80&w=200',
        price: 899,
        originalPrice: 1999,
      ),
      _createProduct(
        id: 'g5',
        title: 'Google Home Mini',
        category: 'gadgets',
        subCategory: 'Speaker',
        imageUrl:
            'https://images.unsplash.com/photo-1589492477829-5e65395b66cc?q=80&w=200',
        price: 3499,
        originalPrice: 4999,
      ),
    ];
  }

  List<Product> _generateHouseholdProducts() {
    return [
      _createProduct(
        id: 'hh1',
        title: 'Floor Cleaner 5L',
        category: 'household',
        subCategory: 'Cleaning',
        imageUrl:
            'https://images.unsplash.com/photo-1585421514738-01798e1642d3?q=80&w=200',
        price: 599,
        originalPrice: 999,
      ),
      _createProduct(
        id: 'hh2',
        title: 'Laundry Typod',
        category: 'household',
        subCategory: 'Detergent',
        imageUrl:
            'https://images.unsplash.com/photo-1610557890948-243e69645801?q=80&w=200',
        price: 399,
        originalPrice: 699,
      ),
      _createProduct(
        id: 'hh3',
        title: 'Air Freshener Spray',
        category: 'household',
        subCategory: 'Freshener',
        imageUrl:
            'https://images.unsplash.com/photo-1572490122747-3968d75c6c54?q=80&w=200',
        price: 199,
        originalPrice: 299,
      ),
      _createProduct(
        id: 'hh4',
        title: 'Garbage Bags (30 Pcs)',
        category: 'household',
        subCategory: 'Garbage',
        imageUrl:
            'https://images.unsplash.com/photo-1606771032551-93c66299b669?q=80&w=200',
        price: 149,
        originalPrice: 249,
      ),
      _createProduct(
        id: 'hh5',
        title: 'Toilet Cleaner',
        category: 'household',
        subCategory: 'Bathroom',
        imageUrl:
            'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?q=80&w=200',
        price: 129,
        originalPrice: 199,
      ),
    ];
  }
}
