import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/presentation/home/all_blog_screen.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/widgets/blog_card.dart';
import 'blog_detail_screen.dart';

class BlogItem {
  final String title;
  final String category;
  BlogItem({required this.title, required this.category});
}

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  static final List<BlogItem> featuredBlogs = [
    BlogItem(title: "How AI is Transforming Development", category: "AI Development"),
    BlogItem(title: "The Future of Cloud Computing", category: "Cloud"),
    BlogItem(title: "UI/UX Trends to Watch in 2026", category: "Design"),
  ];

  void openBlogDetail(BuildContext context, BlogItem blog) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, _) => FadeTransition(
          opacity: animation,
          child: BlogDetailScreen(title: blog.title, category: blog.category),
        ),
      ),
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
          _buildHeader(context),
          SizedBox(height: isMobile ? 30 : 50),
          isMobile
              ? SizedBox(height: 400, child: _buildMobileScroll(context))
              : _buildDesktopGrid(context),
          const SizedBox(height: 50),
          _viewMoreButton(context),
        ],
      ),
    );
  }

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
              ),
        ),
      ],
    );
  }

  Widget _buildDesktopGrid(BuildContext context) {
    return Wrap(
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
    );
  }

  Widget _buildMobileScroll(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: featuredBlogs.length,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (context, index) {
        final blog = featuredBlogs[index];
        return Padding(
          padding: const EdgeInsets.only(right: 16),
          child: SizedBox(
            width: 300,
            child: BlogCard(
              title: blog.title,
              category: blog.category,
              onTap: () => openBlogDetail(context, blog),
            ),
          ),
        );
      },
    );
  }

  Widget _viewMoreButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AllBlogsScreen()),
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppTheme.textBlack,
        side: const BorderSide(color: AppTheme.borderLight, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "View All Articles",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textBlack,
                ),
          ),
          const SizedBox(width: 12),
          const Icon(
            Icons.arrow_forward_rounded,
            color: AppTheme.primaryGreen,
            size: 22,
          ),
        ],
      ),
    );
  }
}