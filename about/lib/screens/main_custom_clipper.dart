import 'package:flutter/material.dart';

class MainCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    Path path = Path();
    // path.moveTo(100, 0);
    path.lineTo(0, h / 2);
    // path.cubicTo(w / 2, 3 * (h / 2), 3 * (w / 4), h / 2, w, h * 0.9);
    path.cubicTo(3 * w / 4, h / 2, w / 2, h, w, 2 * h / 3);
    path.lineTo(w, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
