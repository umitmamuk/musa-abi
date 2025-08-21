import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../home/home_screen.dart';
import '../categories/categories_screen.dart';
import '../cart/cart_screen.dart';
import '../profile/profile_screen.dart';
import '../../widgets/add_video_bottom_sheet.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    CategoriesScreen(),
    const CartScreen(),
    const ProfileScreen(),
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
          iconSize: 28, // İkon boyutu artırıldı
          items: [
            BottomNavigationBarItem(
              icon: _currentIndex == 0 
                ? const AppLogoMiniLarge()  // Büyük logo
                : const Icon(Icons.home_outlined, size: 28),
              activeIcon: const AppLogoMiniLarge(),
              label: 'Ana Sayfa',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined, size: 28),
              activeIcon: Icon(Icons.category, size: 28),
              label: 'Kategoriler',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined, size: 28),
              activeIcon: Icon(Icons.shopping_cart, size: 28),
              label: 'Sepet',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 28),
              activeIcon: Icon(Icons.person, size: 28),
              label: 'Profil',
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              AppColors.primary,
              AppColors.primary.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _showAddVideoBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const AddVideoBottomSheet(),
    );
  }
}

// Büyük Mini Logo Widget'ı
class AppLogoMiniLarge extends StatelessWidget {
  const AppLogoMiniLarge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo_mini.png',
      width: 32,  // 24'ten 32'ye çıkarıldı
      height: 32,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        // Görsel yüklenemezse fallback logo göster
        return Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.primary.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
              'S',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}