// import 'package:flutter/cupertino.dart';
//
// class WaveClipper extends CustomClipper<Path> {
//   @override
//   getClip(Size size) {
//     var path = Path();
//     path.lineTo(0, 150);
//
//     // The values of the calculations would be path.quadraticBezierTo(100, 75, 200, 150) if the height is 200 and the width is 400;
//     path.quadraticBezierTo(size.width * 0.1, size.height * 0.3,
//         size.width * 0.6, size.height * 0.8);
//
//     // The values of the calculations would be path.quadraticBezierTo(300, 225, 400, 150) if the height is 200 and the width is 400;
//     path.quadraticBezierTo(
//         size.width * 0.85, size.height, size.width * 1.1, size.height * 0.35);
//
//     path.lineTo(size.width, 0);
//     path.close();
//
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper oldClipper) {
//     return false;
//   }
// }
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
