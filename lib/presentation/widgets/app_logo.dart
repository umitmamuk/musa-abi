import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool showText;
  final Color? color;
  final bool useDarkVersion;

  const AppLogo({
    Key? key,
    this.size = 45,  // Varsayılan boyut 30'dan 45'e çıkarıldı
    this.showText = true,
    this.color,
    this.useDarkVersion = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Logo Görseli
        Image.asset(
          useDarkVersion 
              ? 'assets/images/logo.png'
              : 'assets/images/logo_white.png',
          width: size,
          height: size,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            // Görsel yüklenemezse fallback logo göster
            return Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(size * 0.2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'S',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size * 0.6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
        if (showText) ...[
          const SizedBox(width: 10),
          Text(
            '',
            style: TextStyle(
              fontSize: size * 0.6,  // Text boyutu oranı ayarlandı
              fontWeight: FontWeight.w800,
              color: color ?? AppColors.primary,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ],
    );
  }
}

// Bottom Navigation için Mini Logo - BÜYÜTÜLDÜ
class AppLogoMini extends StatelessWidget {
  const AppLogoMini({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo_mini.png',
      width: 30,  // 24'ten 30'a çıkarıldı
      height: 30,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.primary.withOpacity(0.8),
              ],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
              'S',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}

// Extra Large Logo - Ana sayfa için
class AppLogoLarge extends StatelessWidget {
  final bool showText;
  final Color? textColor;

  const AppLogoLarge({
    Key? key,
    this.showText = true,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Logo Görseli
        Image.asset(
          'assets/images/logo.png',
          width: 50,  // Büyük boyut
          height: 50,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'S',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
        if (showText) ...[
          const SizedBox(width: 12),
          Text(
            'Snapal',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: textColor ?? AppColors.primary,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ],
    );
  }
}

// Sadece Logo Görseli (Text olmadan)
class AppLogoImage extends StatelessWidget {
  final double size;
  final bool useDarkVersion;

  const AppLogoImage({
    Key? key,
    this.size = 40,  // Varsayılan boyut artırıldı
    this.useDarkVersion = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      useDarkVersion 
          ? 'assets/images/logo.png'
          : 'assets/images/logo_white.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(size * 0.2),
          ),
          child: Icon(
            Icons.shopping_bag,
            color: Colors.white,
            size: size * 0.6,
          ),
        );
      },
    );
  }
}

// Yuvarlak Logo
class AppLogoCircle extends StatelessWidget {
  final double size;
  
  const AppLogoCircle({
    Key? key,
    this.size = 60,  // Varsayılan boyut artırıldı
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: Padding(
          padding: EdgeInsets.all(size * 0.15), // Logo etrafında boşluk
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: AppColors.primary,
                child: Icon(
                  Icons.shopping_bag,
                  color: Colors.white,
                  size: size * 0.5,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}