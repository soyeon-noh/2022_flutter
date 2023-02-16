import 'package:flutter/material.dart';
import 'package:pomodoro2/screens/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xFF232855),
          ),
        ),
        colorScheme:
            ColorScheme.fromSwatch(backgroundColor: const Color(0xFFE7626C)),
        cardColor: const Color(0xFFF4EDDB),
      ),
      home: const HomeScreen(),
    ),
  );
}
