import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ImageGrid extends StatelessWidget {
  const ImageGrid({super.key});

  final List<Map<String, String>> _gridItems = const [
    {
      'type': 'network',
      'path': 'https://media-public.canva.com/U-93E/MAEpYdU-93E/1/s.jpg',
    },
    {
      'type': 'network',
      'path': 'https://media-public.canva.com/wJCBk/MAEpYRwJCBk/1/s.jpg',
    },
    {
      'type': 'network',
      'path': 'https://media-public.canva.com/cVyko/MAEpYQcVyko/1/s.jpg',
    },
    {
      'type': 'network',
      'path': 'https://media-public.canva.com/q71T0/MAEpYTq71T0/1/s.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Featured Collections',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: _gridItems.map((item) {
              return StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                child: _buildGridItem(context, item),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, Map<String, String> item) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            item['type'] == 'asset'
                ? Image.asset(item['path']!, fit: BoxFit.cover)
                : CachedNetworkImage(
                    imageUrl: item['path']!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 150,
                      color: Colors.grey[200],
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 150,
                      color: Colors.grey[200],
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),
            // Optional: Add a smooth gradient overlay for text readability if needed
            // But for these specific stylized images, raw display might be better.
          ],
        ),
      ),
    );
  }
}
