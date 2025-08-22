import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/product_video.dart';
import '../search/search_screen.dart';
import '../product/product_detail_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedCategory = 'Tümü';
  
  // Kategoriler
  final List<String> categories = [
    'Tümü',
    'Örnekuri',
    'Moda', 
    'Elektronik',
    'Ev & Yaşam',
    'Spor',
    'Kozmetik',
  ];

  // Örnek ürünler - farklı yükseklikler için
  final List<Map<String, dynamic>> products = [
    {
      'id': '1',
      'name': 'Örnek ürün tanımı',
      'price': '99.99',
      'image': 'product1',
      'height': 200.0,
      'hasVideo': true,
      'seller': 'TechStore',
      'likes': 1250,
    },
    {
      'id': '2', 
      'name': 'Örnek ürün tanımı',
      'price': '99.99',
      'image': 'product2',
      'height': 250.0,
      'hasVideo': true,
      'seller': 'FashionHub',
      'likes': 890,
    },
    {
      'id': '3',
      'name': 'Örnek ürün tanımı',
      'price': '99.99',
      'image': 'product3',
      'height': 180.0,
      'hasVideo': false,
      'seller': 'HomeDecor',
      'likes': 456,
    },
    {
      'id': '4',
      'name': 'Örnek ürün tanımı',
      'price': '99.99',
      'image': 'product4',
      'height': 220.0,
      'hasVideo': true,
      'seller': 'SportWorld',
      'likes': 2100,
    },
    {
      'id': '5',
      'name': 'Örnek ürün tanımı',
      'price': '99.99',
      'image': 'product5',
      'height': 260.0,
      'hasVideo': false,
      'seller': 'BeautyStore',
      'likes': 678,
    },
    {
      'id': '6',
      'name': 'Örnek ürün tanımı',
      'price': '99.99',
      'image': 'product6',
      'height': 190.0,
      'hasVideo': true,
      'seller': 'GadgetShop',
      'likes': 3400,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Üst Arama Çubuğu
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.search,
                        color: AppColors.textSecondary,
                        size: 22,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Ara',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: AppColors.textSecondary,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Kategori Filtreleri
            Container(
              height: 45,
              color: Colors.white,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedCategory == categories[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = categories[index];
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8, bottom: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? AppColors.primary
                            : AppColors.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected 
                              ? AppColors.primary
                              : AppColors.border,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          categories[index],
                          style: TextStyle(
                            color: isSelected 
                                ? Colors.white
                                : AppColors.textSecondary,
                            fontWeight: isSelected 
                                ? FontWeight.w600
                                : FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Pinterest Tarzı Grid
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  // Yenileme işlemi
                  await Future.delayed(const Duration(seconds: 1));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: MasonryGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    itemCount: products.length * 3, // Daha fazla ürün için
                    itemBuilder: (context, index) {
                      final product = products[index % products.length];
                      return _buildProductCard(product, index);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product, int index) {
    // Farklı yükseklikler için random değerler
    final heights = [180.0, 220.0, 250.0, 200.0, 280.0, 160.0];
    final height = heights[index % heights.length];
    
    return GestureDetector(
      onTap: () {
        // Ürün detay sayfasına git
        final video = ProductVideo(
          id: product['id'],
          productName: product['name'],
          price: product['price'],
          discount: '15%',
          seller: product['seller'],
          likes: product['likes'],
          comments: 45,
          description: 'Ürün açıklaması',
        );
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(video: video),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ürün Görseli/Video
            Stack(
              children: [
                Container(
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue.shade100,
                        Colors.purple.shade100,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      product['hasVideo'] ? Icons.play_circle_filled : Icons.image,
                      size: 50,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),
                // Video badge
                if (product['hasVideo'])
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 12,
                          ),
                          SizedBox(width: 2),
                          Text(
                            'Video',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                // Beğeni sayısı
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatNumber(product['likes']),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Ürün Bilgileri
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₺${product['price']}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        child: const Icon(
                          Icons.store,
                          size: 12,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          product['seller'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}