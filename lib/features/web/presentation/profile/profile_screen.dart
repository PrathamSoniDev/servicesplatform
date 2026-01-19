import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/core/bootstrap/bloc/app_bootstrap_bloc.dart';
import 'package:servicesplatform/features/web/widgets/blog_card.dart';
import 'package:servicesplatform/features/web/widgets/design_lux_card.dart';
import 'package:servicesplatform/features/web/widgets/prodile_tab_bar.dart';
import 'package:servicesplatform/features/web/widgets/top_nav_bar.dart';
import 'package:servicesplatform/models/blog_model.dart';
import 'package:servicesplatform/models/design_item_models.dart';
import 'package:servicesplatform/models/profile_model.dart';

import '../designs/bloc/designs_bloc.dart';
import '../designs/bloc/designs_event.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedTabIndex = 0;
  final List<String> tabs = ["Likes", "Shared", "Recent View"];

  String toSlug(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 950;
    final horizontalPadding = screenWidth > 1200 ? screenWidth * 0.12 : 30.0;
    final crossAxisCount = screenWidth > 1100 ? 3 : (screenWidth > 750 ? 2 : 1);

    final bootstrapState = context.watch<AppBootstrapBloc>().state;
    final ProfileModel? profile = bootstrapState.data?.profile;

    if (profile == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF020202),
        body: Center(child: CircularProgressIndicator(color: Colors.blueAccent)),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF020202),
      body: Column(
        children: [
          TopNavBar(
            activeIndex: 6,
            onHome: () => context.push('/'),
            onDesigns: () => context.push('/designs'),
            onAbout: () => context.push('/about'),
            onTestimonials: () => context.push('/reviews'),
            onBlog: () => context.push('/blog'),
            onContact: () => context.push('/contact'),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 50),
                  sliver: SliverToBoxAdapter(
                    child: _buildProfileHeader(profile, isDesktop),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _StickyTabBarDelegate(
                    child: Container(
                      color: const Color(0xFF020202),
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 10),
                      child: ProfileTabBar(
                        selectedIndex: selectedTabIndex,
                        tabs: tabs,
                        onTabSelected: (i) => setState(() => selectedTabIndex = i),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 30),
                  sliver: _buildTabContent(profile, crossAxisCount),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 80)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= TAB CONTENT LOGIC =================

  Widget _buildTabContent(ProfileModel profile, int crossAxisCount) {
    List<Widget> slivers = [];

  if (selectedTabIndex == 0) {
      // --- LIKES TAB ---
      slivers.addAll([
        _buildSectionHeader(
          "DESIGN INSPIRATIONS", 
          "Modern digital craft.", 
          profile.likedDesigns.length
        ),
        _buildDesignGrid(profile.likedDesigns, crossAxisCount),
        const SliverToBoxAdapter(child: SizedBox(height: 80)),
        _buildSectionHeader(
          "BOOKMARKED INSIGHTS", 
          "Saved for reference.", 
          profile.likedBlogs.length // Now works!
        ),
        _buildBlogGrid(profile.likedBlogs, crossAxisCount), // Now works!
      ]);
    } else if (selectedTabIndex == 2) {
      // --- RECENT VIEW TAB (Blogs Only) ---
      slivers.addAll([
        _buildSectionHeader(
          "READING HISTORY", 
          "Your latest sessions.", 
          profile.recentBlogs.length // Now works!
        ),
        _buildBlogGrid(profile.recentBlogs, crossAxisCount), // Now works!
      ]);
    } else if (selectedTabIndex == 1) {
      // --- SHARED TAB ---
      slivers.addAll([
        _buildSectionHeader(
          "SHARED PORTFOLIO", 
          "Publicly showcased projects demonstrating technical expertise.", 
          0
        ),
        const SliverToBoxAdapter(child: Center(child: Text("No shared designs", style: TextStyle(color: Colors.grey)))),
        const SliverToBoxAdapter(child: SizedBox(height: 80)),
        _buildSectionHeader(
          "PUBLISHED ARTICLES", 
          "Original thoughts shared with the community.", 
          0
        ),
        const SliverToBoxAdapter(child: Center(child: Text("No published articles", style: TextStyle(color: Colors.grey)))),
      ]);
    } else {
      // --- RECENT VIEW TAB ---
      // Designs removed here as requested. Only showing Blogs.
      slivers.addAll([
        _buildSectionHeader(
          "READING HISTORY", 
          "Technical deep-dives and editorial content visited in your latest sessions.", 
          0 // Use profile.recentBlogs.length if available in model
        ),
        _buildBlogGrid([], crossAxisCount), // Pass profile.recentBlogs here
      ]);
    }

    return SliverMainAxisGroup(slivers: slivers);
  }

  // ================= GRIDS =================

  Widget _buildDesignGrid(List<DesignItem> designs, int crossAxisCount) {
    if (designs.isEmpty) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Center(child: Text("No designs found", style: TextStyle(color: Colors.grey))),
        ),
      );
    }

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 25,
        mainAxisSpacing: 25,
        childAspectRatio: 0.85,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        final item = designs[index];
        return RepaintBoundary(
          child: DesignLuxuryCard(
            item: item,
            tag: item.categoryName ?? "Design",
            onTap: () {
              final slug = (item.title != null && item.title!.isNotEmpty) 
                  ? toSlug(item.title!) 
                  : item.id;
              context.push('/design/$slug', extra: item);
              context.read<DesignsBloc>().add(IncrementDesignView(item.id));
            },
          ),
        );
      }, childCount: designs.length),
    );
  }

  Widget _buildBlogGrid(List<BlogModel> blogs, int crossAxisCount) {
    if (blogs.isEmpty) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Center(child: Text("No articles found", style: TextStyle(color: Colors.grey))),
        ),
      );
    }

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 25,
        mainAxisSpacing: 25,
        childAspectRatio: crossAxisCount == 1 ? 1.2 : 0.9,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        final blog = blogs[index];
        return BlogCard(
          blog: blog,
          onTap: () => context.push('/blog/${blog.id}'),
        );
      }, childCount: blogs.length),
    );
  }

  // ================= HEADER & STATS =================

  Widget _buildProfileHeader(ProfileModel profile, bool isDesktop) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [Colors.blueAccent, Colors.purpleAccent]),
              ),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: const Color(0xFF020202),
                child: CircleAvatar(
                  radius: 47,
                  backgroundColor: Colors.grey[900],
                  backgroundImage: (profile.profileImg != null && profile.profileImg!.isNotEmpty)
                      ? NetworkImage(profile.profileImg!)
                      : null,
                  child: (profile.profileImg == null || profile.profileImg!.isEmpty)
                      ? const Icon(Icons.person, color: Colors.white, size: 40)
                      : null,
                ),
              ),
            ),
            if (isDesktop) ...[
              const SizedBox(width: 30),
              _buildProfileInfo(profile, CrossAxisAlignment.start),
            ],
          ],
        ),
        if (isDesktop)
          Row(
            children: [
              _buildHeaderStat(profile.recentDesigns.length.toString(), "RECENT VIEWS"),
              _buildHeaderDivider(),
              _buildHeaderStat(profile.likedDesigns.length.toString(), "LIKED DESIGNS"),
            ],
          ),
      ],
    );
  }

  Widget _buildProfileInfo(ProfileModel profile, CrossAxisAlignment align) {
    return Column(
      crossAxisAlignment: align,
      children: [
        Text(
          profile.email ?? "User",
          style: const TextStyle(color: Colors.white, fontSize: 42, height: 1.1, fontWeight: FontWeight.bold, letterSpacing: -1),
        ),
        const SizedBox(height: 4),
        Text(
          profile.role?.toUpperCase() ?? "MEMBER",
          style: TextStyle(color: Colors.blueAccent.withOpacity(0.8), fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildHeaderStat(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(value.padLeft(2, '0'), style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Courier')),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.2)),
      ],
    );
  }

  Widget _buildHeaderDivider() => Container(height: 30, width: 1, margin: const EdgeInsets.symmetric(horizontal: 25), color: Colors.white10);

  Widget _buildSectionHeader(String title, String subtitle, int count) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 2.5)),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.blueAccent.withOpacity(0.3), width: 0.5),
                  ),
                  child: Text(count.toString().padLeft(2, '0'), style: const TextStyle(color: Colors.blueAccent, fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'Courier')),
                ),
                const SizedBox(width: 15),
                Expanded(child: Container(height: 1, decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.white.withOpacity(0.15), Colors.transparent])))),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 500,
              child: Text(subtitle, style: TextStyle(color: Colors.grey[500], fontSize: 14, height: 1.5, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic, letterSpacing: 0.2)),
            ),
          ],
        ),
      ),
    );
  }
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  _StickyTabBarDelegate({required this.child});
  @override double get minExtent => 70;
  @override double get maxExtent => 70;
  @override Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) => child;
  @override bool shouldRebuild(covariant _StickyTabBarDelegate oldDelegate) => true;
}