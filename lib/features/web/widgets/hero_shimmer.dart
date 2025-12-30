import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/responsive.dart';

class HeroShimmer extends StatelessWidget {
  const HeroShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 60,
        vertical: 60,
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade800,
        highlightColor: Colors.grey.shade700,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 48, width: 280, color: Colors.white),
            const SizedBox(height: 24),
            Container(height: 20, width: double.infinity, color: Colors.white),
            const SizedBox(height: 12),
            Container(height: 20, width: 200, color: Colors.white),
            const SizedBox(height: 40),
            Container(height: 300, width: double.infinity, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
