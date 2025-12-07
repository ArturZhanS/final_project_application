import 'package:flutter/material.dart';
import '../patterns/app_theme_factory.dart'; 

class WelcomeScreen extends StatelessWidget {
  // УДАЛЕН 'const' для совместимости с MainNavScreen
  WelcomeScreen({super.key}); 

  final AppThemeFactory themeFactory = TechThemeFactory(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeFactory.backgroundColor, 
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // --- Icon/Logo ---
              Icon(
                Icons.shopping_bag,
                size: 80,
                color: themeFactory.primaryColor,
              ),
              const SizedBox(height: 32),

              // --- Title ---
              Text(
                'Welcome!', 
                style: themeFactory.titleStyle.copyWith(fontSize: 28), 
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // --- Description ---
              Text(
                'Find your shopping right now. We offer the best products using innovative approaches.',
                style: themeFactory.textStyle, 
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              // --- Button ---
              SizedBox(
                width: double.infinity,
                height: 60, 
                child: themeFactory.createButton(
                  text: 'Start Shopping', 
                  onPressed: () {
                    // TODO: Implement navigation to the main_nav_screen
                    debugPrint('Navigate to main screen!');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}