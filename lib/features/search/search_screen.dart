import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1, // Slight shadow like the image
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
        titleSpacing: 0,
        title: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search grocery products',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey),
          ),
          style: const TextStyle(fontSize: 16),
          onSubmitted: (value) {
            // Navigate to products with search query
            context.push('/products', extra: {'category': value});
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.mic_none, color: Colors.black54),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt_outlined, color: Colors.black54),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Icon
            const Row(
              children: [
                Icon(
                  Icons.trending_up,
                  size: 20,
                  color: Colors.black87,
                ), // Assuming trend icon for "Discover More" or similar
                SizedBox(width: 8),
                Text(
                  'Discover More',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Chips Wrap
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildChip(context, 'Atta'),
                _buildChip(context, 'Ghee'),
                _buildChip(context, 'Detergent'),
                _buildChip(context, 'Oil'),
                _buildChip(context, 'Cold drink'),
                _buildChip(context, 'Biscuit'),
                _buildChip(context, 'Dal'),
                _buildChip(context, 'Fruit juice'),
                _buildChip(context, 'Energy drinks'),
                _buildChip(context, 'Dry fruits'),
                _buildChip(context, 'Rice'),
                _buildChip(context, 'Toothpaste'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(BuildContext context, String label) {
    return InkWell(
      onTap: () {
        context.push('/products', extra: {'category': label});
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey[100], // Light grey background
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
