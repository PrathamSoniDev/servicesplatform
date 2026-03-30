import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/presentation/home/all_blog_screen.dart';
import 'package:servicesplatform/features/web/presentation/home/blog_detail_screen.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/widgets/blog_card.dart';

/// Simple model to handle blog data consistently
class BlogItem {
  final String title;
  final String category;
  BlogItem({required this.title, required this.category});
}

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  /// Mock data for the section
  static final List<BlogItem> featuredBlogs = [
    BlogItem(title: "How AI is Transforming Development", category: "AI Development"),
    BlogItem(title: "The Future of Cloud Computing", category: "Cloud"),
    BlogItem(title: "UI/UX Trends to Watch in 2026", category: "Design"),
  ];

  /// Navigates to a specific blog's detail view
  void openBlogDetail(BuildContext context, BlogItem blog) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, _) => FadeTransition(
          opacity: animation,
          child: BlogDetailScreen(
            title: blog.title,
            category: blog.category,
          ),
        ),
      ),
    );
  }

  /// Navigates to the library of all blogs
  void openAllBlogs(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AllBlogsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      color: AppTheme.bgOffWhite,
      padding: EdgeInsets.symmetric(
        horizontal: padding,
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        children: [
          /// HEADER SECTION
          _buildHeader(context),

          SizedBox(height: isMobile ? 30 : 50),

          /// BLOG CARDS SECTION
          isMobile
              ? SizedBox(height: 420, child: _buildMobileScroll(context))
              : _buildDesktopGrid(context),

          const SizedBox(height: 50),

          /// VIEW MORE BUTTON
          _viewMoreButton(context),
        ],
      ),
    );
  }

  /// HEADER
  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Text(
          "INSIGHTS & INNOVATIONS",
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppTheme.primaryGreen,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Text(
          "Latest from our Blog",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AppTheme.textBlack,
                fontSize: Responsive.isMobile(context) ? 32 : 48,
                fontWeight: FontWeight.w900,
                letterSpacing: -1.5,
              ),
        ),
      ],
    );
  }

  /// DESKTOP GRID (3 Cards)
  Widget _buildDesktopGrid(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 30,
        runSpacing: 30,
        alignment: WrapAlignment.center,
        children: featuredBlogs.map((blog) {
          return SizedBox(
            width: 360,
            child: BlogCard(
              title: blog.title,
              category: blog.category,
              onTap: () => openBlogDetail(context, blog),
              customHeight: 400,
            ),
          );
        }).toList(),
      ),
    );
  }

  /// MOBILE HORIZONTAL SCROLL
  Widget _buildMobileScroll(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: featuredBlogs.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (context, index) {
        final blog = featuredBlogs[index];
        return Padding(
          padding: const EdgeInsets.only(right: 16, bottom: 20),
          child: SizedBox(
            width: 300,
            child: BlogCard(
              title: blog.title,
              category: blog.category,
              onTap: () => openBlogDetail(context, blog), customHeight: 400,
            ),
          ),
        );
      },
    );
  }

  /// VIEW ALL BUTTON
  Widget _viewMoreButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () => openAllBlogs(context),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppTheme.textBlack,
        side: const BorderSide(color: AppTheme.borderLight, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.transparent,
      ).copyWith(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.hovered)) {
            return AppTheme.textBlack.withOpacity(0.05);
          }
          return null;
        }),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "View All Articles",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 12),
          Icon(Icons.arrow_forward_rounded, color: AppTheme.primaryGreen, size: 22),
        ],
      ),
    );
  }
}