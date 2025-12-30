import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/features/web/presentation/common/footer_section.dart';
import 'package:servicesplatform/features/web/presentation/home/contact_section.dart';
import 'package:servicesplatform/features/web/presentation/home/hero_section.dart';
import 'package:servicesplatform/features/web/widgets/hero_shimmer.dart';
import 'package:servicesplatform/features/web/widgets/top_nav_bar.dart';

import '../../../../core/hero/hero_mapper.dart';
import '../../../../core/hero/hero_model.dart';
import '../../../../services/hero_repository.dart';
import '../../models/blog_model.dart';
import '../../utils/responsive.dart';
import '../../widgets/blog_card.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  String selectedCategory = "All";
  int currentPage = 1;
  final int itemsPerPage = 9;
  final int totalPages = 10;
  late final HeroRepository _heroRepository;
  final List<String> categories = [
    "All",
    "Marketing",
    "Education",
    "Web development",
    "Design",
  ];

  int _getCrossAxisCount(double width) {
    if (width >= 1100) return 3;
    if (width >= 700) return 2;
    return 1;
  }

  void _changePage(int page) {
    if (page >= 1 && page <= totalPages) {
      setState(() {
        currentPage = page;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _heroRepository = HeroRepository();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // --- NAVIGATION ---
                  TopNavBar(
                    activeIndex: 4,
                    onHome: () => context.go('/home'),
                    onDesigns: () {},
                    onAbout: () {},
                    onTestimonials: () {},
                    onBlog: () {},
                    onContact: () {},
                  ),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 24 : 100,
                      vertical: 60,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFF8B5CF6,
                                ).withValues(alpha: .05),
                                blurRadius: 100,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: SizedBox(
                            child: FutureBuilder<List<HeroModel>>(
                              future: _heroRepository.getHeroes(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const SizedBox(
                                    height: 600,
                                    child: Center(child: HeroShimmer()),
                                  );
                                }

                                // ❌ Error or empty
                                if (snapshot.hasError ||
                                    !snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return const SizedBox.shrink();
                                }

                                // ✅ Pick HOME hero
                                final hero = snapshot.data!.firstWhere(
                                  (h) => h.key == 'blog' && h.isActive,
                                  orElse: () => snapshot.data!.first,
                                );
                                debugPrint(
                                  "Debugging Asset Url : ${hero.assetUrl}",
                                );
                                return HeroSection(
                                  title: hero.headingText,
                                  subtitle: hero.subHeadingText,
                                  imagePath: resolveAssetUrl(hero.assetUrl),
                                  featuredText: hero.gradientText,
                                  showGradient: false,
                                  isOverlayMode: false,
                                  contentAlignment:
                                      hero.isContentLeft
                                          ? HeroContentAlignment.left
                                          : hero.isContentRight
                                          ? HeroContentAlignment.right
                                          : HeroContentAlignment.center,
                                );
                              },
                            ),
                          ),
                          // child: HeroSection(
                          //   title:
                          //       "The Ultimate Guide to Digital Marketing Strategy",
                          //   subtitle:
                          //       "Digital Marketing Strategist helping businesses grow through data-driven marketing campaigns.",
                          //   imagePath:
                          //       'https://images.unsplash.com/photo-1552664730-d307ca884978?q=80&w=2070',
                          //   featuredText: "FEATURED",
                          //   featuredColor: Colors.redAccent,
                          //   showNavigationArrows: false,
                          //   isOverlayMode: false,
                          //   contentAlignment: HeroContentAlignment.left,
                          //   customButtons: const [],
                          // ),
                        ),

                        const SizedBox(height: 100),

                        // --- CATEGORY FILTERS ---
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Browse Topics",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            if (!isMobile) _buildCategoryFilters(),
                          ],
                        ),
                        if (isMobile) ...[
                          const SizedBox(height: 20),
                          _buildCategoryFilters(),
                        ],
                        const SizedBox(height: 40),
                        const Divider(color: Colors.white10),
                        const SizedBox(height: 60),

                        // --- MAIN BLOG GRID ---
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: itemsPerPage,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: _getCrossAxisCount(width),
                            crossAxisSpacing: 35,
                            mainAxisSpacing:
                                50, // Increased spacing for hover animation safety
                            // --- RESOLUTION: DYNAMIC ASPECT RATIO ---
                            childAspectRatio:
                                isMobile
                                    ? (width /
                                        640) // Adjusts height based on width to prevent overflow
                                    : (isTablet ? 0.78 : 0.85),
                          ),
                          itemBuilder: (_, index) {
                            int blogId =
                                ((currentPage - 1) * itemsPerPage) + index + 1;

                            final currentBlog = BlogModel(
                              id: "$blogId",
                              title: "How to Scale your Business $blogId",
                              description:
                                  "Explore our most popular designs crafted with precision and creativity.",
                              imageUrl:
                                  "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f",
                              category: "Marketing",
                              authorName: "John Doe",
                              publishedAt: DateTime(2025, 12, 24),
                              readMinutes: 3,
                            );

                            return BlogCard(
                              blog: currentBlog,
                              onTap:
                                  () => context.go(
                                    '/blog/$blogId',
                                    extra: currentBlog,
                                  ),
                            );
                          },
                        ),

                        const SizedBox(height: 80),
                        _buildPaginationControls(),
                        const SizedBox(height: 60),
                        Divider(
                          color: Colors.white.withValues(alpha: .08),
                          thickness: 1,
                        ),
                        const SizedBox(height: 80),

                        // --- TRENDING SECTION ---
                        HeroSection(
                          title: "Featured Articles",
                          subtitle: "",
                          featuredText: "TRENDING TOPICS",
                          featuredColor: Colors.redAccent,
                          showNavigationArrows: false,
                          isOverlayMode: false,
                          contentAlignment: HeroContentAlignment.left,
                          customButtons: const [],
                        ),

                        const SizedBox(height: 50),
                        _buildTrendingSection(width, isMobile),
                        const SizedBox(height: 60),
                        Divider(
                          color: Colors.white.withValues(alpha: .08),
                          thickness: 1,
                        ),
                        const SizedBox(height: 40),
                        const ContactSection(),
                        const FooterSection(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingSection(double width, bool isMobile) {
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _getCrossAxisCount(width),
            crossAxisSpacing: 35,
            mainAxisSpacing: 50,
            // Consistency with the main grid to prevent 2.6px overflow
            childAspectRatio: isMobile ? (width / 640) : 0.82,
          ),
          itemBuilder: (_, index) {
            final trendingId = "trending_$index";
            final trendingBlog = BlogModel(
              id: trendingId,
              title: "Trending Article Title ${index + 1}",
              description:
                  "Explore our most popular designs crafted with precision.",
              imageUrl:
                  "https://images.unsplash.com/photo-1552664730-d307ca884978",
              category: "ED-Tech",
              authorName: "Name",
              publishedAt: DateTime(2025, 12, 24),
              readMinutes: 3,
            );

            return BlogCard(
              blog: trendingBlog,
              onTap: () => context.go('/blog/$trendingId', extra: trendingBlog),
            );
          },
        ),
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _pageArrow(Icons.arrow_back_ios_new, true, () {}),
            const SizedBox(width: 40),
            _pageArrow(Icons.arrow_forward_ios, true, () {}),
          ],
        ),
      ],
    );
  }

  Widget _buildPaginationControls() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _pageArrow(
            Icons.chevron_left,
            currentPage > 1,
            () => _changePage(currentPage - 1),
          ),
          const SizedBox(width: 25),
          _pageNumber(1),
          if (totalPages > 1) _pageNumber(2),
          if (totalPages > 2) _pageNumber(3),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "...",
              style: TextStyle(color: Colors.white24, fontSize: 18),
            ),
          ),
          _pageNumber(totalPages),
          const SizedBox(width: 25),
          _pageArrow(
            Icons.chevron_right,
            currentPage < totalPages,
            () => _changePage(currentPage + 1),
          ),
        ],
      ),
    );
  }

  Widget _pageNumber(int num) {
    bool active = currentPage == num;
    return GestureDetector(
      onTap: () => _changePage(num),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color:
              active
                  ? const Color(0xFF8B5CF6)
                  : Colors.white.withValues(alpha: .03),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: active ? Colors.white24 : Colors.transparent,
          ),
          boxShadow:
              active
                  ? [
                    BoxShadow(
                      color: const Color(0xFF8B5CF6).withValues(alpha: .3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ]
                  : [],
        ),
        child: Text(
          "$num",
          style: TextStyle(
            color: active ? Colors.white : Colors.white54,
            fontWeight: active ? FontWeight.bold : FontWeight.w500,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _pageArrow(IconData icon, bool enabled, VoidCallback onTap) {
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: enabled ? Colors.white10 : Colors.transparent,
          ),
          color:
              enabled
                  ? Colors.white.withValues(alpha: .02)
                  : Colors.transparent,
        ),
        child: Icon(
          icon,
          color: enabled ? Colors.white : Colors.white12,
          size: 18,
        ),
      ),
    );
  }

  Widget _buildCategoryFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children:
            categories.map((cat) {
              bool isSelected = selectedCategory == cat;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategory = cat;
                    currentPage = 1;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isSelected
                            ? Colors.white.withValues(alpha: .08)
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color:
                          isSelected
                              ? const Color(0xFF8B5CF6).withValues(alpha: .5)
                              : Colors.white10,
                    ),
                  ),
                  child: Text(
                    cat,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white38,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 13,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
