import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  // Bildirim ayarları
  bool pushNotifications = true;
  bool emailNotifications = true;
  bool smsNotifications = false;

  // Kategori bazlı bildirimler
  bool orderUpdates = true;
  bool promotions = true;
  bool newProducts = false;
  bool priceAlerts = true;
  bool reviewReminders = false;
  bool loyaltyPoints = true;

  // Zaman ayarları
  bool doNotDisturb = false;
  TimeOfDay doNotDisturbStart = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay doNotDisturbEnd = const TimeOfDay(hour: 8, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Bildirim Ayarları',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Genel Bildirimler
            _buildSection(
              title: 'Genel Ayarlar',
              children: [
                _buildSwitchTile(
                  icon: Icons.notifications_active,
                  title: 'Push Bildirimleri',
                  subtitle: 'Mobil cihazınızda bildirim alın',
                  value: pushNotifications,
                  onChanged: (value) {
                    setState(() {
                      pushNotifications = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  icon: Icons.email_outlined,
                  title: 'E-posta Bildirimleri',
                  subtitle: 'E-posta adresinize bildirim gönderilsin',
                  value: emailNotifications,
                  onChanged: (value) {
                    setState(() {
                      emailNotifications = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  icon: Icons.sms_outlined,
                  title: 'SMS Bildirimleri',
                  subtitle: 'Önemli güncellemeler için SMS alın',
                  value: smsNotifications,
                  onChanged: (value) {
                    setState(() {
                      smsNotifications = value;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Kategori Bildirimleri
            _buildSection(
              title: 'Bildirim Kategorileri',
              children: [
                _buildSwitchTile(
                  icon: Icons.shopping_bag_outlined,
                  title: 'Sipariş Güncellemeleri',
                  subtitle: 'Sipariş durumu ve kargo bilgileri',
                  value: orderUpdates,
                  onChanged: (value) {
                    setState(() {
                      orderUpdates = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  icon: Icons.local_offer_outlined,
                  title: 'Kampanyalar ve İndirimler',
                  subtitle: 'Özel fırsatlar ve promosyonlar',
                  value: promotions,
                  onChanged: (value) {
                    setState(() {
                      promotions = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  icon: Icons.new_releases_outlined,
                  title: 'Yeni Ürünler',
                  subtitle: 'Kategorinizdeki yeni ürün duyuruları',
                  value: newProducts,
                  onChanged: (value) {
                    setState(() {
                      newProducts = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  icon: Icons.trending_down_outlined,
                  title: 'Fiyat Düşüş Uyarıları',
                  subtitle: 'Favorilerdeki ürünlerin fiyat değişimleri',
                  value: priceAlerts,
                  onChanged: (value) {
                    setState(() {
                      priceAlerts = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  icon: Icons.rate_review_outlined,
                  title: 'Değerlendirme Hatırlatmaları',
                  subtitle: 'Satın aldığınız ürünleri değerlendirin',
                  value: reviewReminders,
                  onChanged: (value) {
                    setState(() {
                      reviewReminders = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  icon: Icons.stars_outlined,
                  title: 'Sadakat Puanları',
                  subtitle: 'Puan kazanma ve kullanma fırsatları',
                  value: loyaltyPoints,
                  onChanged: (value) {
                    setState(() {
                      loyaltyPoints = value;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Rahatsız Etme Saatleri
            _buildSection(
              title: 'Zaman Ayarları',
              children: [
                _buildSwitchTile(
                  icon: Icons.bedtime_outlined,
                  title: 'Rahatsız Etme',
                  subtitle: doNotDisturb 
                      ? '${_formatTime(doNotDisturbStart)} - ${_formatTime(doNotDisturbEnd)} arası sessiz'
                      : 'Belirli saatlerde bildirim almayın',
                  value: doNotDisturb,
                  onChanged: (value) {
                    setState(() {
                      doNotDisturb = value;
                    });
                  },
                ),
                if (doNotDisturb) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.1),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Başlangıç Saati',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _selectTime(context, true),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppColors.border,
                                  ),
                                ),
                                child: Text(
                                  _formatTime(doNotDisturbStart),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Bitiş Saati',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _selectTime(context, false),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppColors.border,
                                  ),
                                ),
                                child: Text(
                                  _formatTime(doNotDisturbEnd),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),

            const SizedBox(height: 24),

            // Test Bildirimi
            _buildSection(
              title: 'Test',
              children: [
                _buildActionTile(
                  icon: Icons.send_outlined,
                  title: 'Test Bildirimi Gönder',
                  subtitle: 'Ayarlarınızın çalıştığını kontrol edin',
                  onTap: _sendTestNotification,
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Kaydet Butonu
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveSettings,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Ayarları Kaydet',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Container(
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
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.primary,
        size: 24,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 13,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.primary,
        size: 24,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 13,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: AppColors.textSecondary.withOpacity(0.5),
        size: 20,
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? doNotDisturbStart : doNotDisturbEnd,
    );
    
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          doNotDisturbStart = picked;
        } else {
          doNotDisturbEnd = picked;
        }
      });
    }
  }

  void _sendTestNotification() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Test bildirimi gönderildi! Cihazınızı kontrol edin.'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _saveSettings() {
    // Burada ayarları kaydetme işlemi yapılacak
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Bildirim ayarları kaydedildi'),
        backgroundColor: AppColors.success,
      ),
    );
  }
}