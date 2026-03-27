import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/widgets/blog_card.dart';

class BlogItem {
  final String title;
  final String category;
  BlogItem({required this.title, required this.category});
}

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final ScrollController _scrollController = ScrollController();

  static final List<BlogItem> featuredBlogs = [
    BlogItem(title: "How AI is Transforming Development", category: "AI Development"),
    BlogItem(title: "The Future of Cloud Computing", category: "Cloud"),
    BlogItem(title: "UI/UX Trends to Watch in 2026", category: "Design"),
    BlogItem(title: "Cybersecurity in the GenAI Era", category: "Security"),
    BlogItem(title: "Building Scalable Flutter Web Apps", category: "Flutter"),
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scroll(bool isLeft, double constraintsWidth) {
    // Dynamically calculate scroll based on 80% of current viewport width
    double scrollAmount = constraintsWidth * 0.8;
    _scrollController.animateTo(
      isLeft
          ? (_scrollController.offset - scrollAmount).clamp(0, _scrollController.position.maxScrollExtent)
          : (_scrollController.offset + scrollAmount).clamp(0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
  }

  void openBlogDetail(BuildContext context, BlogItem blog) {
    final slug = blog.title.toLowerCase().replaceAll(' ', '-');
    context.go(
      '/blog/detail/$slug?category=${Uri.encodeComponent(blog.category)}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppTheme.bgOffWhite,
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 40),

              // Header - FittedBox prevents text overflow on very narrow screens
              FittedBox(
                fit: BoxFit.scaleDown,
                child: _buildHeader(context),
              ),

              const Spacer(flex: 1),

              // Horizontal Scroll Area
              Flexible(
                flex: 10,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    _buildHorizontalScroll(context, constraints.maxWidth),

                    // Left Arrow
                    Positioned(
                      left: 0,
                      child: _buildArrowButton(
                        Icons.arrow_back_ios_new_rounded,
                        () => _scroll(true, constraints.maxWidth),
                        isMobile,
                      ),
                    ),

                    // Right Arrow
                    Positioned(
                      right: 0,
                      child: _buildArrowButton(
                        Icons.arrow_forward_ios_rounded,
                        () => _scroll(false, constraints.maxWidth),
                        isMobile,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 1),

              // View More Button
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: _viewMoreButton(context),
              ),
            ],
          );
        },
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
                fontSize: 14,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          "Latest from our Blog",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AppTheme.textBlack,
                fontSize: Responsive.isMobile(context) ? 28 : 44,
                fontWeight: FontWeight.w900,
              ),
        ),
      ],
    );
  }

  Widget _buildHorizontalScroll(BuildContext context, double maxWidth) {
    final isMobile = Responsive.isMobile(context);
    // Dynamic width per card: Mobile takes most of screen, Desktop shows multiple
    final cardWidth = isMobile ? maxWidth * 0.75 : 360.0;

    return ListView.builder(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      itemCount: featuredBlogs.length,
      physics: const BouncingScrollPhysics(),
      // Added padding so arrows don't sit directly on the first/last card
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      itemBuilder: (context, index) {
        final blog = featuredBlogs[index];
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 24),
            child: SizedBox(
              width: cardWidth,
              // Constraint to ensure the card doesn't exceed its parent height
              child: BlogCard(
                title: blog.title,
                category: blog.category,
                onTap: () => openBlogDetail(context, blog),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildArrowButton(IconData icon, VoidCallback onPressed, bool isMobile) {
    return Material(
      color: Colors.white.withOpacity(0.95),
      shape: const CircleBorder(),
      elevation: 4,
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Container(
          padding: EdgeInsets.all(isMobile ? 10 : 14),
          child: Icon(
            icon,
            size: isMobile ? 16 : 20,
            color: AppTheme.textBlack,
          ),
        ),
      ),
    );
  }

  Widget _viewMoreButton(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: OutlinedButton(
        onPressed: () {
          final currentLocation = GoRouterState.of(context).uri.toString();
          if (currentLocation == '/blog/all') return;
          context.go('/blog/all');
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: AppTheme.textBlack,
          side: const BorderSide(color: AppTheme.borderLight, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "View All Articles",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.textBlack,
              ),
            ),
            SizedBox(width: 12),
            Icon(
              Icons.arrow_forward_rounded,
              color: AppTheme.primaryGreen,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}