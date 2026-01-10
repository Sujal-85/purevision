import '../../product/models/product.dart';

enum OrderStatus {
  ordered,
  packed,
  shipped,
  outForDelivery,
  delivered,
  cancelled,
}

class OrderModel {
  final String id;
  final List<Product> products;
  final double totalAmount;
  final DateTime date;
  final OrderStatus status;
  final String? trackingId;

  OrderModel({
    required this.id,
    required this.products,
    required this.totalAmount,
    required this.date,
    required this.status,
    this.trackingId,
  });

  // Convenience Getters
  String get productName =>
      products.isNotEmpty ? products.first.title : 'Unknown Product';
  String get imageUrl => products.isNotEmpty ? products.first.imageUrl : '';
  double get amount => totalAmount;

  // Mock Data
  static List<OrderModel> get mockOrders {
    return [
      OrderModel(
        id: 'OD124567890123',
        products: [
          Product(
            id: 'p1',
            category: 'Fashion',
            title: 'Men Regular Fit Solid Casual Shirt',
            imageUrl:
                'https://rukminim1.flixcart.com/image/612/612/xif0q/shirt/i/i/s/-original-imaghgckcnwuzr5a.jpeg?q=70',
            price: 499,
            originalPrice: 1999,
            brand: 'Generic',
            reviews: 10,
            description: 'A nice shirt',
            rating: 4.2,
          ),
        ],
        totalAmount: 499,
        date: DateTime.now().subtract(const Duration(days: 2)),
        status: OrderStatus.shipped,
        trackingId: 'FMP123456789',
      ),
      OrderModel(
        id: 'OD987654321098',
        products: [
          Product(
            id: 'p2',
            category: 'Electronics',
            title: 'Noise ColorFit Icon 2',
            imageUrl:
                'https://rukminim1.flixcart.com/image/612/612/xif0q/smartwatch/3/i/z/-original-imagnj29gqj6gxs5.jpeg?q=70',
            price: 1299,
            originalPrice: 3999,
            brand: 'Noise',
            reviews: 50,
            description: 'Smart watch',
            rating: 4.1,
          ),
        ],
        totalAmount: 1299,
        date: DateTime.now().subtract(const Duration(days: 10)),
        status: OrderStatus.delivered,
      ),
    ];
  }
}
