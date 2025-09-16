import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  // FAQ kategorileri ve soruları
  final List<FAQCategory> faqCategories = [
    FAQCategory(
      title: 'Sipariş ve Teslimat',
      faqs: [
        FAQ(
          question: 'Siparişim ne zaman gelir?',
          answer:
              'Siparişiniz genellikle 1-3 iş günü içerisinde kargoya verilir ve 2-5 iş günü içerisinde adresinize teslim edilir. Kargo durumunuzu "Siparişlerim" bölümünden takip edebilirsiniz.',
        ),
        FAQ(
          question: 'Kargo ücreti ne kadar?',
          answer:
              '150 TL ve üzeri alışverişlerde kargo ücretsizdir. 150 TL altındaki siparişler için kargo ücreti 15 TL\'dir.',
        ),
        FAQ(
          question: 'Siparişimi iptal edebilir miyim?',
          answer:
              'Henüz kargoya verilmemiş siparişleri "Siparişlerim" bölümünden iptal edebilirsiniz. Kargoya verilen siparişler için iade sürecini başlatabilirsiniz.',
        ),
      ],
    ),
    FAQCategory(
      title: 'Ödeme',
      faqs: [
        FAQ(
          question: 'Hangi ödeme yöntemlerini kabul ediyorsunuz?',
          answer:
              'Kredi kartı, banka kartı, kapıda ödeme ve havale/EFT ile ödeme yapabilirsiniz. Tüm büyük kredi kartı markalarını (Visa, Mastercard, American Express) kabul ediyoruz.',
        ),
        FAQ(
          question: 'Taksitli ödeme yapabilir miyim?',
          answer:
              'Evet, kredi kartınızla 2-12 ay arasında taksitli ödeme yapabilirsiniz. Taksit seçenekleri kartınızın limitine ve bankanızın koşullarına göre değişiklik gösterebilir.',
        ),
        FAQ(
          question: 'Ödeme güvenli mi?',
          answer:
              'Tüm ödemeleriniz SSL sertifikası ile korunmaktadır. Kredi kartı bilgileriniz şifrelenerek güvenli bir şekilde işleme alınır ve sistemimizde saklanmaz.',
        ),
      ],
    ),
    FAQCategory(
      title: 'İade ve Değişim',
      faqs: [
        FAQ(
          question: 'Ürün iadesini nasıl yapabilirim?',
          answer:
              'Ürünü aldığınız tarihten itibaren 14 gün içerisinde iade edebilirsiniz. "Siparişlerim" bölümünden iade talebinde bulunabilir, kargo ile ücretsiz iade edebilirsiniz.',
        ),
        FAQ(
          question: 'Hangi ürünleri iade edemem?',
          answer:
              'Hijyen kuralları gereği iç giyim, mayo, bikini gibi ürünler ile kişisel bakım ürünleri iade edilemez. Ayrıca özel olarak hazırlanan ürünler de iade kapsamı dışındadır.',
        ),
        FAQ(
          question: 'İade sürecim ne kadar sürer?',
          answer:
              'İade ettiğiniz ürün depomıza ulaştıktan sonra 3-5 iş günü içerisinde kontrol edilir ve onaylandıktan sonra ödemeniz iade edilir.',
        ),
      ],
    ),
    FAQCategory(
      title: 'Hesap',
      faqs: [
        FAQ(
          question: 'Şifremi nasıl değiştirebilirim?',
          answer:
              'Profil sayfasındaki "Güvenlik" bölümünden şifrenizi değiştirebilirsiniz. Ayrıca giriş sayfasındaki "Şifremi Unuttum" linkini kullanabilirsiniz.',
        ),
        FAQ(
          question: 'Hesabımı nasıl silebilirim?',
          answer:
              'Hesabınızı silmek için müşteri hizmetleriyle iletişime geçmeniz gerekmektedir. KVKK kapsamında verileriniz güvenle silinecektir.',
        ),
      ],
    ),
  ];

  // İletişim seçenekleri
  final List<ContactOption> contactOptions = [
    ContactOption(
      icon: Icons.phone_outlined,
      title: 'Telefon',
      subtitle: '+90 (212) 123 45 67',
      description: 'Hafta içi 09:00-18:00',
      action: 'call',
    ),
    ContactOption(
      icon: Icons.email_outlined,
      title: 'E-posta',
      subtitle: 'destek@snapal.com',
      description: '24 saat içinde yanıt',
      action: 'email',
    ),
    ContactOption(
      icon: Icons.chat_bubble_outline,
      title: 'Canlı Destek',
      subtitle: 'Anında yardım',
      description: 'Hafta içi 09:00-22:00',
      action: 'chat',
    ),
    ContactOption(
      icon: Icons.forum_outlined,
      title: 'Topluluk Forumu',
      subtitle: 'Diğer kullanıcılarla paylaş',
      description: 'Deneyimlerini paylaş',
      action: 'forum',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Yardım Merkezi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(text: 'Sık Sorulan Sorular'),
            Tab(text: 'İletişim'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFAQTab(),
          _buildContactTab(),
        ],
      ),
    );
  }

  Widget _buildFAQTab() {
    return Column(
      children: [
        // Arama kutusu
        Container(
          margin: const EdgeInsets.all(16),
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
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Sorunuzu arayın...',
              prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
        
        // FAQ Kategorileri
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: faqCategories.length,
            itemBuilder: (context, index) {
              final category = faqCategories[index];
              return _buildFAQCategory(category);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildContactTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Size nasıl yardımcı olabiliriz?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Aşağıdaki iletişim kanallarından bize ulaşabilirsiniz',
            style: TextStyle(
              color: AppColors.textSecondary.withOpacity(0.8),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          
          Expanded(
            child: ListView.builder(
              itemCount: contactOptions.length,
              itemBuilder: (context, index) {
                final option = contactOptions[index];
                return _buildContactOption(option);
              },
            ),
          ),
          
          // Sosyal Medya
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
                const Text(
                  'Bizi Takip Edin',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSocialMediaButton(
                      icon: Icons.facebook,
                      label: 'Facebook',
                      color: const Color(0xFF1877F2),
                    ),
                    _buildSocialMediaButton(
                      icon: Icons.camera_alt,
                      label: 'Instagram',
                      color: const Color(0xFFE4405F),
                    ),
                    _buildSocialMediaButton(
                      icon: Icons.alternate_email,
                      label: 'Twitter',
                      color: const Color(0xFF1DA1F2),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQCategory(FAQCategory category) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: ExpansionTile(
        title: Text(
          category.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        children: category.faqs.map((faq) => _buildFAQItem(faq)).toList(),
      ),
    );
  }

  Widget _buildFAQItem(FAQ faq) {
    return ExpansionTile(
      title: Text(
        faq.question,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(
            faq.answer,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactOption(ContactOption option) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            option.icon,
            color: AppColors.primary,
            size: 24,
          ),
        ),
        title: Text(
          option.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              option.subtitle,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 13,
              ),
            ),
            Text(
              option.description,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: AppColors.textSecondary,
        ),
        onTap: () => _handleContactAction(option.action),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }

  Widget _buildSocialMediaButton({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () => _openSocialMedia(label),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _handleContactAction(String action) {
    switch (action) {
      case 'call':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Telefon uygulaması açılıyor...')),
        );
        break;
      case 'email':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('E-posta uygulaması açılıyor...')),
        );
        break;
      case 'chat':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Canlı destek başlatılıyor...')),
        );
        break;
      case 'forum':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Topluluk forumu açılıyor...')),
        );
        break;
    }
  }

  void _openSocialMedia(String platform) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$platform sayfamız açılıyor...')),
    );
  }
}

// Data Models
class FAQCategory {
  final String title;
  final List<FAQ> faqs;

  FAQCategory({
    required this.title,
    required this.faqs,
  });
}

class FAQ {
  final String question;
  final String answer;

  FAQ({
    required this.question,
    required this.answer,
  });
}

class ContactOption {
  final IconData icon;
  final String title;
  final String subtitle;
  final String description;
  final String action;

  ContactOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.action,
  });
}