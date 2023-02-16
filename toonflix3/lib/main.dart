import 'package:flutter/material.dart';
import 'package:toonflix3/screens/home_screen.dart';
import 'package:toonflix3/services/api_service.dart';

void main() {
  ApiService.getTodaysToons();
  runApp(
    MaterialApp(
      home: HomeScreen(),
    ),
  );
}

// 강의뭔소리닞 모르겠어서 빡쳐서 잠시 잠수