import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({Key? key}) : super(key: key);

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  // Örnek kredi kartı bilgileri
  final List<PaymentMethod> paymentMethods = [
    PaymentMethod(
      id: '1',
      type: PaymentType.creditCard,
      cardNumber: '**** **** **** 1234',
      cardHolder: 'MEHMET MUSA AYDIN',
      expiryDate: '12/26',
      cardType: 'Visa',
      isDefault: true,
    ),
    PaymentMethod(
      id: '2',
      type: PaymentType.creditCard,
      cardNumber: '**** **** **** 5678',
      cardHolder: 'MEHMET MUSA AYDIN',
      expiryDate: '08/25',
      cardType: 'Mastercard',
      isDefault: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Ödeme Yöntemleri',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: paymentMethods.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: paymentMethods.length,
                    itemBuilder: (context, index) {
                      final method = paymentMethods[index];
                      return _buildPaymentMethodCard(method);
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _addNewPaymentMethod,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 8),
                    Text(
                      'Yeni Kart Ekle',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(PaymentMethod method) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
        border: method.isDefault
            ? Border.all(color: AppColors.primary, width: 2)
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getCardColor(method.cardType),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getCardIcon(method.cardType),
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            method.cardType,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (method.isDefault) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Varsayılan',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      Text(
                        method.cardNumber,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) => _handleMenuAction(value, method),
                  itemBuilder: (context) => [
                    if (!method.isDefault)
                      const PopupMenuItem(
                        value: 'default',
                        child: Row(
                          children: [
                            Icon(Icons.check_circle_outline),
                            SizedBox(width: 8),
                            Text('Varsayılan Yap'),
                          ],
                        ),
                      ),
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit_outlined),
                          SizedBox(width: 8),
                          Text('Düzenle'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete_outline, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Sil', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              method.cardHolder,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Son kullanma: ${method.expiryDate}',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.credit_card_outlined,
            size: 80,
            color: AppColors.textSecondary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'Henüz ödeme yöntemi yok',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Hızlı ödeme için kredi kartınızı ekleyin',
            style: TextStyle(
              color: AppColors.textSecondary.withOpacity(0.8),
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Color _getCardColor(String cardType) {
    switch (cardType.toLowerCase()) {
      case 'visa':
        return const Color(0xFF1A1F71);
      case 'mastercard':
        return const Color(0xFFEB001B);
      case 'american express':
        return const Color(0xFF006FCF);
      default:
        return AppColors.primary;
    }
  }

  IconData _getCardIcon(String cardType) {
    switch (cardType.toLowerCase()) {
      case 'visa':
      case 'mastercard':
      case 'american express':
        return Icons.credit_card;
      default:
        return Icons.credit_card;
    }
  }

  void _handleMenuAction(String action, PaymentMethod method) {
    switch (action) {
      case 'default':
        _setAsDefault(method);
        break;
      case 'edit':
        _editPaymentMethod(method);
        break;
      case 'delete':
        _deletePaymentMethod(method);
        break;
    }
  }

  void _setAsDefault(PaymentMethod method) {
    setState(() {
      for (var m in paymentMethods) {
        m.isDefault = m.id == method.id;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Varsayılan ödeme yöntemi güncellendi'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _editPaymentMethod(PaymentMethod method) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Kart düzenleme özelliği geliştiriliyor...')),
    );
  }

  void _deletePaymentMethod(PaymentMethod method) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Kartı Sil'),
        content: Text(
          '${method.cardNumber} numaralı kartı silmek istediğinize emin misiniz?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                paymentMethods.remove(method);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Kart silindi'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }

  void _addNewPaymentMethod() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Yeni kart ekleme özelliği geliştiriliyor...')),
    );
  }
}

// Data Models
enum PaymentType {
  creditCard,
  debitCard,
  paypal,
  applePay,
  googlePay,
}

class PaymentMethod {
  final String id;
  final PaymentType type;
  final String cardNumber;
  final String cardHolder;
  final String expiryDate;
  final String cardType;
  bool isDefault;

  PaymentMethod({
    required this.id,
    required this.type,
    required this.cardNumber,
    required this.cardHolder,
    required this.expiryDate,
    required this.cardType,
    this.isDefault = false,
  });
}