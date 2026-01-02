import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';
import 'package:servicesplatform/features/web/widgets/design_card.dart';
import 'package:servicesplatform/features/web/widgets/top_nav_bar.dart';

import '../../../../core/app_router.dart';

class DesignScreen extends StatelessWidget {
  const DesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = Responsive.isMobile(context);
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, isMobile ? 60 : 80),
        child: TopNavBar(
          activeIndex: 1, // Set to match Designs position
          onHome: () => context.go(AppRouter.home),
          onDesigns: () => context.go('/designs'),
          onAbout: () => context.go('/about'),
          onTestimonials: () {},
          onBlog: () => context.go('/blog'),
          onContact: () => context.go('/contact'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 80.0 : 24.0,
                  vertical: isMobile ? 32.0 : 60.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Header Section using AppTheme text styles ---
                    Text(
                      "All Designs",
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontSize: isMobile ? 36 : 56,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: isMobile ? double.infinity : 600,
                      child: Text(
                        "Browse our complete collection of professionally crafted designs for every business need. From marketing assets to full-scale SaaS platforms.",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.white60,
                          height: 1.6,
                        ),
                      ),
                    ),
                    SizedBox(height: isMobile ? 32 : 50),

                    // --- Filter & Search Section ---
                    _buildSectionHeader("Filter by Category", theme),
                    const SizedBox(height: 20),
                    _buildFilterAndSearchRow(isMobile, theme),
                    const SizedBox(height: 40),

                    // --- Results Info ---
                    Text(
                      "Showing 6 premium designs",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // --- Responsive Grid using your Responsive helper ---
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 6,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isDesktop ? 3 : (isMobile ? 1 : 2),
                        crossAxisSpacing: 30,
                        mainAxisSpacing: isMobile ? 30 : 50,
                        childAspectRatio: 0.85,
                      ),
                      itemBuilder: (context, index) => const DesignCard(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterAndSearchRow(bool isMobile, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              _buildFilterChip("All", isActive: true),
              _buildFilterChip("Marketing"),
              _buildFilterChip("SaaS"),
              _buildFilterChip("E-Commerce"),
              _buildFilterChip("Web Dev"),
              _buildFilterChip("Education"),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white10),
          ),
          child: TextField(
            style: theme.textTheme.bodyMedium,
            decoration: const InputDecoration(
              icon: Icon(Icons.search, color: AppTheme.primary, size: 20),
              hintText: "Search designs...",
              hintStyle: TextStyle(color: Colors.white38),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, ThemeData theme) {
    return Text(
      title.toUpperCase(),
      style: theme.textTheme.bodySmall?.copyWith(
        color: AppTheme.primary,
        fontWeight: FontWeight.w800,
        letterSpacing: 2,
      ),
    );
  }

  Widget _buildFilterChip(String label, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: ChoiceChip(
        label: Text(label),
        selected: isActive,
        onSelected: (val) {},
        selectedColor: AppTheme.primary,
        backgroundColor: Colors.white.withOpacity(0.05),
        labelStyle: TextStyle(
          color: isActive ? Colors.white : Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        side: BorderSide.none,
      ),
    );
  }
}
