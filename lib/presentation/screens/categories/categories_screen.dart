import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/category.dart' as app_models;
import 'category_products_screen.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  // Buradaki const kaldırıldı
  final List<app_models.Category> categories = [
    app_models.Category(name: 'Moda', icon: Icons.checkroom, color: AppColors.categoryPink),
    app_models.Category(name: 'Elektronik', icon: Icons.devices, color: AppColors.categoryBlue),
    app_models.Category(name: 'Ev & Yaşam', icon: Icons.home, color: AppColors.categoryGreen),
    app_models.Category(name: 'Spor', icon: Icons.sports_soccer, color: AppColors.categoryOrange),
    app_models.Category(name: 'Kozmetik', icon: Icons.face, color: AppColors.categoryPurple),
    app_models.Category(name: 'Kitap', icon: Icons.book, color: AppColors.categoryBrown),
    app_models.Category(name: 'Oyuncak', icon: Icons.toys, color: AppColors.categoryRed),
    app_models.Category(name: 'Sağlık', icon: Icons.health_and_safety, color: AppColors.categoryTeal),
  ];
  // final List<Category> categories = [
  //   Category(name: 'Moda', icon: Icons.checkroom, color: AppColors.categoryPink),
  //   Category(name: 'Elektronik', icon: Icons.devices, color: AppColors.categoryBlue),
  //   Category(name: 'Ev & Yaşam', icon: Icons.home, color: AppColors.categoryGreen),
  //   Category(name: 'Spor', icon: Icons.sports_soccer, color: AppColors.categoryOrange),
  //   Category(name: 'Kozmetik', icon: Icons.face, color: AppColors.categoryPurple),
  //   Category(name: 'Kitap', icon: Icons.book, color: AppColors.categoryBrown),
  //   Category(name: 'Oyuncak', icon: Icons.toys, color: AppColors.categoryRed),
  //   Category(name: 'Sağlık', icon: Icons.health_and_safety, color: AppColors.categoryTeal),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Kategoriler',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: Column(
        children: [
          // Filtre Çubuğu
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.filter_list, size: 20),
                        SizedBox(width: 8),
                        Text('Filtrele'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.sort, size: 20),
                        SizedBox(width: 8),
                        Text('Sırala'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Kategori Grid'i
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryProductsScreen(category: category),
                    ),
                  ),
                  child: Container(
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: category.color.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            category.icon,
                            size: 32,
                            color: category.color,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          category.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
