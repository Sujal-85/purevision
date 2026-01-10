class Product {
  final String id;
  final String title;
  final String category;
  final double price;
  final double originalPrice;
  final double rating;
  final int reviews;
  final String imageUrl;
  final String description;
  final String brand;
  final String subCategory;

  Product({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
    required this.description,
    required this.brand,
    this.subCategory = '',
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      title: (json['name'] ?? json['title'] ?? 'Unknown').toString(),
      category: (json['category'] ?? 'General').toString(),
      brand: (json['brand'] ?? 'Generic').toString(),
      price: (json['price'] ?? 0).toDouble(),
      originalPrice: (json['originalPrice'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      reviews: json['reviews'] ?? 0,
      imageUrl: (json['imageUrl'] ?? 'https://via.placeholder.com/150')
          .toString(),
      description: (json['description'] ?? '').toString(),
      subCategory: (json['subCategory'] ?? '').toString(),
    );
  }

  factory Product.fromCsv(List<dynamic> row) {
    // CSV: Index, Product, Category, SubCategory, Brand, Sale Price, Market Price, Type, Rating, Description
    return Product(
      id: row.isNotEmpty ? row[0].toString() : '0',
      title: row.length > 1 ? row[1].toString() : 'Unknown Product',
      category: row.length > 2 ? row[2].toString() : 'General',
      subCategory: row.length > 3 ? row[3].toString() : '',
      brand: row.length > 4 ? row[4].toString() : 'Generic',
      price: row.length > 5 ? (double.tryParse(row[5].toString()) ?? 0.0) : 0.0,
      originalPrice: row.length > 6
          ? (double.tryParse(row[6].toString()) ?? 0.0)
          : 0.0,
      rating: row.length > 8
          ? (double.tryParse(row[8].toString()) ?? 0.0)
          : 4.0,
      reviews: 50,
      imageUrl: row.length > 9 && row[9].toString().startsWith('http')
          ? row[9].toString()
          : 'https://via.placeholder.com/150',
      description: row.length > 10 ? row[10].toString() : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'price': price,
      'originalPrice': originalPrice,
      'rating': rating,
      'reviews': reviews,
      'imageUrl': imageUrl,
      'description': description,
      'brand': brand,
      'subCategory': subCategory,
    };
  }
}
