import 'package:flutter/material.dart';

abstract class AppThemeFactory {
  Color get backgroundColor;
  Color get primaryColor;

  Widget createButton({required String text, required VoidCallback onPressed});
  Widget createProductCard({
    required String name,
    required String price,
    required Widget image,
    required VoidCallback onAdd,
  });

  TextStyle get titleStyle;
  TextStyle get textStyle;
}

class TechThemeFactory implements AppThemeFactory {
  @override
  Color get backgroundColor => const Color(0xFF0E0E12);

  @override
  Color get primaryColor => const Color(0xFF6C63FF);

  @override
  TextStyle get titleStyle => const TextStyle(
    color: Colors.white,
    fontSize: 22,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
  );

  @override
  TextStyle get textStyle =>
      TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 16);

  @override
  Widget createButton({required String text, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 26),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF6C63FF), Color(0xFF8F6CFF)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16,
            letterSpacing: 0.8,
          ),
        ),
      ),
    );
  }

  @override
  Widget createProductCard({
    required String name,
    required String price,
    required Widget image,
    required VoidCallback onAdd,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A27), Color(0xFF101018)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: primaryColor.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: image,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(price, style: TextStyle(color: primaryColor, fontSize: 15)),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: onAdd,
            child: Icon(
              Icons.add_circle_rounded,
              color: primaryColor,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}

class CozyThemeFactory implements AppThemeFactory {
  @override
  Color get backgroundColor => const Color(0xFFFFF3E9);

  @override
  Color get primaryColor => const Color(0xFFE97B53);

  @override
  TextStyle get titleStyle => const TextStyle(
    color: Color(0xFF8B4A2F),
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  @override
  TextStyle get textStyle =>
      const TextStyle(color: Color(0xFF8B5E45), fontSize: 16);

  @override
  Widget createButton({required String text, required VoidCallback onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: primaryColor,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  @override
  Widget createProductCard({
    required String name,
    required String price,
    required Widget image,
    required VoidCallback onAdd,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [Color(0xFFFFE1CC), Color(0xFFFFF3EA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFE97B53).withOpacity(0.25),
            blurRadius: 14,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: image,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(
              color: Color(0xFF7A422C),
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(price, style: TextStyle(color: primaryColor, fontSize: 15)),
          const SizedBox(height: 8),
          IconButton(
            icon: Icon(Icons.add_circle, color: primaryColor, size: 30),
            onPressed: onAdd,
          ),
        ],
      ),
    );
  }
}
