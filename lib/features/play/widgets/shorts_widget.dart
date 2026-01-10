import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ShortsWidget extends StatelessWidget {
  final String videoId; // In a real app, this would be a URL
  final String username;
  final String description;
  final String views;
  final String profileImage;
  final int productCount;
  final bool isLiked;

  const ShortsWidget({
    super.key,
    required this.videoId,
    required this.username,
    required this.description,
    required this.views,
    required this.profileImage,
    required this.productCount,
    this.isLiked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Video/Image Background
        Positioned.fill(
          child: CachedNetworkImage(
            imageUrl: videoId, // Using Image URL for prototype
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(color: Colors.black),
            errorWidget: (context, url, _) => Container(color: Colors.grey),
          ),
        ),

        // 2. Gradient Overlay for Text Readability
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black87],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.6, 1.0],
              ),
            ),
          ),
        ),

        // 3. Right Action Bar (Like, Share, Comment, Mute)
        Positioned(
          right: 16,
          bottom: 100,
          child: Column(
            children: [
              _buildActionButton(
                isLiked ? Icons.favorite : Icons.favorite_border,
                '1.3K',
                color: isLiked ? Colors.red : Colors.white,
              ),
              const SizedBox(height: 20),
              _buildActionButton(Icons.share, 'Share'),
              const SizedBox(height: 20),
              _buildActionButton(Icons.comment, '668'),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.volume_off,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ),

        // 4. Bottom Info Overlay
        Positioned(
          left: 16,
          bottom: 24,
          right: 80, // Leave space for action bar
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // User Info
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(profileImage),
                    radius: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Follow',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Description
              Text(
                description,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 12),

              // View Products Button
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$productCount Products',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // 5. Views Count (Top Right)
        Positioned(
          top: 40,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                const Icon(Icons.remove_red_eye, color: Colors.white, size: 14),
                const SizedBox(width: 4),
                Text(
                  views,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String label, {
    Color color = Colors.white,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 30),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
