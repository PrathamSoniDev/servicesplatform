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
  late final HeroRepository _heroRepository;

  final List<String> categories = [
    "All", "Marketing", "Education", "Web development", "Design",
  ];

  @override
  void initState() {
    super.initState();
    _heroRepository = HeroRepository();
  }

  // --- RESPONSIVE LOGIC ---
  int _getItemsPerPage(BuildContext context) {
    if (Responsive.isMobile(context)) return 4;
    if (Responsive.isTablet(context)) return 6;
    return 9;
  }

  int _getCrossAxisCount(double width) {
    if (width >= 1100) return 3;
    if (width >= 700) return 2;
    return 1;
  }

  void _changePage(int page, int totalPages) {
    if (page >= 1 && page <= totalPages) {
      setState(() => currentPage = page);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = Responsive.isMobile(context);
    final itemsPerPage = _getItemsPerPage(context);
    const int totalPages = 10; // Increased for testing pagination overflow

    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                horizontal: isMobile ? 20 : 100,
                vertical: isMobile ? 30 : 60,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- HERO WITH GLOW ---
                  _buildHeroWithGlow(width),

                  const SizedBox(height: 80),

                  // --- FILTERS ---
                  _buildFilterHeader(isMobile),

                  const SizedBox(height: 40),
                  const Divider(color: Colors.white10),
                  const SizedBox(height: 40),

                  // --- MAIN GRID ---
                  _buildResponsiveGrid(width, itemsPerPage, isMobile),

                  const SizedBox(height: 60),

                  // --- PAGINATION (FIXED OVERFLOW) ---
                  _buildPaginationControls(totalPages, isMobile),

                  const SizedBox(height: 80),
                  const ContactSection(),
                  const FooterSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroWithGlow(double width) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 450,
          width: width * 0.7,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                const Color(0xFF8B5CF6).withOpacity(0.15),
                Colors.transparent,
              ],
            ),
          ),
        ),
        FutureBuilder<List<HeroModel>>(
          future: _heroRepository.getHeroes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(height: 500, child: HeroShimmer());
            }
            if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
              return const SizedBox.shrink();
            }
            final hero = snapshot.data!.firstWhere(
              (h) => h.key == 'blog' && h.isActive,
              orElse: () => snapshot.data!.first,
            );
            return HeroSection(
              title: hero.headingText,
              subtitle: hero.subHeadingText,
              imagePath: resolveAssetUrl(hero.assetUrl),
              featuredText: hero.gradientText,
              showGradient: true,
              isOverlayMode: false,
              contentAlignment: hero.isContentLeft
                  ? HeroContentAlignment.left
                  : hero.isContentRight
                      ? HeroContentAlignment.right
                      : HeroContentAlignment.center,
            );
          },
        ),
      ],
    );
  }

  Widget _buildFilterHeader(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Browse Topics",
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            if (!isMobile) _buildCategoryFilters(),
          ],
        ),
        if (isMobile) ...[
          const SizedBox(height: 20),
          _buildCategoryFilters(),
        ],
      ],
    );
  }

  Widget _buildResponsiveGrid(double width, int itemsPerPage, bool isMobile) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate aspect ratio dynamically to prevent image/text truncation
        double cardWidth = (constraints.maxWidth - (isMobile ? 0 : 70)) / _getCrossAxisCount(width);
        double cardHeight = isMobile ? 480 : 520; 
        double ratio = cardWidth / cardHeight;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itemsPerPage,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _getCrossAxisCount(width),
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
            childAspectRatio: ratio < 0.5 ? 0.5 : ratio, // Safety clamp
          ),
          itemBuilder: (_, index) {
            int blogId = ((currentPage - 1) * itemsPerPage) + index + 1;
            return BlogCard(
              blog: BlogModel(
                id: "$blogId",
                title: "How to Scale your Business $blogId",
                description: "Insights into precision and creativity.",
                imageUrl: "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f",
                category: "Marketing",
                authorName: "John Doe",
                publishedAt: DateTime.now(),
                readMinutes: 3,
              ),
              onTap: () => context.go('/blog/$blogId'),
            );
          },
        );
      },
    );
  }

  Widget _buildPaginationControls(int totalPages, bool isMobile) {
    // Logic to only show current page and surrounding pages to avoid overflow
    List<int> pageNumbers = [];
    if (totalPages <= 5) {
      pageNumbers = List.generate(totalPages, (i) => i + 1);
    } else {
      if (currentPage <= 3) {
        pageNumbers = [1, 2, 3, 4, totalPages];
      } else if (currentPage >= totalPages - 2) {
        pageNumbers = [1, totalPages - 3, totalPages - 2, totalPages - 1, totalPages];
      } else {
        pageNumbers = [1, currentPage - 1, currentPage, currentPage + 1, totalPages];
      }
    }

    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Prevents overflow on very narrow screens
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _pageArrow(Icons.chevron_left, currentPage > 1, () => _changePage(currentPage - 1, totalPages)),
            const SizedBox(width: 10),
            ...pageNumbers.map((num) {
              // Add dots logic
              bool showDots = num > 1 && !pageNumbers.contains(num - 1);
              return Row(
                children: [
                  if (showDots) const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text("...", style: TextStyle(color: Colors.white24)),
                  ),
                  _pageNumber(num),
                ],
              );
            }),
            const SizedBox(width: 10),
            _pageArrow(Icons.chevron_right, currentPage < totalPages, () => _changePage(currentPage + 1, totalPages)),
          ],
        ),
      ),
    );
  }

  Widget _pageNumber(int num) {
    bool active = currentPage == num;
    return GestureDetector(
      onTap: () => setState(() => currentPage = num),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF8B5CF6) : Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          "$num", 
          style: TextStyle(color: active ? Colors.white : Colors.white54, fontWeight: active ? FontWeight.bold : FontWeight.normal)
        ),
      ),
    );
  }

  Widget _pageArrow(IconData icon, bool enabled, VoidCallback onTap) {
    return IconButton(
      onPressed: enabled ? onTap : null,
      icon: Icon(icon, size: 20),
      color: enabled ? Colors.white : Colors.white12,
      style: IconButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.05),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildCategoryFilters() {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          bool isSelected = selectedCategory == cat;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ChoiceChip(
              label: Text(cat),
              selected: isSelected,
              onSelected: (val) => setState(() { selectedCategory = cat; currentPage = 1; }),
              backgroundColor: Colors.transparent,
              selectedColor: const Color(0xFF8B5CF6).withOpacity(0.2),
              labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.white38, fontSize: 13),
              shape: StadiumBorder(side: BorderSide(color: isSelected ? const Color(0xFF8B5CF6) : Colors.white10)),
              showCheckmark: false,
            ),
          );
        },
      ),
    );
  }
}