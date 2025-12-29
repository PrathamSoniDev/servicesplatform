import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/blog_model.dart';
import '../../widgets/blog_card.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/button.dart'; 

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
        title: "Blog post title",
        description: "Explore our most popular designs crafted with precision and creativity to meet diverse business needs.",
        imageUrl: "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f",
        category: "ED-Tech",
        authorName: "Name",
        publishedAt: DateTime(2025, 12, 24),
        readMinutes: 3,
      ),
      BlogModel(
        id: "2",
        title: "Blog post title",
        description: "Explore our most popular designs crafted with precision and creativity to meet diverse business needs.",
        imageUrl: "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f",
        category: "ED-Tech",
        authorName: "Name",
        publishedAt: DateTime(2025, 12, 24),
        readMinutes: 3,
      ),
      BlogModel(
        id: "3",
        title: "Blog post title",
        description: "Explore our most popular designs crafted with precision and creativity to meet diverse business needs.",
        imageUrl: "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f",
        category: "ED-Tech",
        authorName: "Name",
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
            text: "Stay updated with the latest trends and insights in the digital world.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.grey.shade400),
          ),
          const SizedBox(height: 60),

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
            itemBuilder: (_, index) {
              final currentBlog = blogs[index]; // Reference the specific blog
              return RepaintBoundary(
                child: BlogCard(
                  blog: currentBlog,
                  onTap: () {
                    // IMPLEMENTED: Navigate to detail screen using the blog ID
                    // and pass the blog object so the detail screen has the data immediately
                    context.go('/blog/${currentBlog.id}', extra: currentBlog);
                  },
                ),
              );
            },
          ),

          const SizedBox(height: 60),
          AppButton(
            text: "Explore More",
            onPressed: () {
              context.push('/blog'); 
            },
            type: AppButtonType.outline,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
          ),
        ],
      ),
    );
  }
}