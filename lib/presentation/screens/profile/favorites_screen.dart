import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  // Örnek favori ürünler
  final List<FavoriteProduct> favorites = [
    FavoriteProduct(
      id: '1',
      name: 'iPhone 14 Pro Max 256GB',
      price: 42999,
      oldPrice: 45999,
      discount: 7,
      rating: 4.8,
      reviews: 234,
      image: '📱',
      seller: 'TechStore',
      isInStock: true,
    ),
    FavoriteProduct(
      id: '2',
      name: 'Nike Air Max 270',
      price: 1299,
      oldPrice: 1599,
      discount: 19,
      rating: 4.6,
      reviews: 89,
      image: '👟',
      seller: 'SportWorld',
      isInStock: true,
    ),
    FavoriteProduct(
      id: '3',
      name: 'MacBook Air M2 13"',
      price: 28999,
      oldPrice: 32999,
      discount: 12,
      rating: 4.9,
      reviews: 567,
      image: '💻',
      seller: 'AppleStore',
      isInStock: false,
    ),
    FavoriteProduct(
      id: '4',
      name: 'Sony WH-1000XM4',
      price: 3499,
      oldPrice: 4299,
      discount: 19,
      rating: 4.7,
      reviews: 1203,
      image: '🎧',
      seller: 'SoundHub',
      isInStock: true,
    ),
    FavoriteProduct(
      id: '5',
      name: 'Zara Oversize Ceket',
      price: 899,
      oldPrice: 1199,
      discount: 25,
      rating: 4.3,
      reviews: 45,
      image: '🧥',
      seller: 'FashionPoint',
      isInStock: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Favorilerim'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        actions: [
          if (favorites.isNotEmpty)
            TextButton(
              onPressed: _clearAllFavorites,
              child: const Text(
                'Temizle',
                style: TextStyle(color: AppColors.error),
              ),
            ),
        ],
      ),
      body: favorites.isEmpty
          ? _buildEmptyState()
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.65,
              ),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final product = favorites[index];
                return _buildFavoriteCard(product);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 80,
            color: AppColors.textSecondary.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          const Text(
            'Henüz favori ürününüz yok',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Beğendiğiniz ürünleri favorilere ekleyin',
            style: TextStyle(
              color: AppColors.textLight,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text('Alışverişe Başla'),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteCard(FavoriteProduct product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ürün görseli ve favori butonu
          Stack(
            children: [
              Container(
                height: 140,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Center(
                  child: Text(
                    product.image,
                    style: const TextStyle(fontSize: 50),
                  ),
                ),
              ),
              // İndirim etiketi
              if (product.discount > 0)
                Positioned(
                  left: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '-%${product.discount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              // Favori butonu
              Positioned(
                right: 8,
                top: 8,
                child: GestureDetector(
                  onTap: () => _removeFavorite(product),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.favorite,
                      size: 18,
                      color: AppColors.error,
                    ),
                  ),
                ),
              ),
              // Stok durumu
              if (!product.isInStock)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                    ),
                    child: const Text(
                      'Stokta Yok',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          // Ürün bilgileri
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.amber.shade600,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            product.rating.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            ' (${product.reviews})',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (product.oldPrice > product.price)
                        Text(
                          '₺${product.oldPrice.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Text(
                        '₺${product.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Sepete ekle butonu
          Container(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: double.infinity,
              height: 32,
              child: ElevatedButton(
                onPressed: product.isInStock ? () => _addToCart(product) : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: const Text(
                  'Sepete Ekle',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _removeFavorite(FavoriteProduct product) {
    setState(() {
      favorites.remove(product);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} favorilerden kaldırıldı'),
        action: SnackBarAction(
          label: 'Geri Al',
          onPressed: () {
            setState(() {
              favorites.add(product);
            });
          },
        ),
      ),
    );
  }

  void _addToCart(FavoriteProduct product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} sepete eklendi'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _clearAllFavorites() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tüm Favorileri Temizle'),
        content: const Text('Tüm favori ürünlerinizi kaldırmak istediğinize emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                favorites.clear();
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Temizle'),
          ),
        ],
      ),
    );
  }
}

class FavoriteProduct {
  final String id;
  final String name;
  final double price;
  final double oldPrice;
  final int discount;
  final double rating;
  final int reviews;
  final String image;
  final String seller;
  final bool isInStock;

  FavoriteProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.rating,
    required this.reviews,
    required this.image,
    required this.seller,
    required this.isInStock,
  });
}