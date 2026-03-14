// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:servicesplatform/features/web/utils/app_theme.dart';

// class OrbitingCard extends StatelessWidget {
//   final int index;
//   final double scrollValue;
//   final bool isPrimary;

//   const OrbitingCard({
//     super.key,
//     required this.index,
//     required this.scrollValue,
//     required this.isPrimary,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Math for Orbit:
//     // We want the active card at PI (left side of the circle)
//     // The inactive card moves to the top/bottom (imaginary area)
    
//     double angleOffset = (index == 0) ? 0 : 1; // Card difference
//     double currentAngle = (scrollValue - angleOffset) * (pi / 2) + pi;
    
//     double radius = 300.0; // Half of the 600 container
//     double x = cos(currentAngle) * radius;
//     double y = sin(currentAngle) * radius;

//     // Scale and Opacity based on proximity to the "Active Zone" (left side)
//     double distanceFromActive = (x + radius).abs() / radius; 
//     double scale = (1.2 - distanceFromActive).clamp(0.7, 1.0);
//     double opacity = (1.2 - distanceFromActive).clamp(0.0, 1.0);

//     return Transform.translate(
//       offset: Offset(x, y),
//       child: Transform.scale(
//         scale: scale,
//         child: Opacity(
//           opacity: opacity,
//           child: Container(
//             width: 260, // Smaller width
//             height: 380, // Vertically long
//             padding: const EdgeInsets.all(32),
//             decoration: BoxDecoration(
//               color: const Color(0xFF161616),
//               borderRadius: BorderRadius.circular(24),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.3),
//                   blurRadius: 20,
//                   offset: const Offset(-10, 10),
//                 )
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Icon(
//                   isPrimary ? Icons.bolt : Icons.rocket_launch,
//                   color: AppTheme.primaryGreen,
//                   size: 28,
//                 ),
//                 const SizedBox(height: 24),
//                 Text(
//                   isPrimary ? "FOR\nDEVS" : "FOR\nBIZ",
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.w900,
//                     color: Colors.white,
//                     height: 1,
//                   ),
//                 ),
//                 const Spacer(),
//                 const Text(
//                   "Explore details",
//                   style: TextStyle(color: Colors.white30, fontSize: 12),
//                 ),
//                 const SizedBox(height: 8),
//                 Container(
//                   height: 2,
//                   width: 40,
//                   color: AppTheme.primaryGreen,
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }