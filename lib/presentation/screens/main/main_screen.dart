import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../providers/user_provider.dart';
import '../home/home_screen.dart';
import '../explore/explore_screen.dart';
import '../categories/categories_screen.dart';
import '../cart/cart_screen.dart';
import '../profile/profile_screen.dart';
import '../seller/seller_panel_screen.dart';
import '../../widgets/add_video_bottom_sheet.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Müşteri ekranları
  final List<Widget> _customerScreens = [
    const HomeScreen(),         // Ana Sayfa
    const ExploreScreen(),      // Keşfet
    CategoriesScreen(),         // Kategoriler  
    const CartScreen(),         // Sepet
    const ProfileScreen(),      // Profil
  ];

  // Satıcı ekranları
  final List<Widget> _sellerScreens = [
    const HomeScreen(),         // Ana Sayfa
    const ExploreScreen(),      // Keşfet
    const SellerPanelScreen(),  // Satıcı Paneli
    const CartScreen(),         // Siparişler
    const ProfileScreen(),      // Profil
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final isSeller = userProvider.isSeller;
        final screens = isSeller ? _sellerScreens : _customerScreens;
        
        return Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: screens,
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                // + butonu için boş index kontrolü
                if (!isSeller || index != 2) {
                  setState(() => _currentIndex = index);
                }
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.textSecondary,
              elevation: 0,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              iconSize: 28,
              items: isSeller ? _getSellerNavItems() : _getCustomerNavItems(),
            ),
          ),
          // + Butonu sadece satıcılar için
          floatingActionButton: isSeller ? _buildAddButton() : null,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }

  // Müşteri bottom navigation items
  List<BottomNavigationBarItem> _getCustomerNavItems() {
    return const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined, size: 28),
        activeIcon: Icon(Icons.home, size: 28),
        label: 'Ana Sayfa',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.explore_outlined, size: 28),
        activeIcon: Icon(Icons.explore, size: 28),
        label: 'Keşfet',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.category_outlined, size: 28),
        activeIcon: Icon(Icons.category, size: 28),
        label: 'Kategoriler',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart_outlined, size: 28),
        activeIcon: Icon(Icons.shopping_cart, size: 28),
        label: 'Sepet',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person_outline, size: 28),
        activeIcon: Icon(Icons.person, size: 28),
        label: 'Profil',
      ),
    ];
  }

  // Satıcı bottom navigation items (+ butonu için boş alan)
  List<BottomNavigationBarItem> _getSellerNavItems() {
    return const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined, size: 28),
        activeIcon: Icon(Icons.home, size: 28),
        label: 'Ana Sayfa',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.explore_outlined, size: 28),
        activeIcon: Icon(Icons.explore, size: 28),
        label: 'Keşfet',
      ),
      // Boş alan - + butonu için
      BottomNavigationBarItem(
        icon: SizedBox(width: 28, height: 28),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.store_outlined, size: 28),
        activeIcon: Icon(Icons.store, size: 28),
        label: 'Mağazam',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person_outline, size: 28),
        activeIcon: Icon(Icons.person, size: 28),
        label: 'Profil',
      ),
    ];
  }

  // Satıcı için + butonu
  Widget _buildAddButton() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.getGradient(),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: () => _showAddVideoBottomSheet(context),
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  void _showAddVideoBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) => const AddVideoBottomSheet(),
    );
  }
}