// import 'package:flutter/cupertino.dart';
//
// side() {
//   Navigator.push(
//     context,
//     PageRouteBuilder(
//       transitionDuration: Duration(milliseconds: 300),
//       reverseTransitionDuration: Duration(milliseconds: 300),
//
//       pageBuilder: (context, animation, secondaryAnimation) {
//         return SecondScreen();
//       },
//
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         final slide = Tween<Offset>(
//           begin: Offset(1, 0),
//           end: Offset.zero,
//         ).animate(animation);
//
//         final fade = Tween<double>(begin: 0.0, end: 1.0).animate(animation);
//
//         return FadeTransition(
//           opacity: fade,
//           child: SlideTransition(position: slide, child: child),
//         );
//       },
//     ),
//   );
// }
//
// bottom() {
//   Navigator.push(
//     context,
//     PageRouteBuilder(
//       transitionDuration: Duration(milliseconds: 300),
//       reverseTransitionDuration: Duration(milliseconds: 300),
//
//       pageBuilder: (context, animation, secondaryAnimation) {
//         return SecondScreen();
//       },
//
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         final slide = Tween<Offset>(
//           begin: Offset(0, 1),
//           end: Offset.zero,
//         ).animate(animation);
//
//         final fade = Tween<double>(begin: 0, end: 1).animate(animation);
//
//         return FadeTransition(
//           opacity: fade,
//           child: SlideTransition(position: slide, child: child),
//         );
//       },
//     ),
//   );
// }
