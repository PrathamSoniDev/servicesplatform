import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/features/web/presentation/designs/design_overlay_screen.dart';
import 'package:servicesplatform/features/web/widgets/blog_card.dart';
import 'package:servicesplatform/features/web/widgets/design_lux_card.dart';
import 'package:servicesplatform/features/web/widgets/prodile_tab_bar.dart';
import 'package:servicesplatform/features/web/widgets/top_nav_bar.dart';
import 'package:servicesplatform/models/blog_model.dart';
import 'package:servicesplatform/models/design_item_models.dart';
import 'package:servicesplatform/models/profile_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedTabIndex = 0;
  final List<String> tabs = ["Likes", "Shared", "Recent View"];

  late final ProfileModel profile;
  late final DesignItem dummyDesign;
  late final BlogModel dummyBlog;

  @override
  void initState() {
    super.initState();
    _initializeDummyData();
  }

  void _initializeDummyData() {
    profile = ProfileModel(
      userId: "u_101",
      name: "John Doe",
      role: "Senior Product Designer",
      profileImg:
          "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=300",
      likedDesigns: List.generate(8, (i) => "design_$i"),
      recentDesigns: List.generate(6, (i) => "view_$i"),
    );

    dummyDesign = DesignItem(
      id: "d1",
      title: "Luxury App UI",
      subtitle: "Fintech Dashboard",
      bannerImage:
          "https://images.unsplash.com/photo-1558655146-d09347e92766?w=800",
      viewsCount: 1200,
      categoryName: "name",
      likesCount: 340,
      categoryId: 'design',
      images: const [],
      colors: const [],
      fonts: 'Inter',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    dummyBlog = BlogModel(
      id: "b1",
      title: "The Future of Flutter Web",
      shortDescription: "Exploring the new CanvasKit rendering engine.",
      placeholderImage:
          "https://images.unsplash.com/photo-1499750310107-5fef28a66643?w=800",
      author: "John Doe",
      readingTime: 5,
      categoryId: "tech",
      categoryName: "Tech",
      createdAt: DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 950;
    final horizontalPadding = screenWidth > 1200 ? screenWidth * 0.12 : 30.0;
    final crossAxisCount = screenWidth > 1100 ? 3 : (screenWidth > 750 ? 2 : 1);

    return Scaffold(
      backgroundColor: const Color(0xFF020202),
      body: Column(
        children: [
          /// TOP NAV BAR
          TopNavBar(
            activeIndex: 6,
            onHome: () => context.go('/'),
            onDesigns: () => context.go('/designs'),
            onAbout: () => context.go('/about'),
            onTestimonials: () => context.go('/reviews'),
            onBlog: () => context.go('/blog'),
            onContact: () => context.go('/contact'),
          ),

          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 50,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: _buildProfileHeader(isDesktop),
                  ),
                ),

                SliverPersistentHeader(
                  pinned: true,
                  delegate: _StickyTabBarDelegate(
                    child: Container(
                      color: const Color(0xFF020202),
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: 10,
                      ),
                      child: ProfileTabBar(
                        selectedIndex: selectedTabIndex,
                        tabs: tabs,
                        onTabSelected:
                            (i) => setState(() => selectedTabIndex = i),
                      ),
                    ),
                  ),
                ),

                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 30,
                  ),
                  sliver: _buildTabContent(crossAxisCount),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 80)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= TAB CONTENT =================

  Widget _buildTabContent(int crossAxisCount) {
    String designTitle = "";
    String designSub = "";
    String blogTitle = "";
    String blogSub = "";
    int designCount = 0;
    int blogCount = 0;

    switch (selectedTabIndex) {
      case 0: // Likes
        designTitle = "DESIGN INSPIRATIONS";
        designSub =
            "A collection of interfaces that set the standard for modern digital craft.";
        blogTitle = "BOOKMARKED INSIGHTS";
        blogSub =
            "Key industry perspectives and technical breakthroughs saved for reference.";
        designCount = profile.likedDesigns.length;
        blogCount = 3;
        break;
      case 1: // Shared
        designTitle = "SHARED PORTFOLIO";
        designSub =
            "Publicly showcased projects demonstrating technical and visual expertise.";
        blogTitle = "PUBLISHED ARTICLES";
        blogSub =
            "Original thoughts shared with the community on design and engineering.";
        designCount = 4;
        blogCount = 2;
        break;
      default: // Recent View
        designTitle = "RECENT ACTIVITY";
        designSub =
            "A chronological view of design patterns and concepts recently explored.";
        blogTitle = "READING HISTORY";
        blogSub =
            "Technical deep-dives and editorial content visited in your latest sessions.";
        designCount = profile.recentDesigns.length;
        blogCount = 5;
    }

    return SliverMainAxisGroup(
      slivers: [
        _buildSectionHeader(designTitle, designSub, designCount),
        _buildDesignGrid(crossAxisCount, 6),
        const SliverToBoxAdapter(child: SizedBox(height: 80)),
        _buildSectionHeader(blogTitle, blogSub, blogCount),
        _buildBlogGrid(crossAxisCount, 2),
      ],
    );
  }

  Widget _buildDesignGrid(int crossAxisCount, int count) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 25,
        mainAxisSpacing: 25,
        childAspectRatio: 0.85,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => DesignLuxuryCard(
          item: dummyDesign,
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 350),
                barrierDismissible: true,
                barrierColor: Colors.black.withOpacity(0.8),
                pageBuilder:
                    (_, __, ___) => DesignDetailOverlay(data: dummyDesign),
                transitionsBuilder: (_, animation, __, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: Tween<double>(begin: 0.98, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOut,
                        ),
                      ),
                      child: child,
                    ),
                  );
                },
              ),
            );
          },
        ),
        childCount: count,
      ),
    );
  }

  Widget _buildBlogGrid(int crossAxisCount, int count) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 25,
        mainAxisSpacing: 25,
        childAspectRatio: crossAxisCount == 1 ? 1.2 : 0.9,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => BlogCard(
          blog: dummyBlog,
          onTap: () => context.go('/blog/${dummyBlog.id}'),
        ),
        childCount: count,
      ),
    );
  }

  // ================= HEADER =================

  Widget _buildProfileHeader(bool isDesktop) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // LEFT SIDE: Profile Pic + Info
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.purpleAccent],
                ),
              ),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: const Color(0xFF020202),
                child: CircleAvatar(
                  radius: 47,
                  backgroundImage: NetworkImage(profile.profileImg ?? ""),
                ),
              ),
            ),
            if (isDesktop) ...[
              const SizedBox(width: 30),
              _buildProfileInfo(CrossAxisAlignment.start),
            ],
          ],
        ),

        // RIGHT SIDE: Stats (Only shown clearly on desktop)
        if (isDesktop)
          Row(
            children: [
              _buildHeaderStat(
                profile.recentDesigns.length.toString(),
                "DESIGN VIEWS",
              ),
              _buildHeaderDivider(),
              _buildHeaderStat(
                profile.likedDesigns.length.toString(),
                "LIKED DESIGNS",
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildProfileInfo(CrossAxisAlignment align) {
    return Column(
      crossAxisAlignment: align,
      children: [
        Text(
          profile.name ?? "",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 42,
            height: 1.1,
            fontWeight: FontWeight.bold,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          profile.role?.toUpperCase() ?? "",
          style: TextStyle(
            color: Colors.blueAccent.withOpacity(0.8),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderStat(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          value.padLeft(2, '0'),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Courier',
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderDivider() {
    return Container(
      height: 30,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 25),
      color: Colors.white10,
    );
  }

  Widget _buildSectionHeader(String title, String subtitle, int count) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.5,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: Colors.blueAccent.withOpacity(0.3),
                      width: 0.5,
                    ),
                  ),
                  child: Text(
                    count.toString().padLeft(2, '0'),
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Courier',
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Container(
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.15),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 500,
              child: Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 14,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= STICKY TAB =================

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  _StickyTabBarDelegate({required this.child});
  @override
  double get minExtent => 70;
  @override
  double get maxExtent => 70;
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) => child;
  @override
  bool shouldRebuild(covariant _StickyTabBarDelegate oldDelegate) => true;
}
