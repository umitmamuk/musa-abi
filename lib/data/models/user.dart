class User {
  final String id;
  final String name;
  final String email;
  final String username;
  final String? profileImage;
  final UserType userType;
  final DateTime createdAt;
  
  // Satıcı bilgileri
  final String? storeName;
  final String? storeDescription;
  final double? rating;
  final int? totalSales;
  final int? totalProducts;
  final bool? isVerified;
  
  // Takipçi bilgileri
  final int followers;
  final int following;
  final int likes;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    this.profileImage,
    required this.userType,
    required this.createdAt,
    this.storeName,
    this.storeDescription,
    this.rating,
    this.totalSales,
    this.totalProducts,
    this.isVerified,
    this.followers = 0,
    this.following = 0,
    this.likes = 0,
  });

  bool get isSeller => userType == UserType.seller;
  bool get isCustomer => userType == UserType.customer;
  
  // Kullanıcı tipini değiştir
  User changeUserType(UserType newType) {
    return User(
      id: id,
      name: name,
      email: email,
      username: username,
      profileImage: profileImage,
      userType: newType,
      createdAt: createdAt,
      storeName: storeName,
      storeDescription: storeDescription,
      rating: rating,
      totalSales: totalSales,
      totalProducts: totalProducts,
      isVerified: isVerified,
      followers: followers,
      following: following,
      likes: likes,
    );
  }
}

enum UserType {
  customer,
  seller,
}