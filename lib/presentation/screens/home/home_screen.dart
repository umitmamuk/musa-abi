import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/product_video.dart';
import 'widgets/video_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  
  final List<ProductVideo> videos = [
    ProductVideo(
      id: '1',
      productName: 'iPhone 14 Pro Max',
      price: '42.999',
      discount: '15%',
      seller: 'TechStore',
      likes: 1250,
      comments: 89,
      description: 'En yeni iPhone teknolojisi',
    ),
    ProductVideo(
      id: '2',
      productName: 'Nike Air Max',
      price: '1.299',
      discount: '25%',
      seller: 'SportWorld',
      likes: 850,
      comments: 45,
      description: 'Konforlu spor ayakkabı',
    ),
    ProductVideo(
      id: '3',
      productName: 'MacBook Air M2',
      price: '28.999',
      discount: '10%',
      seller: 'AppleStore',
      likes: 2100,
      comments: 156,
      description: 'Yeni nesil laptop',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Row(
              children: [
                const Text(
                  'Snapal',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Ürün ara...',
                        prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Stack(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_outlined),
                      color: AppColors.textPrimary,
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Video Feed
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: videos.length,
              itemBuilder: (context, index) {
                return VideoCard(video: videos[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}