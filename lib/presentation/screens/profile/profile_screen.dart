import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../providers/user_provider.dart';

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
                            backgroundColor: AppColors.primary,
                            child: Text(
                              user?.name.substring(0, 2).toUpperCase() ?? 'KK',
                              style: const TextStyle(
                                color: Colors.white,
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
                                decoration: const BoxDecoration(
                                  color: AppColors.success,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.store,
                                  size: 12,
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
                        '@${user?.username ?? 'kullanici'}',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      if (isSeller) ...[
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.store,
                                size: 14,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                user?.storeName ?? 'Mağaza',
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
                
                // Kullanıcı Tipi Değiştirme
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: AppColors.getGradient(
                      colors: [
                        AppColors.primary.withOpacity(0.1),
                        AppColors.accent.withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSeller ? Icons.person : Icons.store,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isSeller ? 'Müşteri Moduna Geç' : 'Satıcı Ol',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              isSeller 
                                ? 'Alışveriş yapmak için müşteri moduna geçin'
                                : 'Ürünlerinizi satmaya başlayın',
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: isSeller,
                        onChanged: userProvider.isLoading 
                          ? null 
                          : (value) => userProvider.switchUserType(),
                        activeColor: AppColors.primary,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                
                // Menü Seçenekleri
                _buildMenuItem(
                  icon: Icons.favorite_outline,
                  title: 'Favorilerim',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.shopping_bag_outlined,
                  title: isSeller ? 'Satış Geçmişi' : 'Sipariş Geçmişi',
                  onTap: () {},
                ),
                if (isSeller)
                  _buildMenuItem(
                    icon: Icons.analytics_outlined,
                    title: 'İstatistikler',
                    onTap: () {},
                  ),
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
                  icon: Icons.notifications_outlined,
                  title: 'Bildirim Ayarları',
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
                  onTap: () => _showLogoutDialog(context),
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
    // Değeri formatla (1200 -> 1.2K)
    String formattedValue = value;
    final intValue = int.tryParse(value) ?? 0;
    if (intValue >= 1000) {
      formattedValue = '${(intValue / 1000).toStringAsFixed(1)}K';
    }
    
    return Column(
      children: [
        Text(
          formattedValue,
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
        trailing: const Icon(
          Icons.chevron_right,
          color: AppColors.textSecondary,
        ),
        onTap: onTap,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Çıkış Yap'),
        content: const Text('Hesabınızdan çıkış yapmak istediğinize emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<UserProvider>().logout();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Başarıyla çıkış yapıldı'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text(
              'Çıkış Yap',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}