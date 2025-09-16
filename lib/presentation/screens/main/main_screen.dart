import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../home/home_screen.dart';
import '../explore/explore_screen.dart';
import '../categories/categories_screen.dart';
import '../cart/cart_screen.dart';
import '../profile/profile_screen.dart';
import '../../widgets/app_logo.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),         // Ana Sayfa (Reels/Video)
    const ExploreScreen(),      // Keşfet
    CategoriesScreen(),   // Kategoriler
    const CartScreen(),         // Sepet
    const ProfileScreen(),      // Profil
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
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
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          elevation: 0,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          iconSize: 26,
          items: [
            BottomNavigationBarItem(
              icon: _currentIndex == 0 
                ? const AppLogoIcon(size: 26)
                : const Icon(Icons.home_outlined, size: 26),
              activeIcon: const AppLogoIcon(size: 26),
              label: 'Ana Sayfa',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined, size: 26),
              activeIcon: Icon(Icons.explore, size: 26),
              label: 'Keşfet',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined, size: 26),
              activeIcon: Icon(Icons.category, size: 26),
              label: 'Kategoriler',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined, size: 26),
              activeIcon: Icon(Icons.shopping_cart, size: 26),
              label: 'Sepet',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 26),
              activeIcon: Icon(Icons.person, size: 26),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}