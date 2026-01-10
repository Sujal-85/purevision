import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

class NewCollectionSection extends StatelessWidget {
  const NewCollectionSection({super.key});

  final List<String> _images = const [
    'https://media-public.canva.com/U-93E/MAEpYdU-93E/1/s.jpg',
    'https://media-public.canva.com/cVyko/MAEpYQcVyko/1/s.jpg',
    'https://media-public.canva.com/wJCBk/MAEpYRwJCBk/1/s.jpg',
    'https://media-public.canva.com/q71T0/MAEpYTq71T0/1/s.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF5D4037), // Dark Brown
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Header Text
          Column(
            children: [
              Text(
                'NEW',
                style:
                    GoogleFonts.anton(
                      fontSize: 60,
                      color: Colors.transparent,
                      height: 0.9,
                      decoration: TextDecoration.none,
                      shadows: [
                        const Shadow(
                          offset: Offset(0, 0),
                          blurRadius: 0,
                          color: Colors.white,
                        ),
                        const Shadow(
                          offset: Offset(0, 0),
                          blurRadius: 0,
                          color: Colors.white,
                        ),
                        // Using paint for outline effect simulation if needed, but standard hollow text needs Paint.
                      ],
                    ).copyWith(
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2
                        ..color = Colors.white,
                    ),
              ),
              Text(
                'COLLECTION',
                style: GoogleFonts.anton(
                  fontSize: 48, // Slightly smaller to fit width
                  color: Colors.white,
                  height: 0.9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // 2. Collage Grid
          SizedBox(
            height: 500,
            child: Row(
              children: [
                // Left Column (Tall)
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: _buildImageTile(_images[0]),
                  ),
                ),
                // Right Column
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      // Top Large
                      Expanded(
                        flex: 6,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: _buildImageTile(_images[1]),
                        ),
                      ),
                      // Bottom Row (Two Small)
                      Expanded(
                        flex: 4,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 4),
                                child: _buildImageTile(_images[2]),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 4),
                                child: _buildImageTile(_images[3]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // 3. Shop Now Button
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                'SHOP NOW',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageTile(String url) {
    return cachedNetworkImageBuilder(url);
  }

  Widget cachedNetworkImageBuilder(String url) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => Container(color: Colors.grey[800]),
      errorWidget: (context, url, error) => Container(color: Colors.grey[800]),
    );
  }
}
