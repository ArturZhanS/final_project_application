import 'package:flutter/material.dart';
import '../patterns/app_theme_factory.dart';
import '../screens/main_nav_screen.dart';

AppThemeFactory currentTheme = CozyThemeFactory();

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Select Theme",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                currentTheme = TechThemeFactory();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const MainNavScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.cyanAccent,
              ),
              child: const Text("TECH DESIGN"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                currentTheme = CozyThemeFactory();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const MainNavScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: const Text("COZY DESIGN"),
            ),
          ],
        ),
      ),
    );
  }
}
