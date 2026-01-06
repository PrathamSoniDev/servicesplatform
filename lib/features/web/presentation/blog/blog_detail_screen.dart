import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:servicesplatform/core/app_router.dart';
import 'package:servicesplatform/features/web/presentation/home/hero_section.dart';
import 'package:servicesplatform/features/web/widgets/top_nav_bar.dart';

import '../../../../models/blog_model.dart';
import '../../utils/responsive.dart';
import '../../widgets/blog_card.dart';

class BlogDetailScreen extends StatefulWidget {
  final BlogModel? blog;
  final String? id; // ADDED: ID parameter to handle web refreshes

  const BlogDetailScreen({super.key, this.blog, this.id});

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  double _scrollProgress = 0;
  BlogModel? _currentBlog;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeBlog();
    _scrollController.addListener(_updateScrollProgress);
  }

  void _initializeBlog() {
    if (widget.blog != null) {
      _currentBlog = widget.blog;
      _isLoading = false;
    } else {
      // Logic for Web Refresh: Fetch blog by ID if extra is null
      _fetchBlogById();
    }
  }

  Future<void> _fetchBlogById() async {
    setState(() => _isLoading = true);

    // Simulate API/Repository call
    await Future.delayed(const Duration(milliseconds: 800));

    // REPLACE THIS: Call your actual repository here
    // Example: _currentBlog = await blogRepository.getById(widget.id);
    _currentBlog = BlogModel(
      id: widget.id ?? "1",
      title: "How to Scale your Business ${widget.id}",
      shortDescription:
          "This data was fetched because you refreshed the browser!",
      placeholderImage:
          "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f",
      categoryId: "Marketing",
      author: "John Doe",
      createdAt: DateTime.now(),
      readingTime: 3,
      categoryName: "",
    );

    if (mounted) setState(() => _isLoading = false);
  }

  void _updateScrollProgress() {
    if (_scrollController.hasClients) {
      double progress = (_scrollController.offset /
              _scrollController.position.maxScrollExtent)
          .clamp(0.0, 1.0);
      if (progress != _scrollProgress) {
        setState(() => _scrollProgress = progress);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateScrollProgress);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF080808),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF8B5CF6)),
        ),
      );
    }

    if (_currentBlog == null) {
      return Scaffold(
        backgroundColor: const Color(0xFF080808),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Blog not found",
                style: TextStyle(color: Colors.white),
              ),
              TextButton(
                onPressed: () => context.go('/blog'),
                child: const Text("Go Back"),
              ),
            ],
          ),
        ),
      );
    }

    final bool isMobile = Responsive.isMobile(context);
    final bool isTablet = Responsive.isTablet(context);
    final double width = MediaQuery.of(context).size.width;
    final double horizontalPadding = isMobile ? 20 : (isTablet ? 60 : 40);
    final String date = DateFormat(
      "MMMM dd, yyyy",
    ).format(_currentBlog!.createdAt);

    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                TopNavBar(
                  activeIndex: 4,
                  onHome: () => context.go(AppRouter.home),
                  onBlog: () => context.pushNamed(AppRouter.blog),
                  onDesigns: () => context.pushNamed(AppRouter.designs),
                  onAbout: () => context.pushNamed(AppRouter.aboutUs),
                  onTestimonials: () {},
                  onContact: () => context.pushNamed(AppRouter.contact),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: isMobile ? 20 : 60,
                  ),
                  child: Column(
                    children: [
                      _buildPremiumTopBar(
                        context,
                        _currentBlog!,
                        date,
                        isMobile,
                        isTablet,
                      ),
                      SizedBox(height: isMobile ? 30 : 60),
                      _buildMainImage(_currentBlog!, isMobile),
                      SizedBox(height: isMobile ? 40 : 100),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 850),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildPremiumBlogContent(_currentBlog!, isMobile),
                            const SizedBox(height: 60),
                            const Divider(color: Colors.white10, thickness: 1),
                            const SizedBox(height: 30),
                            _buildSocialActionsRow(isMobile),
                            const SizedBox(height: 30),
                            const Divider(color: Colors.white10, thickness: 1),
                          ],
                        ),
                      ),
                      SizedBox(height: isMobile ? 80 : 140),
                      _buildSectionHeader(
                        context,
                        "READ MORE",
                        "Trending for you",
                        isMobile,
                      ),
                      const SizedBox(height: 50),
                      _buildFeaturedGrid(context, width, isMobile, isTablet),
                      SizedBox(height: isMobile ? 60 : 120),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildReadingProgressBar(),
        ],
      ),
    );
  }

  Widget _buildMainImage(BlogModel blog, bool isMobile) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isMobile ? 12 : 24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B5CF6).withOpacity(0.08),
            blurRadius: 100,
            spreadRadius: 20,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isMobile ? 12 : 24),
        child: Hero(
          tag: 'blog_image_${blog.id}',
          child: HeroSection(
            title: blog.title,
            subtitle: blog.shortDescription,
            imagePath: blog.placeholderImage,
            featuredText: "FEATURED ARTICLE",
            featuredColor: const Color(0xFF8B5CF6),
            showNavigationArrows: false,
            isOverlayMode: false,
            contentAlignment:
                isMobile
                    ? HeroContentAlignment.center
                    : HeroContentAlignment.start,
            customButtons: const [],
          ),
        ),
      ),
    );
  }

  Widget _buildReadingProgressBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 3,
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: _scrollProgress,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF8B5CF6), Color(0xFFD8B4FE)],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ... (Keep your _buildPremiumTopBar, _metaChip, _metaText, _premiumIconButton, etc. from your original code)
  // Just ensure they use 'blog' or '_currentBlog' correctly.

  Widget _buildPremiumTopBar(
    BuildContext context,
    BlogModel blog,
    String date,
    bool isMobile,
    bool isTablet,
  ) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              isMobile
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap:
                  () => context.canPop() ? context.pop() : context.go('/blog'),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white70,
                    size: 12,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "BACK TO BLOG",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      letterSpacing: 2,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            if (!isMobile) _metaChip(blog.categoryId.toUpperCase()),
          ],
        ),
        if (isMobile) const SizedBox(height: 25),
        if (isMobile) _metaChip(blog.categoryId.toUpperCase()),
        const SizedBox(height: 20),
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 15,
          runSpacing: 10,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: const Color(0xFF8B5CF6),
                  backgroundImage: NetworkImage(
                    "https://ui-avatars.com/api/?name=${blog.author}&background=8B5CF6&color=fff",
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  blog.author,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            _verticalDivider(),
            _metaText("${blog.readingTime} MIN READ"),
            _verticalDivider(),
            _metaText(date.toUpperCase()),
          ],
        ),
      ],
    );
  }

  Widget _verticalDivider() =>
      Container(height: 12, width: 1, color: Colors.white24);

  Widget _metaChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF8B5CF6).withOpacity(0.1),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: const Color(0xFF8B5CF6).withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFFC4B5FD),
          fontSize: 10,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _metaText(String text) => Text(
    text,
    style: TextStyle(
      color: Colors.white.withOpacity(0.4),
      fontSize: 11,
      fontWeight: FontWeight.w800,
      letterSpacing: 0.5,
    ),
  );

  Widget _buildPremiumBlogContent(BlogModel blog, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          blog.shortDescription,
          style: TextStyle(
            color: Colors.white,
            fontSize: isMobile ? 20 : 26,
            height: 1.5,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 40),
        _paragraphText(
          "In today's fast-paced digital landscape, staying ahead requires vision. Great design is not just what it looks like, it is how it works.",
        ),
        const SizedBox(height: 30),
        _paragraphText(
          "By implementing scalable architectures, we empower creators to build faster and more consistently than ever before.",
        ),
      ],
    );
  }

  Widget _paragraphText(String text) => Text(
    text,
    style: TextStyle(
      color: Colors.white.withOpacity(0.6),
      fontSize: 18,
      height: 1.8,
    ),
  );

  Widget _buildSectionHeader(
    BuildContext context,
    String tag,
    String title,
    bool isMobile,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tag,
              style: const TextStyle(
                color: Color(0xFF8B5CF6),
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 3,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 28 : 42,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialActionsRow(bool isMobile) {
    return Row(
      children: [
        _premiumIconButton(Icons.favorite_outline, "456K", "LIKES"),
        const SizedBox(width: 40),
        _premiumIconButton(Icons.ios_share, "SHARE", "ARTICLE"),
      ],
    );
  }

  Widget _premiumIconButton(IconData icon, String value, String label) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF8B5CF6), size: 18),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.3),
                fontSize: 9,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeaturedGrid(
    BuildContext context,
    double width,
    bool isMobile,
    bool isTablet,
  ) {
    int count = width >= 1100 ? 3 : (width >= 750 ? 2 : 1);
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: count,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (_, index) {
        final blog = BlogModel(
          id: "feat_$index",
          title: "Trending Post $index",
          shortDescription: "Summary of the trending content.",
          placeholderImage:
              "https://images.unsplash.com/photo-1552664730-d307ca884978",
          categoryId: "DESIGN",
          author: "Alex Rivera",
          createdAt: DateTime.now(),
          readingTime: 5,
          categoryName: "",
        );
        return BlogCard(
          blog: blog,
          onTap: () => context.push('/blog/${blog.id}', extra: blog),
        );
      },
    );
  }
}
