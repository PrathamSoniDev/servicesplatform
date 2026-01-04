import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../models/blog_model.dart';
import '../../widgets/blog_card.dart';
import '../../widgets/button.dart';
import '../../widgets/custom_text.dart';

class BlogSection extends StatelessWidget {
  const BlogSection({super.key});

  int _getCrossAxisCount(double width) {
    if (width >= 1200) return 3;
    if (width >= 800) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    final blogs = [
      BlogModel(
        id: "1",
        title: "The Future of AI",
        description:
            "Explore our most popular designs crafted with precision and creativity.",
        imageUrl:
            "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f",
        category: "ED-Tech",
        authorName: "Admin",
        publishedAt: DateTime(2025, 12, 24),
        readMinutes: 3,
      ),
      BlogModel(
        id: "2",
        title: "UI/UX Trends",
        description:
            "Explore our most popular designs crafted with precision and creativity.",
        imageUrl:
            "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f",
        category: "Design",
        authorName: "Admin",
        publishedAt: DateTime(2025, 12, 24),
        readMinutes: 3,
      ),
      BlogModel(
        id: "3",
        title: "Flutter Mastery",
        description:
            "Explore our most popular designs crafted with precision and creativity.",
        imageUrl:
            "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f",
        category: "Development",
        authorName: "Admin",
        publishedAt: DateTime(2025, 12, 24),
        readMinutes: 3,
      ),
    ];

    return Container(
      width: double.infinity,
      color: Colors.black,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 120,
        vertical: 90,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(
            text: "Our Blogs",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          CustomText(
            text: "Stay updated with the latest trends and insights.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.grey.shade400),
          ),
          const SizedBox(height: 60),

          // Using GridView.builder with shrinkWrap
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: blogs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _getCrossAxisCount(width),
              crossAxisSpacing: 28,
              mainAxisSpacing: 28,
              childAspectRatio: 0.78,
            ),
            itemBuilder: (context, index) {
              final currentBlog = blogs[index];
              return BlogCard(
                blog: currentBlog,
                onTap:
                    () => context.go(
                      '/blog/${currentBlog.id}',
                      extra: currentBlog,
                    ),
              );
            },
          ),

          const SizedBox(height: 60),

          // --- THE BUTTON ---
          AppButton(
            text: "Explore More",
            onPressed: () {
              // DEBUG: Check your console. If this doesn't print,
              // the button is being covered by another widget.
              debugPrint("Explore More clicked!");

              // Try using .go instead of .push if /blog is a top-level route
              context.go('/blog');
            },
            type: AppButtonType.solid,
            color: Theme.of(context).colorScheme.primary,
            textColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
            enableGlow: true,
          ),
        ],
      ),
    );
  }
}
