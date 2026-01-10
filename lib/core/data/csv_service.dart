import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import '../../features/product/models/product.dart';

class CsvService {
  Future<List<Product>> loadProducts() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/bigbasket_products.csv',
      );
      List<List<dynamic>> rows = const CsvToListConverter().convert(response);

      // Remove header row
      if (rows.isNotEmpty) {
        rows.removeAt(0);
      }

      return rows
          .map((row) {
            // Safe parsing with defaults
            try {
              // CSV Columns: id, product, category, sub_category, brand, sale_price, market_price, type, rating, image, description
              return Product(
                id: row.isNotEmpty ? row[0].toString() : '0',
                title: row.length > 1 ? row[1].toString() : 'Unknown Product',
                category: row.length > 2 ? row[2].toString() : 'General',
                subCategory: row.length > 3 ? row[3].toString() : '',
                brand: row.length > 4 ? row[4].toString() : 'Generic',
                price: row.length > 5
                    ? (double.tryParse(row[5].toString()) ?? 0.0)
                    : 0.0,
                originalPrice: row.length > 6
                    ? (double.tryParse(row[6].toString()) ?? 0.0)
                    : 0.0,
                rating: row.length > 8
                    ? (double.tryParse(row[8].toString()) ?? 0.0)
                    : 4.0,
                reviews: 50, // Dummy
                imageUrl: row.length > 9
                    ? row[9].toString()
                    : 'https://dummyjson.com/image/i/products/1/thumbnail.jpg',
                description: row.length > 10 ? row[10].toString() : '',
                // Store subcategory in a way we can use it? Data model needs subcategory field if we want to filter by it strictly.
                // For now, we can perhaps assume the category passed to filter will match subcategory if category is Grocery.
              );
            } catch (e) {
              // Skip malformed rows
              return null;
            }
          })
          .whereType<Product>()
          .toList(); // Filter out nulls
    } catch (e) {
      print('Error loading CSV: $e');
      return [];
    }
  }
}
