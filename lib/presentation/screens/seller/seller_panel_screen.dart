import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'seller_dashboard_screen.dart';
import 'seller_products_screen.dart';
import 'seller_orders_screen.dart';
import 'seller_messages_screen.dart';

class SellerPanelScreen extends StatefulWidget {
  const SellerPanelScreen({Key? key}) : super(key: key);

  @override
  State<SellerPanelScreen> createState() => _SellerPanelScreenState();
}

class _SellerPanelScreenState extends State<SellerPanelScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const SellerDashboardScreen(),
    const SellerProductsScreen(),
    const SellerOrdersScreen(),
    const SellerMessagesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Panel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Ürünler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Siparişler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Mesajlar',
          ),
        ],
      ),
    );
  }
}