import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(FlashcardQuizApp());
}

class FlashcardQuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcard Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headlineSmall: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent),
          bodyMedium: TextStyle(fontSize: 18.0, color: Colors.black87),
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            textStyle: TextStyle(fontSize: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
