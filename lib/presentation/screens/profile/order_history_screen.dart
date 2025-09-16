import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Örnek sipariş verileri
    final List<Order> orders = [
      Order(
        id: '#2024001',
        date: DateTime.now().subtract(const Duration(days: 2)),
        status: OrderStatus.delivered,
        total: 42999,
        items: 1,
        productName: 'iPhone 14 Pro Max',
        productImage: '📱',
      ),
      Order(
        id: '#2024002',
        date: DateTime.now().subtract(const Duration(days: 5)),
        status: OrderStatus.inTransit,
        total: 1299,
        items: 2,
        productName: 'Nike Air Max',
        productImage: '👟',
      ),
      Order(
        id: '#2024003',
        date: DateTime.now().subtract(const Duration(days: 10)),
        status: OrderStatus.preparing,
        total: 28999,
        items: 1,
        productName: 'MacBook Air M2',
        productImage: '💻',
      ),
      Order(
        id: '#2024004',
        date: DateTime.now().subtract(const Duration(days: 15)),
        status: OrderStatus.cancelled,
        total: 899,
        items: 3,
        productName: 'Zara Ceket',
        productImage: '🧥',
      ),
      Order(
        id: '#2024005',
        date: DateTime.now().subtract(const Duration(days: 30)),
        status: OrderStatus.delivered,
        total: 5499,
        items: 1,
        productName: 'Samsung Galaxy Watch',
        productImage: '⌚',
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Sipariş Geçmişi'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
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
            child: Column(
              children: [
                // Sipariş başlığı
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sipariş ${order.id}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatDate(order.date),
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      _buildStatusBadge(order.status),
                    ],
                  ),
                ),
                // Ürün bilgisi
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            order.productImage,
                            style: const TextStyle(fontSize: 30),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.productName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${order.items} ürün',
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '₺${order.total.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                // Alt butonlar
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: AppColors.border),
                    ),
                  ),
                  child: Row(
                    children: [
                      if (order.status == OrderStatus.delivered) ...[
                        Expanded(
                          child: TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.star_outline, size: 18),
                            label: const Text('Değerlendir'),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      if (order.status == OrderStatus.inTransit) ...[
                        Expanded(
                          child: TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.local_shipping, size: 18),
                            label: const Text('Kargo Takibi'),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Detaylar'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusBadge(OrderStatus status) {
    Color color;
    String text;
    IconData icon;

    switch (status) {
      case OrderStatus.preparing:
        color = Colors.orange;
        text = 'Hazırlanıyor';
        icon = Icons.access_time;
        break;
      case OrderStatus.inTransit:
        color = Colors.blue;
        text = 'Kargoda';
        icon = Icons.local_shipping;
        break;
      case OrderStatus.delivered:
        color = Colors.green;
        text = 'Teslim Edildi';
        icon = Icons.check_circle;
        break;
      case OrderStatus.cancelled:
        color = Colors.red;
        text = 'İptal Edildi';
        icon = Icons.cancel;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran',
      'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}

class Order {
  final String id;
  final DateTime date;
  final OrderStatus status;
  final double total;
  final int items;
  final String productName;
  final String productImage;

  Order({
    required this.id,
    required this.date,
    required this.status,
    required this.total,
    required this.items,
    required this.productName,
    required this.productImage,
  });
}

enum OrderStatus {
  preparing,
  inTransit,
  delivered,
  cancelled,
}