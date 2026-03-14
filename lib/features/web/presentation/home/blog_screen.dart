import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';
import 'package:servicesplatform/features/web/widgets/blog_card.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      // Switched back to Off-White
      color: const Color(0xFFF7F7F7), 
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Insights & Innovations",
            style: TextStyle(
              color: Colors.green.shade700, // Slightly darker green for light BG readability
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Latest from our Blog",
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 60),

          /// 3 CARDS CENTERED
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: List.generate(3, (index) {
              return SizedBox(
                width: isMobile ? double.infinity : 380, // Slightly wider for better spacing
                child: const BlogCard(),
              );
            }),
          ),

          const SizedBox(height: 60),

          /// VIEW MORE BUTTON
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(foregroundColor: Colors.black),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "View More Articles",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                Icon(Icons.arrow_forward_rounded, color: Colors.green.shade600, size: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}