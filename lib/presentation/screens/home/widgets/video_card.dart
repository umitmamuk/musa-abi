import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/product_video.dart';
import '../../../../data/models/cart_item.dart';
import '../../../providers/cart_provider.dart';
// import 'package:share_plus/share_plus.dart'; // pubspec.yaml'a eklenmeli

class VideoCard extends StatefulWidget {
  final ProductVideo video;
  final bool isPlaying;

  const VideoCard({
    Key? key, 
    required this.video,
    this.isPlaying = false,
  }) : super(key: key);

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  bool isLiked = false;
  bool showDetails = true; // Ürün detaylarını göster/gizle

  @override
  void didUpdateWidget(VideoCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying && !oldWidget.isPlaying) {
      // Video oynatmaya başla
      _playVideo();
    } else if (!widget.isPlaying && oldWidget.isPlaying) {
      // Video oynatmayı durdur
      _pauseVideo();
    }
  }

  void _playVideo() {
    // Video oynatma mantığı buraya gelecek
    debugPrint('Video ${widget.video.id} oynatılıyor...');
  }

  void _pauseVideo() {
    // Video duraklatma mantığı buraya gelecek
    debugPrint('Video ${widget.video.id} duraklatıldı');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Tıklandığında detayları göster/gizle (video oynatmaya devam et)
        setState(() {
          showDetails = !showDetails;
        });
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple.shade400,
              Colors.blue.shade600,
              Colors.teal.shade400,
            ],
          ),
        ),
        child: Stack(
          children: [
            // Video placeholder (Tam ekran)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.isPlaying ? Icons.play_circle_filled : Icons.pause_circle_filled,
                    size: 80,
                    color: Colors.white.withOpacity(0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.isPlaying ? 'Oynatılıyor...' : 'Duraklatıldı',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            
            // Sağ taraf butonları (Her zaman görünür)
            Positioned(
              right: 12,
              bottom: 80,
              child: Column(
                children: [
                  _buildActionButton(
                    icon: isLiked ? Icons.favorite : Icons.favorite_border,
                    label: widget.video.likes.toString(),
                    onTap: () => setState(() => isLiked = !isLiked),
                    color: isLiked ? Colors.red : Colors.white,
                  ),
                  const SizedBox(height: 20),
                  _buildActionButton(
                    icon: Icons.comment,
                    label: widget.video.comments.toString(),
                    onTap: () => _showCommentsBottomSheet(context),
                  ),
                  const SizedBox(height: 20),
                  _buildActionButton(
                    icon: Icons.share,
                    label: 'Paylaş',
                    onTap: () => _shareProduct(),
                  ),
                  const SizedBox(height: 20),
                  _buildActionButton(
                    icon: Icons.store,
                    label: 'Mağaza',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            
            // Alt bilgi paneli (Göster/Gizle)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left: 0,
              right: 80,
              bottom: showDetails ? 0 : -200,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.video.productName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          '₺${widget.video.price}',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 6),
                        if (widget.video.discount != '0%')
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              widget.video.discount,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.video.description,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 32,
                      child: ElevatedButton(
                        onPressed: () => _addToCart(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                        ),
                        child: const Text(
                          'Sepete Ekle',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color color = Colors.white,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _addToCart(BuildContext context) {
    final cartProvider = context.read<CartProvider>();
    
    final cartItem = CartItem(
      id: widget.video.id,
      productName: widget.video.productName,
      price: double.parse(widget.video.price.replaceAll('.', '')),
      quantity: 1,
      imageUrl: '',
    );
    
    cartProvider.addToCart(cartItem);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.video.productName} sepete eklendi!'),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _shareProduct() {
    // Share Plus paketi ile paylaşım
     final String() = '${widget.video.productName} - ₺${widget.video.price}\n'
        '${widget.video.description}\n\n'
        'Snapal uygulamasında keşfettim! 🛍️';
    
    // Share.share(shareText); // share_plus paketi eklendikten sonra
    
    // Geçici olarak SnackBar göster
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Paylaşılıyor: ${widget.video.productName}'),
        backgroundColor: AppColors.info,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _showCommentsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Yorumlar',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: Text(
                      'U${index + 1}',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text('Kullanıcı ${index + 1}'),
                  subtitle: const Text('Harika bir ürün! Çok beğendim.'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}