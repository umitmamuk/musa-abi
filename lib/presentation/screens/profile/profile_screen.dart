import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../providers/user_provider.dart';
import '../seller/seller_panel_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final user = userProvider.currentUser;
        final isSeller = userProvider.isSeller;
        
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              'Profil',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            foregroundColor: AppColors.textPrimary,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Profil Bilgileri
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: AppColors.primary.withOpacity(0.1),
                            child: Text(
                              user?.name.substring(0, 2).toUpperCase() ?? 'U',
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (isSeller)
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                                child: const Icon(
                                  Icons.store,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user?.name ?? 'Kullanıcı',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '@${user?.username ?? 'username'}',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      if (isSeller) ...[
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            gradient: AppColors.getGradient(),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.verified,
                                size: 14,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                user?.storeName ?? 'Satıcı',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 16),
                      
                      // Rol Değiştirme Butonu
                      ElevatedButton.icon(
                        onPressed: userProvider.isLoading 
                            ? null 
                            : () => _showRoleSwitchDialog(context, userProvider),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isSeller ? AppColors.warning : AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        icon: Icon(
                          isSeller ? Icons.person : Icons.store,
                          size: 20,
                        ),
                        label: Text(
                          isSeller ? 'Müşteri Moduna Geç' : 'Satıcı Moduna Geç',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatColumn('Takipçi', '${user?.followers ?? 0}'),
                          _buildStatColumn('Takip', '${user?.following ?? 0}'),
                          _buildStatColumn('Beğeni', '${user?.likes ?? 0}'),
                          if (isSeller)
                            _buildStatColumn('Satış', '${user?.totalSales ?? 0}'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                
                // Menü Seçenekleri
                if (!isSeller) ...[
                  _buildMenuItem(
                    icon: Icons.favorite_outline,
                    title: 'Favorilerim',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    icon: Icons.shopping_bag_outlined,
                    title: 'Sipariş Geçmişi',
                    onTap: () {},
                  ),
                ],
                
                if (isSeller) ...[
                  _buildMenuItem(
                    icon: Icons.dashboard_outlined,
                    title: 'Satıcı Paneli',
                    subtitle: 'Ürün ve sipariş yönetimi',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SellerPanelScreen()),
                    ),
                  ),
                  _buildMenuItem(
                    icon: Icons.analytics_outlined,
                    title: 'İstatistikler',
                    subtitle: 'Satış analizleri',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    icon: Icons.inventory_outlined,
                    title: 'Ürünlerim',
                    subtitle: '${user?.totalProducts ?? 0} ürün',
                    onTap: () {},
                  ),
                ],
                
                _buildMenuItem(
                  icon: Icons.payment_outlined,
                  title: 'Ödeme Yöntemleri',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.location_on_outlined,
                  title: 'Adreslerim',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.help_outline,
                  title: 'Yardım & Destek',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Gizlilik Politikası',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.logout,
                  title: 'Çıkış Yap',
                  onTap: () => userProvider.logout(),
                  isDestructive: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isDestructive ? Colors.red : AppColors.textSecondary,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isDestructive ? Colors.red : AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: subtitle != null 
          ? Text(
              subtitle,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            )
          : null,
        trailing: const Icon(
          Icons.chevron_right,
          color: AppColors.textSecondary,
        ),
        onTap: onTap,
      ),
    );
  }

  void _showRoleSwitchDialog(BuildContext context, UserProvider userProvider) {
    final isSeller = userProvider.isSeller;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(
              isSeller ? Icons.person : Icons.store,
              color: AppColors.primary,
            ),
            const SizedBox(width: 8),
            Text(
              isSeller ? 'Müşteri Moduna Geç' : 'Satıcı Moduna Geç',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        content: Text(
          isSeller 
            ? 'Müşteri moduna geçmek istediğinize emin misiniz? Satıcı özelliklerine erişiminiz geçici olarak kapatılacak.'
            : 'Satıcı moduna geçmek istediğinize emin misiniz? Ürün ekleme ve satış yapma özelliklerine erişebileceksiniz.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              userProvider.switchUserType();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isSeller 
                      ? 'Müşteri moduna geçildi' 
                      : 'Satıcı moduna geçildi',
                  ),
                  backgroundColor: AppColors.success,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: const Text('Değiştir'),
          ),
        ],
      ),
    );
  }
}