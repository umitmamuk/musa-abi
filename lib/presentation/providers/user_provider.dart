import 'package:flutter/foundation.dart';
import '../../data/models/user.dart';

class UserProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _currentUser != null;
  bool get isSeller => _currentUser?.isSeller ?? false;
  bool get isCustomer => _currentUser?.isCustomer ?? false;

  // Varsayılan kullanıcı oluştur (test için)
  UserProvider() {
    // Başlangıçta müşteri olarak giriş yap
    _initializeUser();
  }

  void _initializeUser() {
    _currentUser = User(
      id: '1',
      name: 'Mehmet Musa Aydın',
      email: 'mehmet@example.com',
      username: 'mmusaaydin',
      userType: UserType.customer, // Başlangıçta müşteri
      createdAt: DateTime.now(),
      followers: 1200,
      following: 456,
      likes: 5800,
    );
    notifyListeners();
  }

  // Kullanıcı tipini değiştir (Müşteri <-> Satıcı)
  void switchUserType() {
    if (_currentUser == null) return;

    _isLoading = true;
    notifyListeners();

    // Simüle edilmiş gecikme
    Future.delayed(const Duration(seconds: 1), () {
      if (_currentUser!.isSeller) {
        // Satıcıdan müşteriye geç
        _currentUser = _currentUser!.changeUserType(UserType.customer);
      } else {
        // Müşteriden satıcıya geç
        _currentUser = User(
          id: _currentUser!.id,
          name: _currentUser!.name,
          email: _currentUser!.email,
          username: _currentUser!.username,
          profileImage: _currentUser!.profileImage,
          userType: UserType.seller,
          createdAt: _currentUser!.createdAt,
          // Satıcı bilgileri ekle
          storeName: 'TechStore',
          storeDescription: 'En kaliteli teknoloji ürünleri',
          rating: 4.8,
          totalSales: 156,
          totalProducts: 28,
          isVerified: true,
          followers: _currentUser!.followers,
          following: _currentUser!.following,
          likes: _currentUser!.likes,
        );
      }
      
      _isLoading = false;
      notifyListeners();
    });
  }

  // Kullanıcı girişi
  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    // API çağrısı simülasyonu
    await Future.delayed(const Duration(seconds: 2));

    _currentUser = User(
      id: '1',
      name: 'Test Kullanıcı',
      email: email,
      username: 'testuser',
      userType: UserType.customer,
      createdAt: DateTime.now(),
    );

    _isLoading = false;
    notifyListeners();
  }

  // Kullanıcı çıkışı
  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  // Satıcı olarak kayıt
  Future<void> registerAsSeller({
    required String storeName,
    required String storeDescription,
  }) async {
    if (_currentUser == null || _currentUser!.isSeller) return;

    _isLoading = true;
    notifyListeners();

    // API çağrısı simülasyonu
    await Future.delayed(const Duration(seconds: 2));

    _currentUser = User(
      id: _currentUser!.id,
      name: _currentUser!.name,
      email: _currentUser!.email,
      username: _currentUser!.username,
      profileImage: _currentUser!.profileImage,
      userType: UserType.seller,
      createdAt: _currentUser!.createdAt,
      storeName: storeName,
      storeDescription: storeDescription,
      rating: 0.0,
      totalSales: 0,
      totalProducts: 0,
      isVerified: false,
      followers: _currentUser!.followers,
      following: _currentUser!.following,
      likes: _currentUser!.likes,
    );

    _isLoading = false;
    notifyListeners();
  }
}