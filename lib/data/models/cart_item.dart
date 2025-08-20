// ========== data/models/cart_item.dart ==========
class CartItem {
  final String id;
  final String productName;
  final double price;
  int quantity;
  final String imageUrl;

  CartItem({
    required this.id,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });
}