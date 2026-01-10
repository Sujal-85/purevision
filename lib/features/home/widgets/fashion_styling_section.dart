import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

class FashionStylingSection extends StatelessWidget {
  const FashionStylingSection({super.key});

  final List<String> _images = const [
    'https://media-public.canva.com/U-93E/MAEpYdU-93E/1/s.jpg',
    'https://media-public.canva.com/wJCBk/MAEpYRwJCBk/1/s.jpg',
    'https://media-public.canva.com/cVyko/MAEpYQcVyko/1/s.jpg',
    'https://media-public.canva.com/q71T0/MAEpYTq71T0/1/s.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 24),
      height: 600, // Fixed height for the collage
      color: const Color(0xFFAABEC6), // Muted Blue-Grey Background
      child: Stack(
        children: [
          // 2. Right Tall Image (Main)
          Positioned(
            top: 40,
            right: 0,
            bottom: 40,
            width: MediaQuery.of(context).size.width * 0.45,
            child: _buildImageTile(_images[0], border: false),
          ),

          // 3. Central/Left Images (Overlapping Collage)

          // Middle-Left Image (Framed)
          Positioned(
            top: 140,
            left: 20,
            width: MediaQuery.of(context).size.width * 0.4,
            height: 220,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 8),
              ),
              child: _buildImageTile(_images[1], border: false),
            ),
          ),

          // Bottom-Left Image (Detail)
          Positioned(
            bottom: 120,
            left: 40,
            width: MediaQuery.of(context).size.width * 0.35,
            height: 180,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 8),
              ),
              child: _buildImageTile(_images[2], border: false),
            ),
          ),

          // 4. Bottom Text Strip
          Positioned(
            bottom: 40,
            left: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              color: const Color(0xFF4A4A4A), // Dark Grey
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'High Fashion Costume',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Styling For All',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 4. Text Header (Moved to Front)
          Positioned(
            top: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Styling Tips',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1.0,
                  ),
                ),
                Transform.translate(
                  offset: const Offset(10, -10),
                  child: Text(
                    'Fashion',
                    style: GoogleFonts.greatVibes(
                      fontSize: 56,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageTile(String url, {bool border = true}) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(color: Colors.grey[300]),
      errorWidget: (context, url, err) => Container(color: Colors.grey[300]),
    );
  }
}
