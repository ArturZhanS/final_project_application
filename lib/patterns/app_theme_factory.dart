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
}

class TechThemeFactory implements AppThemeFactory {
  @override
  Color get backgroundColor => Colors.black87;
  @override
  Color get primaryColor => Colors.cyanAccent;
  @override
  TextStyle get titleStyle => TextStyle(
    color: Colors.cyanAccent,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: 'Courier',
  );

  @override
  Widget createButton({required String text, required VoidCallback onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.cyanAccent,
        foregroundColor: Colors.black,
        shape: BeveledRectangleBorder(),
        padding: EdgeInsets.all(20),
      ),
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(fontWeight: FontWeight.bold),
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
        border: Border.all(color: Colors.cyanAccent),
        color: Colors.grey[900],
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(child: image),
          Text(
            name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(price, style: TextStyle(color: Colors.cyan)),
          SizedBox(height: 5),
          InkWell(
            onTap: onAdd,
            child: Icon(Icons.add_box, color: Colors.cyanAccent),
          ),
        ],
      ),
    );
  }
}

class CozyThemeFactory implements AppThemeFactory {
  @override
  Color get backgroundColor => Colors.orange[50]!;
  @override
  Color get primaryColor => Colors.deepOrange;
  @override
  TextStyle get titleStyle =>
      TextStyle(color: Colors.brown, fontSize: 22, fontWeight: FontWeight.w600);

  @override
  Widget createButton({required String text, required VoidCallback onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }

  @override
  Widget createProductCard({
    required String name,
    required String price,
    required Widget image,
    required VoidCallback onAdd,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(child: image),
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            Text(price, style: TextStyle(color: Colors.orange)),
            IconButton(
              icon: Icon(Icons.add_circle, color: Colors.deepOrange),
              onPressed: onAdd,
            ),
          ],
        ),
      ),
    );
  }
}
