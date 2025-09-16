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
  int currentVideoIndex = 0;
  
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
  void initState() {
    super.initState();
    // Sayfa değişikliklerini dinle
    _pageController.addListener(() {
      int newIndex = _pageController.page?.round() ?? 0;
      if (newIndex != currentVideoIndex) {
        setState(() {
          currentVideoIndex = newIndex;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Video Feed (Tam ekran)
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: videos.length,
            itemBuilder: (context, index) {
              return VideoCard(
                video: videos[index],
                isPlaying: index == currentVideoIndex, // Otomatik oynatma için
              );
            },
          ),
          
          // Minimal Header (Üstte sabit)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                12, 
                MediaQuery.of(context).padding.top + 4, 
                12, 
                8
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    icon: const Icon(Icons.search, size: 24),
                    color: Colors.white,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 40,
                      minHeight: 40,
                    ),
                  ),
                  
                  // Logo (Orta) - Küçültüldü
                  const AppLogoIcon(size: 28),
                  
                  // Mesajlar (Sağ)
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
                        icon: const Icon(Icons.message_outlined, size: 22),
                        color: Colors.white,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          minHeight: 40,
                        ),
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}