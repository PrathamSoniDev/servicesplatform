import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/features/web/presentation/home/hero_section.dart';
import 'package:servicesplatform/features/web/widgets/top_nav_bar.dart';
import '../../models/blog_model.dart';
import '../../utils/responsive.dart';
import '../../widgets/blog_card.dart';

class BlogDetailScreen extends StatefulWidget {
  final BlogModel? blog;

  const BlogDetailScreen({super.key, this.blog});

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  double _scrollProgress = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        if (_scrollController.hasClients) {
          _scrollProgress = (_scrollController.offset / _scrollController.position.maxScrollExtent).clamp(0.0, 1.0);
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.blog == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Color(0xFF8B5CF6))),
      );
    }

    final bool isMobile = Responsive.isMobile(context);
    final bool isTablet = Responsive.isTablet(context);
    final double width = MediaQuery.of(context).size.width;
    
    // Pro-level spacing and width constraints
    final double horizontalPadding = isMobile ? 20 : (isTablet ? 60 : width * 0.15);
    final String date = DateFormat("MMMM dd, yyyy").format(widget.blog!.publishedAt);

    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // 1. TOP NAVIGATION
                TopNavBar(
                  activeIndex: 4,
                  onHome: () => context.go('/home'),
                  onBlog: () => context.go('/blog'),
                  onDesigns: () {},
                  onAbout: () {},
                  onTestimonials: () {},
                  onContact: () {},
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: isMobile ? 20 : 60,
                  ),
                  child: Column(
                    children: [
                      // 2. METADATA BAR (Improved Adaptive Layout)
                      _buildPremiumTopBar(context, widget.blog!, date, isMobile, isTablet),
                      
                      SizedBox(height: isMobile ? 30 : 60),

                      // 3. MAIN HERO SECTION (Added border radius for premium feel)
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(isMobile ? 12 : 24),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF8B5CF6).withOpacity(0.08),
                              blurRadius: 100,
                              spreadRadius: 20,
                            )
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(isMobile ? 12 : 24),
                          child: Hero(
                            tag: 'blog_image_${widget.blog!.id}',
                            child: HeroSection(
                              title: widget.blog!.title,
                              subtitle: widget.blog!.description,
                              imagePath: widget.blog!.imageUrl,
                              featuredText: "FEATURED ARTICLE",
                              featuredColor: const Color(0xFF8B5CF6),
                              showNavigationArrows: false,
                              isOverlayMode: false,
                              contentAlignment: isMobile ? HeroContentAlignment.center : HeroContentAlignment.start,
                              customButtons: const [],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: isMobile ? 40 : 100),

                      // 4. MAIN ARTICLE CONTENT (Max width constrained for readability)
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 850),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildPremiumBlogContent(widget.blog!, isMobile),
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

                      // 5. TRENDING TOPICS HEADER
                      _buildSectionHeader(context, "READ MORE", "Trending for you", isMobile),

                      const SizedBox(height: 50),

                      // 6. FEATURED GRID
                      _buildFeaturedGrid(context, width, isMobile, isTablet),
                      
                      SizedBox(height: isMobile ? 60 : 120),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 7. READING PROGRESS BAR (Professional Touch)
          Positioned(
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
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumTopBar(BuildContext context, BlogModel blog, String date, bool isMobile, bool isTablet) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => context.pop(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.arrow_back_ios_new, color: Colors.white70, size: 12),
                  const SizedBox(width: 8),
                  Text("BACK TO BLOG", 
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7), 
                      letterSpacing: 2, 
                      fontSize: 10, 
                      fontWeight: FontWeight.w900
                    )
                  ),
                ],
              ),
            ),
            if (!isMobile) _metaChip(blog.category.toUpperCase()),
          ],
        ),
        if (isMobile) const SizedBox(height: 25),
        if (isMobile) _metaChip(blog.category.toUpperCase()),
        
        const SizedBox(height: 20),
        
        // Author and Date info line
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
                  backgroundImage: NetworkImage("https://ui-avatars.com/api/?name=${blog.authorName}&background=8B5CF6&color=fff"),
                ),
                const SizedBox(width: 10),
                Text(blog.authorName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
              ],
            ),
            _verticalDivider(),
            _metaText("${blog.readMinutes} MIN READ"),
            _verticalDivider(),
            _metaText(date.toUpperCase()),
          ],
        ),
      ],
    );
  }

  Widget _verticalDivider() => Container(
    height: 12, width: 1,
    color: Colors.white24,
  );

  Widget _metaChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF8B5CF6).withOpacity(0.1),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: const Color(0xFF8B5CF6).withOpacity(0.3)),
      ),
      child: Text(text, style: const TextStyle(color: Color(0xFFC4B5FD), fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
    );
  }

  Widget _metaText(String text) => Text(text, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 0.5));

  Widget _buildPremiumBlogContent(BlogModel blog, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          blog.description,
          style: TextStyle(
            color: Colors.white,
            fontSize: isMobile ? 20 : 26,
            height: 1.5,
            fontWeight: FontWeight.w400,
            fontFamily: 'Outfit',
          ),
        ),
        const SizedBox(height: 40),
        Text(
          "In today's fast-paced digital landscape, staying ahead requires more than just tools; it requires a vision. Our latest exploration into design systems reveals how the intersection of aesthetics and functionality creates a seamless user journey.",
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: isMobile ? 16 : 18,
            height: 1.8,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 30),
        Text(
          "Great design is not just what it looks like and feels like. Design is how it works. By implementing scalable architectures, we empower creators to build faster and more consistently than ever before.",
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: isMobile ? 16 : 18,
            height: 1.8,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String tag, String title, bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tag, style: const TextStyle(color: Color(0xFF8B5CF6), fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 3)),
              const SizedBox(height: 12),
              Text(title, style: TextStyle(color: Colors.white, fontSize: isMobile ? 28 : 42, fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
            ],
          ),
        ),
        if (!isMobile)
          OutlinedButton(
            onPressed: () => context.go('/blog'),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white10),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("EXPLORE ALL", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
          ),
      ],
    );
  }

  Widget _buildSocialActionsRow(bool isMobile) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _premiumIconButton(Icons.favorite_outline, "456K", "LIKES"),
          const SizedBox(width: 40),
          _premiumIconButton(Icons.remove_red_eye_outlined, "888", "VIEWS"),
          const SizedBox(width: 40),
          _premiumIconButton(Icons.ios_share, "SHARE", "ARTICLE"),
          const SizedBox(width: 40),
          _premiumIconButton(Icons.bookmark_outline, "SAVE", "LATER"),
        ],
      ),
    );
  }

  Widget _premiumIconButton(IconData icon, String value, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF8B5CF6).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFF8B5CF6), size: 18),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
            Text(label, style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
          ],
        )
      ],
    );
  }

  Widget _buildFeaturedGrid(BuildContext context, double width, bool isMobile, bool isTablet) {
    int crossAxisCount = width >= 1100 ? 3 : (width >= 750 ? 2 : 1);
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        childAspectRatio: isMobile ? 0.9 : 0.85,
      ),
      itemBuilder: (_, index) {
        final trendingBlog = BlogModel(
          id: "feat_$index",
          title: "Design Systems 2025",
          description: "Explore popular designs crafted with precision.",
          imageUrl: "https://images.unsplash.com/photo-1552664730-d307ca884978",
          category: "DESIGN",
          authorName: "Alex Rivera",
          publishedAt: DateTime.now(),
          readMinutes: 5,
        );
        return BlogCard(
          blog: trendingBlog,
          onTap: () => context.push('/blog/feat_$index', extra: trendingBlog),
        );
      },
    );
  }
}