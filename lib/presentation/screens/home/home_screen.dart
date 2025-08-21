import 'package:flutter/material.dart';
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
    12, 
    MediaQuery.of(context).padding.top + 4, 
    12, 
    12
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
  child: SizedBox(
    height: 56,
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
          icon: const Icon(Icons.search, size: 28),
          color: const Color(0xFF6366F1), // Logonuzun rengi
          padding: const EdgeInsets.all(8),
        ),
        
        // Logo (Orta) - TAM LOGONUZ
        const Expanded(
          child: Center(
            child: AppLogoHeader(), // Tam logo kullanımı
          ),
        ),
        
        // Sağ taraf butonlar
        Row(
          children: [
            // Mesajlar
            Stack(
              alignment: Alignment.center,
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
                  icon: const Icon(Icons.message_outlined, size: 26),
                  color: const Color(0xFF6366F1),
                  padding: const EdgeInsets.all(8),
                ),
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF6366F1),
                          Color(0xFF06B6D4),
                        ],
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
            // Bildirimler
            Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Bildirimler açılıyor...'),
                        backgroundColor: Color(0xFF6366F1),
                      ),
                    );
                  },
                  icon: const Icon(Icons.notifications_outlined, size: 26),
                  color: const Color(0xFF6366F1),
                  padding: const EdgeInsets.all(8),
                ),
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    width: 10,
                    height: 10,
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