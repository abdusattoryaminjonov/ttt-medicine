import 'package:flutter/cupertino.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.7);

    path.quadraticBezierTo(
        size.width * 0.5, size.height, size.width, size.height * 0.7);

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
