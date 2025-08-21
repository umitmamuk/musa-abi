import 'package:flutter/material.dart';

// Ana Logo Widget - Tam logo (ikon + text birlikte)
class AppLogo extends StatelessWidget {
  final double height;
  final bool isDark;

  const AppLogo({
    Key? key,
    this.height = 40,
    this.isDark = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      isDark ? 'assets/images/logo.png' : 'assets/images/logo_whitee.png',
      height: height,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        // Görsel yüklenemezse fallback
        return _buildFallbackLogo();
      },
    );
  }

  Widget _buildFallbackLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: height,
          height: height,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF6366F1), // Mavi-mor
                Color(0xFF06B6D4), // Cyan
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(height * 0.25),
          ),
          child: Center(
            child: Text(
              'S',
              style: TextStyle(
                color: Colors.white,
                fontSize: height * 0.6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'Snapal',
          style: TextStyle(
            fontSize: height * 0.65,
            fontWeight: FontWeight.w600,
            foreground: Paint()
              ..shader = const LinearGradient(
                colors: [
                  Color(0xFF6366F1),
                  Color(0xFF3B82F6),
                ],
              ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
          ),
        ),
      ],
    );
  }
}

// Sadece S İkonu - Bottom Navigation için
class AppLogoIcon extends StatelessWidget {
  final double size;
  
  const AppLogoIcon({
    Key? key,
    this.size = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo_icon.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        // Fallback gradient ikon
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF6366F1), // Logonuzdaki mavi
                Color(0xFF06B6D4), // Logonuzdaki cyan
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(size * 0.25),
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
    );
  }
}

// Split Logo - İkon ve text ayrı (özel düzenlemeler için)
class AppLogoSplit extends StatelessWidget {
  final double iconSize;
  final double spacing;
  final Color? textColor;

  const AppLogoSplit({
    Key? key,
    this.iconSize = 35,
    this.spacing = 10,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // S İkonu
        AppLogoIcon(size: iconSize),
        SizedBox(width: spacing),
        // Snapal Text
        Text(
          'Snapal',
          style: TextStyle(
            fontSize: iconSize * 0.7,
            fontWeight: FontWeight.w600,
            foreground: textColor != null
                ? (Paint()..color = textColor!)
                : Paint()
                  ..shader = const LinearGradient(
                    colors: [
                      Color(0xFF6366F1),
                      Color(0xFF3B82F6),
                    ],
                  ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
          ),
        ),
      ],
    );
  }
}

// Animasyonlu Logo (Splash Screen için)
class AppLogoAnimated extends StatefulWidget {
  final double size;
  
  const AppLogoAnimated({
    Key? key,
    this.size = 100,
  }) : super(key: key);

  @override
  State<AppLogoAnimated> createState() => _AppLogoAnimatedState();
}

class _AppLogoAnimatedState extends State<AppLogoAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));
    
    _rotateAnimation = Tween<double>(
      begin: -0.1,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotateAnimation.value,
            child: AppLogoIcon(size: widget.size),
          ),
        );
      },
    );
  }
}

// Bottom Navigation için özel logo
class AppLogoMini extends StatelessWidget {
  const AppLogoMini({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AppLogoIcon(size: 28);
  }
}

// Header için büyük logo
class AppLogoHeader extends StatelessWidget {
  const AppLogoHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ekran genişliğine göre responsive
    final screenWidth = MediaQuery.of(context).size.width;
    final logoHeight = screenWidth < 360 ? 35.0 : 40.0;
    
    return AppLogo(height: logoHeight);
  }
}