import 'package:flutter/foundation.dart';
import '../../data/models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _items = [
    CartItem(
      id: '1',
      productName: 'iPhone 14 Pro Max',
      price: 42999,
      quantity: 1,
      imageUrl: '',
    ),
    CartItem(
      id: '2',
      productName: 'Nike Air Max',
      price: 1299,
      quantity: 2,
      imageUrl: '',
    ),
  ];

  List<CartItem> get items => _items;

  double get subtotal {
    return _items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  double get shipping => _items.isEmpty ? 0 : 29.99;
  
  double get total => subtotal + shipping;

  get itemCount => null;

  void updateQuantity(String itemId, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(itemId);
      return;
    }
    
    final index = _items.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      _items[index].quantity = newQuantity;
      notifyListeners();
    }
  }

  void removeFromCart(String itemId) {
    _items.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }

  void addToCart(CartItem item) {
    final existingIndex = _items.indexWhere((i) => i.id == item.id);
    if (existingIndex != -1) {
      _items[existingIndex].quantity += item.quantity;
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}