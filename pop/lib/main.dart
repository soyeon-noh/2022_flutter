import 'package:flutter/material.dart';
import 'package:pop/screen/home_screen.dart';

void main() {
  runApp(MaterialApp(
    // 우상단 debug 띠 감추기
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}
