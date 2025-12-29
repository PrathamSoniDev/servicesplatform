import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/features/web/presentation/home/hero_section.dart';
import 'package:servicesplatform/features/web/widgets/top_nav_bar.dart';
import '../../models/blog_model.dart';
import '../../utils/responsive.dart';
import '../../widgets/blog_card.dart';

class BlogDetailScreen extends StatelessWidget {
  final BlogModel? blog;

  const BlogDetailScreen({super.key, this.blog});

  @override
  Widget build(BuildContext context) {
    if (blog == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Color(0xFF8B5CF6))),
      );
    }

    final isMobile = Responsive.isMobile(context);
    final width = MediaQuery.of(context).size.width;
    final date = DateFormat("MMMM dd, yyyy").format(blog!.publishedAt);
    final double contentWidth = isMobile ? double.infinity : 1000;

    return Scaffold(
      backgroundColor: const Color(0xFF080808), // Slightly off-black for depth
      body: SingleChildScrollView(
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
                horizontal: isMobile ? 24 : 100, // Wider padding for premium feel
                vertical: 40,
              ),
              child: Column(
                children: [
                  // 2. TOP METADATA BAR
                  _buildPremiumTopBar(context, blog!, date, isMobile),
                  const SizedBox(height: 50),

                  // 3. MAIN HERO SECTION (Framed with a soft glow)
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF8B5CF6).withOpacity(0.15),
                          blurRadius: 100,
                          spreadRadius: -20,
                        )
                      ],
                    ),
                    child: Hero(
                      tag: 'blog_image_${blog!.id}',
                      child: HeroSection(
                        title: blog!.title,
                        subtitle: blog!.description,
                        imagePath: blog!.imageUrl,
                        featuredText: "FEATURED ARTICLE",
                        featuredColor: const Color(0xFF8B5CF6),
                        showNavigationArrows: false,
                        isOverlayMode: false,
                        contentAlignment: HeroContentAlignment.center,
                        customButtons: const [],
                      ),
                    ),
                  ),

                  const SizedBox(height: 80),

                  // 4. MAIN ARTICLE CONTENT
                  Container(
                    width: contentWidth,
                    constraints: const BoxConstraints(maxWidth: 850),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPremiumBlogContent(blog!),
                        const SizedBox(height: 60),
                        const Divider(color: Colors.white10),
                        const SizedBox(height: 30),
                        _buildSocialActionsRow(),
                        const SizedBox(height: 30),
                        const Divider(color: Colors.white10),
                      ],
                    ),
                  ),

                  const SizedBox(height: 120),

                  // 5. TRENDING TOPICS HEADER
                  _buildSectionHeader(context, "TRENDING TOPICS", "Featured Articles"),

                  const SizedBox(height: 50),

                  // 6. FEATURED GRID
                  _buildFeaturedGrid(context, width, isMobile),
                  
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumTopBar(BuildContext context, BlogModel blog, String date, bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Back Button with animated underline style
        InkWell(
          onTap: () => context.pop(),
          child: Row(
            children: [
              const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 14),
              const SizedBox(width: 8),
              Text(
                "BACK TO BLOG",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  letterSpacing: 1.5,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        if (!isMobile)
          Row(
            children: [
              _metaChip(blog.category.toUpperCase()),
              _verticalDivider(),
              _metaText("${blog.readMinutes} MIN READ"),
              _verticalDivider(),
              _metaText(date.toUpperCase()),
            ],
          ),
        // Author Profile
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Text(
                blog.authorName,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
              ),
              const SizedBox(width: 10),
              CircleAvatar(
                radius: 14,
                backgroundColor: const Color(0xFF8B5CF6),
                backgroundImage: const NetworkImage("https://ui-avatars.com/api/?background=8B5CF6&color=fff"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _verticalDivider() => Container(
    height: 15,
    width: 1,
    margin: const EdgeInsets.symmetric(horizontal: 20),
    color: Colors.white24,
  );

  Widget _metaChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          const Color(0xFF8B5CF6).withOpacity(0.2),
          const Color(0xFF8B5CF6).withOpacity(0.05),
        ]),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFF8B5CF6).withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Color(0xFFC4B5FD), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1),
      ),
    );
  }

  Widget _metaText(String text) => Text(
    text,
    style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1),
  );

  Widget _buildPremiumBlogContent(BlogModel blog) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Drop cap style or lead paragraph
        Text(
          blog.description,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 20,
            height: 1.8,
            fontWeight: FontWeight.w300,
            fontFamily: 'Outfit',
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 40),
        // Placeholder for body text to show layout
        Text(
          "In today's fast-paced digital landscape, staying ahead requires more than just tools; it requires a vision. Our latest exploration into design systems reveals how the intersection of aesthetics and functionality creates a seamless user journey.",
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 18,
            height: 1.8,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String tag, String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tag,
              style: const TextStyle(color: Colors.orange, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 2),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.bold, fontFamily: 'Outfit'),
            ),
          ],
        ),
        // Premium "See More" Button
        TextButton(
          onPressed: () => context.go('/blog'),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            side: const BorderSide(color: Colors.white24),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          ),
          child: const Row(
            children: [
              Text("VIEW ALL ARTICLES", style: TextStyle(color: Colors.white, fontSize: 12, letterSpacing: 2, fontWeight: FontWeight.bold)),
              SizedBox(width: 10),
              Icon(Icons.arrow_forward, color: Colors.white, size: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialActionsRow() {
    return Wrap(
      spacing: 40,
      runSpacing: 20,
      children: [
        _premiumIconButton(Icons.favorite_outline, "456K", "LIKES"),
        _premiumIconButton(Icons.remove_red_eye_outlined, "888", "VIEWS"),
        _premiumIconButton(Icons.ios_share, "SHARE", "ARTICLE"),
        _premiumIconButton(Icons.bookmark_outline, "SAVE", "LATER"),
      ],
    );
  }

  Widget _premiumIconButton(IconData icon, String value, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: const Color(0xFF8B5CF6), size: 20),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
            Text(label, style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 10, fontWeight: FontWeight.bold)),
          ],
        )
      ],
    );
  }

  Widget _buildFeaturedGrid(BuildContext context, double width, bool isMobile) {
    int crossAxisCount = width >= 1100 ? 3 : (width >= 700 ? 2 : 1);
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        childAspectRatio: isMobile ? 0.9 : 0.82,
      ),
      itemBuilder: (_, index) {
        final trendingBlog = BlogModel(
          id: "feat_$index",
          title: "The Future of Design Systems in 2025",
          description: "Explore our most popular designs crafted with precision and creativity.",
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