import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Assuming you use go_router for navigation
import 'package:servicesplatform/features/web/presentation/home/hero_section.dart';
import 'package:servicesplatform/features/web/widgets/top_nav_bar.dart';
// Import your TopNavBar widget path here
// import '../../widgets/top_nav_bar.dart'; 

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
  final int itemsPerPage = 9; // 3x3 Grid
  final int totalPages = 10;

  final List<String> categories = [
    "All",
    "Marketing",
    "Education",
    "Web developement",
    "Design"
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
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- TOP NAV BAR ---
            // Note: Replace "AppRouter.home" with your actual route string
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
                horizontal: isMobile ? 24 : 80,
                vertical: 60,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- TOP FEATURED SECTION ---
                  HeroSection(
                    title: "The Ultimate Guide to Digital Marketing Strategy",
                    subtitle:
                        "Digital Marketing Strategist helping businesses grow through data-driven marketing campaigns. Specializes in content marketing and SEO.",
                    imagePath:
                        'https://images.unsplash.com/photo-1552664730-d307ca884978?q=80&w=2070',
                    featuredText: "FEATURED",
                    featuredColor: Colors.redAccent,
                    showNavigationArrows: false,
                    isOverlayMode: false,
                    contentAlignment: HeroContentAlignment.left,
                    customButtons: const [],
                  ),

                  const SizedBox(height: 80),

                  // --- FILTER CHIPS ---
                  _buildCategoryFilters(),

                  const SizedBox(height: 60),

                  // --- GRID VIEW (3x3 Layout) ---
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: itemsPerPage,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _getCrossAxisCount(width),
                      crossAxisSpacing: 25,
                      mainAxisSpacing: 25,
                      childAspectRatio: isMobile ? 0.9 : (isTablet ? 0.85 : 0.82),
                    ),
                    itemBuilder: (_, index) {
                      int blogId = ((currentPage - 1) * itemsPerPage) + index + 1;
                      return BlogCard(
                        blog: BlogModel(
                          id: "$blogId",
                          title: "How to Scale your Business $blogId",
                          description: "Explore our most popular designs crafted with precision and creativity.",
                          imageUrl: "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f",
                          category: "Marketing",
                          authorName: "John Doe",
                          publishedAt: DateTime(2025, 12, 24),
                          readMinutes: 3,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 80),

                  // --- PAGINATION CONTROLS ---
                  _buildPaginationControls(),
                  
                  const SizedBox(height: 60),

                  // --- DIM WHITE LINE (Divider between Pagination and Trending) ---
                  Divider(
                    color: Colors.white.withOpacity(0.15),
                    thickness: 1,
                  ),

                  const SizedBox(height: 80),

                  // --- TRENDING SECTION HEADER ---
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

                  const SizedBox(height: 40),

                  // --- TRENDING CARDS ---
                  _buildTrendingSection(width, isMobile),

                  const SizedBox(height: 60),

                  // --- FINAL DESIGN LINE ---
                  Divider(
                    color: Colors.white.withOpacity(0.2),
                    thickness: 1,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
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
            crossAxisSpacing: 25,
            mainAxisSpacing: 25,
            childAspectRatio: isMobile ? 0.9 : 0.82,
          ),
          itemBuilder: (_, index) {
            return BlogCard(
              blog: BlogModel(
                id: "trending_$index",
                title: "Trending Article Title ${index + 1}",
                description: "Explore our most popular designs crafted with precision.",
                imageUrl: "https://images.unsplash.com/photo-1552664730-d307ca884978",
                category: "ED-Tech",
                authorName: "Name",
                publishedAt: DateTime(2025, 12, 24),
                readMinutes: 3,
              ),
            );
          },
        ),
        const SizedBox(height: 40),
        // Navigation Arrows for Trending Section
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _pageArrow(Icons.arrow_back_ios_new, true, () {}),
            const SizedBox(width: 30),
            _pageArrow(Icons.arrow_forward_ios, true, () {}),
          ],
        ),
      ],
    );
  }

  Widget _buildPaginationControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _pageArrow(Icons.chevron_left, currentPage > 1, () => _changePage(currentPage - 1)),
        const SizedBox(width: 20),
        _pageNumber(1),
        if (totalPages > 1) _pageNumber(2),
        if (totalPages > 2) _pageNumber(3),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text("...", style: TextStyle(color: Colors.white54, fontSize: 18)),
        ),
        _pageNumber(totalPages),
        const SizedBox(width: 20),
        _pageArrow(Icons.chevron_right, currentPage < totalPages, () => _changePage(currentPage + 1)),
      ],
    );
  }

  Widget _pageNumber(int num) {
    bool active = currentPage == num;
    return GestureDetector(
      onTap: () => _changePage(num),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: active ? Colors.white.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: active ? Colors.white.withOpacity(0.3) : Colors.transparent,
          ),
        ),
        child: Text(
          "$num",
          style: TextStyle(
            color: active ? Colors.white : Colors.white54,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _pageArrow(IconData icon, bool enabled, VoidCallback onTap) {
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(50),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Icon(
          icon,
          color: enabled ? Colors.white : Colors.white24,
          size: 22,
        ),
      ),
    );
  }

  Widget _buildCategoryFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: categories.map((cat) {
          bool isSelected = selectedCategory == cat;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = cat;
                currentPage = 1;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: isSelected ? Colors.white38 : Colors.transparent),
              ),
              child: Text(
                cat,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}