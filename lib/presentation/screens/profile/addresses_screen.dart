import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({Key? key}) : super(key: key);

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  int selectedAddressIndex = 0;
  
  final List<Address> addresses = [
    Address(
      id: '1',
      title: 'Ev',
      fullName: 'Mehmet Musa Aydın',
      phone: '0532 123 45 67',
      address: 'Atatürk Mahallesi, Cumhuriyet Caddesi No: 123/4',
      district: 'Kadıköy',
      city: 'İstanbul',
      isDefault: true,
    ),
    Address(
      id: '2',
      title: 'İş',
      fullName: 'Mehmet Musa Aydın',
      phone: '0532 123 45 67',
      address: 'Levent Mahallesi, İş Merkezi Plaza Kat: 5',
      district: 'Beşiktaş',
      city: 'İstanbul',
      isDefault: false,
    ),
    Address(
      id: '3',
      title: 'Aile Evi',
      fullName: 'Ahmet Aydın',
      phone: '0533 987 65 43',
      address: 'Bahçelievler Mahallesi, Park Sokak No: 45',
      district: 'Merkez',
      city: 'Denizli',
      isDefault: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Adreslerim'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        actions: [
          TextButton.icon(
            onPressed: _addNewAddress,
            icon: const Icon(Icons.add, size: 20),
            label: const Text('Ekle'),
          ),
        ],
      ),
      body: addresses.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];
                return _buildAddressCard(address, index);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_off,
            size: 80,
            color: AppColors.textSecondary.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          const Text(
            'Henüz adres eklemediniz',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _addNewAddress,
            icon: const Icon(Icons.add_location),
            label: const Text('Adres Ekle'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(Address address, int index) {
    final isSelected = selectedAddressIndex == index;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColors.primary : Colors.transparent,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedAddressIndex = index;
          });
        },
        borderRadius: BorderRadius.circular(12),
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
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      address.title == 'Ev' 
                        ? Icons.home
                        : address.title == 'İş'
                          ? Icons.work
                          : Icons.location_on,
                      color: AppColors.primary,
                      size: 20,
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
                              address.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            if (address.isDefault) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.success.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Varsayılan',
                                  style: TextStyle(
                                    color: AppColors.success,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          address.fullName,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton(
                    icon: const Icon(Icons.more_vert, color: AppColors.textSecondary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 18, color: AppColors.textPrimary),
                            SizedBox(width: 8),
                            Text('Düzenle'),
                          ],
                        ),
                      ),
                      if (!address.isDefault)
                        const PopupMenuItem(
                          value: 'default',
                          child: Row(
                            children: [
                              Icon(Icons.check_circle, size: 18, color: AppColors.success),
                              SizedBox(width: 8),
                              Text('Varsayılan Yap'),
                            ],
                          ),
                        ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, size: 18, color: AppColors.error),
                            SizedBox(width: 8),
                            Text('Sil', style: TextStyle(color: AppColors.error)),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (value) {
                      switch (value) {
                        case 'edit':
                          _editAddress(address);
                          break;
                        case 'default':
                          _setDefaultAddress(index);
                          break;
                        case 'delete':
                          _deleteAddress(index);
                          break;
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                address.address,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${address.district} / ${address.city}',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.phone,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    address.phone,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addNewAddress() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Yeni adres ekleme formu açılıyor...')),
    );
  }

  void _editAddress(Address address) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${address.title} adresi düzenleniyor...')),
    );
  }

  void _setDefaultAddress(int index) {
    setState(() {
      for (var i = 0; i < addresses.length; i++) {
        addresses[i].isDefault = i == index;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Varsayılan adres güncellendi'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _deleteAddress(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adresi Sil'),
        content: Text('${addresses[index].title} adresini silmek istediğinize emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                addresses.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Adres silindi'),
                  backgroundColor: AppColors.error,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }
}

class Address {
  final String id;
  final String title;
  final String fullName;
  final String phone;
  final String address;
  final String district;
  final String city;
  bool isDefault;

  Address({
    required this.id,
    required this.title,
    required this.fullName,
    required this.phone,
    required this.address,
    required this.district,
    required this.city,
    required this.isDefault,
  });
}