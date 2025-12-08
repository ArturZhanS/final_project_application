import 'package:flutter/material.dart';
import '../patterns/app_theme_factory.dart';
import 'main_nav_screen.dart';
import 'dart:math' as math; // "Қалқып тұрған" элементтерді бұру үшін керек

// Глобалдық айнымалы
AppThemeFactory currentTheme = CozyThemeFactory();

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // 1. Қаныққан Супермаркет Фоны (Градиент + Паттерн)
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFF416C), // Қаныққан қызыл-қызғылт (Таңқурай)
                  Color(0xFFFF4B2B), // Жарқын қызғылт-сары (Апельсин)
                ],
              ),
            ),
          ),

          // Фондағы "қалқып жүрген" тауарлар (атмосфера үшін)
          Positioned(
            top: size.height * 0.1,
            left: size.width * 0.1,
            child: _floatingIcon(Icons.shopping_cart, 0.1),
          ),
          Positioned(
            top: size.height * 0.2,
            right: size.width * 0.15,
            child: _floatingIcon(Icons.fastfood, -0.2),
          ),
          Positioned(
            top: size.height * 0.35,
            left: size.width * 0.05,
            child: _floatingIcon(Icons.checkroom, 0.15),
          ),
          Positioned(
            top: size.height * 0.4,
            right: size.width * 0.05,
            child: _floatingIcon(Icons.devices, -0.1),
          ),

          // 2. Негізгі Контент
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.05),

                // Үлкен Орталық Иллюстрация (Тауарға толы себет)
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 180,
                      width: 180,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Icon(
                      Icons.shopping_cart_rounded,
                      size: 120,
                      color: Colors.white,
                    ),
                    // Себеттен шығып тұрған тауарлар
                    Positioned(
                      top: 30,
                      left: 40,
                      child: Icon(
                        Icons.lunch_dining,
                        size: 40,
                        color: Colors.yellow[200],
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 50,
                      child: Icon(
                        Icons.phone_iphone,
                        size: 35,
                        color: Colors.blue[100],
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      left: 50,
                      child: Icon(
                        Icons.local_offer,
                        size: 30,
                        color: Colors.green[100],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Үлкен Тақырып
                const Text(
                  "MEGA MARKET",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w900, // Ең қалың шрифт
                    color: Colors.white,
                    letterSpacing: 1.5,
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 10,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Everything you need. Right here.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const Spacer(),

                // 3. Төменгі Активті Блок (Ақ карточка)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(30),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 20,
                        offset: Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Choose Your Vibe",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Тақырып таңдау (Abstract Factory)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildThemeButton(
                            context,
                            "Tech Mode",
                            Icons.computer_outlined,
                            TechThemeFactory(),
                            Colors.black87,
                          ),
                          _buildThemeButton(
                            context,
                            "Cozy Mode",
                            Icons.coffee_outlined,
                            CozyThemeFactory(),
                            Colors.deepOrange,
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),

                      // ДӘУ START КНОПКАСЫ
                      SizedBox(
                        width: double.infinity,
                        height: 65,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const MainNavScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                              0xFFFF4B2B,
                            ), // Фонның түсімен бірдей
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 8,
                            shadowColor: const Color(
                              0xFFFF4B2B,
                            ).withOpacity(0.5),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "START SHOPPING NOW",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.arrow_forward_rounded),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Фондағы әлсіз көрінетін иконкалар
  Widget _floatingIcon(IconData icon, double angle) {
    return Transform.rotate(
      angle: math.pi * angle,
      child: Icon(icon, size: 60, color: Colors.white.withOpacity(0.15)),
    );
  }

  // Тақырып таңдау түймесінің дизайны
  Widget _buildThemeButton(
    BuildContext context,
    String title,
    IconData icon,
    AppThemeFactory theme,
    Color color,
  ) {
    return GestureDetector(
      onTap: () {
        currentTheme = theme;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("$title selected!", textAlign: TextAlign.center),
            backgroundColor: color,
            duration: const Duration(milliseconds: 500),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3), width: 2),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
