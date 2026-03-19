import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/widgets/blog_card.dart'; // Ensure this is imported
import 'blog_detail_screen.dart';

class AllBlogsScreen extends StatelessWidget {
  const AllBlogsScreen({super.key});

  void openBlog(BuildContext context, String title, String category) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, _) => FadeTransition(
          opacity: animation,
          child: BlogDetailScreen(title: title, category: category),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final padding = Responsive.pagePadding(context);

    return Scaffold(
      // DARK BACKGROUND
      backgroundColor: AppTheme.darkBackground, 
      appBar: AppBar(
        backgroundColor: AppTheme.darkBackground.withOpacity(0.8),
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Insights & News", 
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 60, horizontal: padding),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Our Blog",
                  style: TextStyle(
                    fontSize: 56, 
                    fontWeight: FontWeight.w900, 
                    letterSpacing: -2,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Deep dives into engineering, AI, and business growth.", 
                  style: TextStyle(color: Colors.white70, fontSize: 18, height: 1.5)
                ),
                const SizedBox(height: 60),
                
                // BLOG GRID
                Wrap(
                  spacing: 30,
                  runSpacing: 40, // More space for the glow effect
                  alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
                  children: [
                    _buildGridItem(context, "The Future of GenAI in Coding", "TECHNOLOGY"),
                    _buildGridItem(context, "How to Scale Engineering Teams", "BUSINESS"),
                    _buildGridItem(context, "Security Protocols for 2026", "SECURITY"),
                    _buildGridItem(context, "The Rise of No-Code Architecture", "TRENDS"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// This helper ensures every BlogCard is EXACTLY the same size
  Widget _buildGridItem(BuildContext context, String title, String category) {
    final isMobile = Responsive.isMobile(context);
    
    return SizedBox(
      width: isMobile ? double.infinity : 360,
      // Fixed height ensures all cards align perfectly in a row
      height: 420, 
      child: BlogCard(
        title: title,
        category: category,
        onTap: () => openBlog(context, title, category),
      ),
    );
  }
}