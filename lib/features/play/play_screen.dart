import 'package:flutter/material.dart';
import 'widgets/shorts_widget.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  final PageController _pageController = PageController();

  // Mock Data for Reels
  final List<Map<String, dynamic>> _reels = [
    {
      'videoId':
          'https://rukminim1.flixcart.com/image/850/1000/xif0q/t-shirt/t/e/0/l-st-theboys-black-smartees-original-imagnqszzzzyuzru.jpeg?q=90', // T-Shirt Look
      'username': 'Tom',
      'profileImage': 'https://i.pravatar.cc/150?u=a042581f4e29026704d',
      'description': 'Fit prep for my moment #eventready #fashion',
      'views': '5L',
      'productCount': 8,
      'isLiked': true,
    },
    {
      'videoId':
          'https://media-public.canva.com/cVyko/MAEpYQcVyko/1/s.jpg', // Jeans Look
      'username': 'Kushal Raj B',
      'profileImage': 'https://i.pravatar.cc/150?u=visited',
      'description': 'When I forgot to pack slippers 😂 #trip #funny',
      'views': '1.7K',
      'productCount': 4,
      'isLiked': false,
    },
    {
      'videoId':
          'https://media-public.canva.com/U-93E/MAEpYdU-93E/1/s.jpg', // Shirt Look
      'username': 'Moin Bhelekar',
      'profileImage': 'https://i.pravatar.cc/150?u=moin',
      'description': 'Am I The Only One? Look Best, Shop Now!',
      'views': '4.9L',
      'productCount': 6,
      'isLiked': false,
    },
    // Added 20+ items
    {
      'videoId': 'https://media-public.canva.com/wJCBk/MAEpYRwJCBk/1/s.jpg',
      'username': 'Ethnic Vibes',
      'profileImage': 'https://i.pravatar.cc/150?u=ethnic',
      'description': 'Traditional elegance for festivals #sareelove',
      'views': '2.2L',
      'productCount': 3,
      'isLiked': true,
    },
    {
      'videoId': "https://media-public.canva.com/cVyko/MAEpYQcVyko/1/s.jpg",
      'username': 'Sneaker Head',
      'profileImage': 'https://i.pravatar.cc/150?u=sneaker',
      'description': 'New kicks in town! check em out #sneakers',
      'views': '8.5K',
      'productCount': 1,
      'isLiked': false,
    },
    {
      'videoId': "https://media-public.canva.com/q71T0/MAEpYTq71T0/1/s.jpg",
      'username': 'Time Keeper',
      'profileImage': 'https://i.pravatar.cc/150?u=watch',
      'description': 'Classy timepieces for every occasion #watch',
      'views': '12K',
      'productCount': 2,
      'isLiked': true,
    },
    {
      'videoId': "https://media-public.canva.com/U-93E/MAEpYdU-93E/1/s.jpg",
      'username': 'Fitness Freak',
      'profileImage': 'https://i.pravatar.cc/150?u=gym',
      'description': 'Gym wear that breathes #fitness #gym',
      'views': '30K',
      'productCount': 5,
      'isLiked': false,
    },
    {
      'videoId': "https://media-public.canva.com/wJCBk/MAEpYRwJCBk/1/s.jpg",
      'username': 'Audiophile',
      'profileImage': 'https://i.pravatar.cc/150?u=audio',
      'description': 'Feel the bass! 🎧 #music #headphones',
      'views': '1.1M',
      'productCount': 1,
      'isLiked': true,
    },
    {
      'videoId': "https://media-public.canva.com/q71T0/MAEpYTq71T0/1/s.jpg",
      'username': 'Tech Reviewer',
      'profileImage': 'https://i.pravatar.cc/150?u=tech',
      'description': 'Unboxing the new iPhone 13 Pro Max #tech',
      'views': '5.5L',
      'productCount': 1,
      'isLiked': true,
    },
    {
      'videoId': "https://media-public.canva.com/cVyko/MAEpYQcVyko/1/s.jpg",
      'username': 'Summer Styles',
      'profileImage': 'https://i.pravatar.cc/150?u=summer',
      'description': 'Get ready for the sun! 😎 #sunglasses',
      'views': '8K',
      'productCount': 2,
      'isLiked': false,
    },
    {
      'videoId': "https://media-public.canva.com/cVyko/MAEpYQcVyko/1/s.jpg",
      'username': 'Travel Bug',
      'profileImage': 'https://i.pravatar.cc/150?u=travel',
      'description': 'Best backpack for weekend getaways 🎒 #travel',
      'views': '15K',
      'productCount': 1,
      'isLiked': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: _reels.length,
            itemBuilder: (context, index) {
              final reel = _reels[index];
              return ShortsWidget(
                videoId: reel['videoId'],
                username: reel['username'],
                profileImage: reel['profileImage'],
                description: reel['description'],
                views: reel['views'],
                productCount: reel['productCount'],
                isLiked: reel['isLiked'],
              );
            },
          ),
          Positioned(
            top: 40,
            left: 20,
            child: Semantics(
              label: 'Go back',
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                  shadows: [
                    Shadow(
                      color: Colors.black45,
                      offset: Offset(0, 1),
                      blurRadius: 3,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
