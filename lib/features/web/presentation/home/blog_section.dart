import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/presentation/home/hero_section.dart';
import '../../models/blog_model.dart';
import '../../utils/responsive.dart';
import '../../widgets/blog_card.dart';
import '../../widgets/button.dart'; // Ensure you import your button widget

class BlogSection extends StatefulWidget {
  const BlogSection({super.key});

  @override
  State<BlogSection> createState() => _BlogSectionState();
}

class _BlogSectionState extends State<BlogSection> {
  String selectedCategory = "All";
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      color: Colors.black,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- TOP FEATURED SECTION ---
          // Using the updated universal HeroSection
          HeroSection(
            title: "The Ultimate Guide to Digital Marketing Strategy",
            subtitle:
                "Digital Marketing Strategist helping businesses grow through data-driven marketing campaigns. Specializes in content marketing and SEO.",
            imagePath:
                'https://images.unsplash.com/photo-1552664730-d307ca884978?q=80&w=2070',
            featuredText: "FEATURED",
            featuredColor: Colors.redAccent,
            showNavigationArrows: true, // Matches the blog image requirement
            isOverlayMode: false, // Side-by-side layout for Blog
            contentAlignment: HeroContentAlignment.left,
            customButtons: [
              AppButton(
                text: "Read more",
                onPressed: () {},
                type: AppButtonType.outline,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
              ),
            ],
          ),

          const SizedBox(height: 100),

          // --- FILTER CHIPS ---
          _buildCategoryFilters(),

          const SizedBox(height: 40),

          // --- SECTION HEADER ---
          _buildLatestArticlesHeader(),

          const SizedBox(height: 40),

          // --- GRID VIEW ---
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _getCrossAxisCount(width),
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              childAspectRatio: isMobile ? 0.9 : 0.85,
            ),
            itemBuilder: (_, index) {
              return BlogCard(
                blog: BlogModel(
                  id: "$index",
                  title: "Blog post title",
                  description:
                      "Explore our most popular designs crafted with precision and creativity.",
                  imageUrl:
                      "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f",
                  category: "ED-Tech",
                  authorName: "Name",
                  publishedAt: DateTime(2025, 12, 24),
                  readMinutes: 3,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLatestArticlesHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "LATEST ARTICLES",
          style: TextStyle(
            letterSpacing: 1.5,
            color: Colors.redAccent.withOpacity(0.8),
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Featured Articles",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((cat) {
          bool isSelected = selectedCategory == cat;
          return GestureDetector(
            onTap: () => setState(() => selectedCategory = cat),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.grey.withOpacity(0.3)
                    : Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: isSelected ? Colors.white38 : Colors.transparent),
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