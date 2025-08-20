// ========== data/models/product_video.dart ==========

class ProductVideo {
  final String id;
  final String productName;
  final String price;
  final String discount;
  final String seller;
  final int likes;
  final int comments;
  final String description;

  const ProductVideo({
    required this.id,
    required this.productName,
    required this.price,
    required this.discount,
    required this.seller,
    required this.likes,
    required this.comments,
    required this.description,
  });
}