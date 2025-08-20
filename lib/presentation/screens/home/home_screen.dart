import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/product_video.dart';
import '../../widgets/app_logo.dart';
import '../search/search_screen.dart';
import '../messages/messages_screen.dart';
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
            padding: EdgeInsets.fromLTRB(
              16, 
              MediaQuery.of(context).padding.top + 8, 
              16, 
              16
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Arama Butonu (Sol)
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.search, size: 26),
                  color: AppColors.textPrimary,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                
                // Logo (Orta)
                const Expanded(
                  child: Center(
                    child: AppLogo(size: 32),
                  ),
                ),
                
                // Sağ taraf butonlar
                Row(
                  children: [
                    // Mesajlar
                    Stack(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MessagesScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.message_outlined, size: 24),
                          color: AppColors.textPrimary,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    // Bildirimler
                    Stack(
                      children: [
                        IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Bildirimler açılıyor...'),
                                backgroundColor: AppColors.primary,
                              ),
                            );
                          },
                          icon: const Icon(Icons.notifications_outlined, size: 24),
                          color: AppColors.textPrimary,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
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