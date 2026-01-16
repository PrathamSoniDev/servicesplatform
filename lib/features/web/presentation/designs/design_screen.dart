// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:servicesplatform/features/web/presentation/designs/design_overlay_screen.dart';
// import 'package:servicesplatform/features/web/utils/app_theme.dart';
// import 'package:servicesplatform/features/web/utils/responsive.dart';
// import 'package:servicesplatform/features/web/widgets/design_lux_card.dart';
// import 'package:servicesplatform/features/web/widgets/top_nav_bar.dart';
//
// import '../../../../core/app_router.dart';
// import '../../../../models/design_item_models.dart';
//
// class DesignScreen extends StatelessWidget {
//   const DesignScreen({super.key});
//
//   void _showDesignDetail(BuildContext context, DesignItem item) {
//     showGeneralDialog(
//       context: context,
//       barrierDismissible: true,
//       barrierLabel: 'Design Detail',
//       barrierColor: Colors.black.withValues(alpha: .8),
//       transitionDuration: const Duration(milliseconds: 400),
//       pageBuilder: (context, anim1, anim2) => const DesignDetailOverlay(),
//       transitionBuilder: (context, anim1, anim2, child) {
//         return FadeTransition(
//           opacity: anim1,
//           child: SlideTransition(
//             position: Tween<Offset>(
//               begin: const Offset(0, 0.05),
//               end: Offset.zero,
//             ).animate(
//               CurvedAnimation(parent: anim1, curve: Curves.easeOutCubic),
//             ),
//             child: child,
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isMobile = Responsive.isMobile(context);
//     final isDesktop = Responsive.isDesktop(context);
//
//     return Scaffold(
//       backgroundColor: AppTheme.background,
//       appBar: PreferredSize(
//         preferredSize: Size(double.infinity, isMobile ? 60 : 80),
//         child: TopNavBar(
//           activeIndex: 1,
//           onHome: () => context.go(AppRouter.home),
//           onDesigns: () => context.go('/designs'),
//           onAbout: () => context.go('/about'),
//           onTestimonials: () {},
//           onBlog: () => context.go('/blog'),
//           onContact: () => context.go('/contact'),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: isDesktop ? 80.0 : 24.0,
//                   vertical: isMobile ? 32.0 : 60.0,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "All Designs",
//                       style: theme.textTheme.headlineLarge?.copyWith(
//                         fontSize: isMobile ? 36 : 56,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     SizedBox(
//                       width: isMobile ? double.infinity : 600,
//                       child: Text(
//                         "Browse our complete collection of professionally crafted designs for every business need.",
//                         style: theme.textTheme.bodyLarge?.copyWith(
//                           color: Colors.white60,
//                           height: 1.6,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: isMobile ? 32 : 50),
//
//                     _buildSectionHeader("Filter by Category", theme),
//                     const SizedBox(height: 20),
//                     _buildFilterAndSearchRow(isMobile, theme),
//                     const SizedBox(height: 40),
//
//                     // --- Consistent Grid ---
//                     GridView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: designsData.length,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: isDesktop ? 3 : (isMobile ? 1 : 2),
//                         crossAxisSpacing: 30,
//                         mainAxisSpacing: 30,
//                         // FIXED: Changed from 0.75 to 1.45 to match your Home Section exactly
//                         childAspectRatio: 1.45,
//                       ),
//                       itemBuilder: (context, index) {
//                         return LuxuryCard(
//                           item: designsData[index],
//                           tag: "Premium",
//                           onTap:
//                               () => _showDesignDetail(
//                                 context,
//                                 designsData[index],
//                               ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // --- Helper methods remain the same ---
//   Widget _buildSectionHeader(String title, ThemeData theme) {
//     return Text(
//       title.toUpperCase(),
//       style: theme.textTheme.bodySmall?.copyWith(
//         color: AppTheme.primary,
//         fontWeight: FontWeight.w800,
//         letterSpacing: 2,
//       ),
//     );
//   }
//
//   Widget _buildFilterAndSearchRow(bool isMobile, ThemeData theme) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children:
//                 ["All", "Marketing", "SaaS", "E-Commerce", "Web Dev"]
//                     .map(
//                       (label) =>
//                           _buildFilterChip(label, isActive: label == "All"),
//                     )
//                     .toList(),
//           ),
//         ),
//         const SizedBox(height: 24),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.05),
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.white10),
//           ),
//           child: const TextField(
//             style: TextStyle(color: Colors.white),
//             decoration: InputDecoration(
//               icon: Icon(Icons.search, color: AppTheme.primary, size: 20),
//               hintText: "Search designs...",
//               hintStyle: TextStyle(color: Colors.white38),
//               border: InputBorder.none,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildFilterChip(String label, {bool isActive = false}) {
//     return Container(
//       margin: const EdgeInsets.only(right: 10),
//       child: ChoiceChip(
//         label: Text(label),
//         selected: isActive,
//         onSelected: (val) {},
//         selectedColor: AppTheme.primary,
//         backgroundColor: Colors.white.withOpacity(0.05),
//         labelStyle: TextStyle(
//           color: isActive ? Colors.white : Colors.white70,
//           fontSize: 13,
//         ),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//         side: BorderSide.none,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/core/bootstrap/bloc/app_bootstrap_bloc.dart';
import 'package:servicesplatform/features/web/presentation/common/footer_section.dart';
import 'package:servicesplatform/features/web/presentation/home/blog_section.dart';
import 'package:servicesplatform/features/web/presentation/home/contact_section.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';
import 'package:servicesplatform/features/web/widgets/design_lux_card.dart';
import 'package:servicesplatform/features/web/widgets/top_nav_bar.dart';
import 'package:servicesplatform/models/category_model.dart';

import 'bloc/designs_bloc.dart';
import 'bloc/designs_event.dart';
import 'bloc/designs_state.dart';

class DesignScreen extends StatefulWidget {
  const DesignScreen({super.key});

  @override
  State<DesignScreen> createState() => _DesignScreenState();
}

class _DesignScreenState extends State<DesignScreen> {
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  String toSlug(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
  }

  // void _showDesignDetail(BuildContext context, DesignItem item) {
  //   showGeneralDialog(
  //     context: context,
  //     barrierDismissible: true,
  //     barrierLabel: 'Design Detail',
  //     barrierColor: Colors.black.withValues(alpha: .8),
  //     transitionDuration: const Duration(milliseconds: 400),
  //     pageBuilder: (_, __, ___) => DesignDetailOverlay(data: item),
  //     transitionBuilder: (_, anim, __, child) {
  //       return FadeTransition(
  //         opacity: anim,
  //         child: SlideTransition(
  //           position: Tween<Offset>(
  //             begin: const Offset(0, 0.05),
  //             end: Offset.zero,
  //           ).animate(
  //             CurvedAnimation(parent: anim, curve: Curves.easeOutCubic),
  //           ),
  //           child: child,
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = Responsive.isMobile(context);
    final isDesktop = Responsive.isDesktop(context);
    final designList = context.watch<DesignsBloc>().state.designs;
    final categoryList = context.watch<AppBootstrapBloc>().state.data?.category;
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, isMobile ? 60 : 80),
        child: TopNavBar(
          activeIndex: 1,
          onHome: () => context.go('/'),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ───────── HEADER ─────────
              Text(
                "All Designs",
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontSize: isMobile ? 36 : 56,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: isMobile ? double.infinity : 600,
                child: Text(
                  "Browse our complete collection of professionally crafted designs for every business need.",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white60,
                    height: 1.6,
                  ),
                ),
              ),

              const SizedBox(height: 50),

              _sectionLabel("Filter by Category", theme),
              const SizedBox(height: 20),
              _buildFilters(theme, categoryList!),
              const SizedBox(height: 40),

              /// ───────── GRID ─────────
              BlocBuilder<DesignsBloc, DesignsState>(
                builder: (context, state) {
                  if (state.listStatus == DesignsStatus.loading &&
                      state.designs.isEmpty) {
                    return _buildLoadingGrid(isDesktop, isMobile);
                  }
                  if (designList.isEmpty) {
                    return _buildEmpty();
                  }

                  return GridView.builder(
                    addAutomaticKeepAlives: true,
                    addRepaintBoundaries: true,
                    addSemanticIndexes: true,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.designs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isDesktop ? 3 : (isMobile ? 1 : 2),
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 30,
                      childAspectRatio: 1.45,
                    ),
                    itemBuilder: (context, index) {
                      final item = designList[index];
                      return RepaintBoundary(
                        child: DesignLuxuryCard(
                          item: item,
                          tag: item.categoryName!,
                          onTap: () {
                            final slug = toSlug(item.title ?? item.id);
                            state.selectedDesign = item;
                            context.push(
                              '/design/$slug',
                              extra:
                                  state.selectedDesign ??
                                  item, // pass full model
                            );

                            context.read<DesignsBloc>().add(
                              IncrementDesignView(item.id),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
              const BlogSection(),
              const ContactSection(),
              const FooterSection(),
            ],
          ),
        ),
      ),
    );
  }

  // ───────────────── FILTERS ─────────────────

  Widget _buildFilters(ThemeData theme, List<CategoryModel> categories) {
    // Add virtual "All" category at runtime
    final filterCategories = [
      CategoryModel(id: 'all', name: 'All', imageUrl: ''),
      ...categories,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                filterCategories.map((cat) {
                  final isActive = _selectedCategory == cat.id;

                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: RepaintBoundary(
                      child: ChoiceChip(
                        label: Text(cat.name),
                        selected: isActive,
                        selectedColor: AppTheme.primary,
                        backgroundColor: Colors.white.withValues(alpha: .05),
                        labelStyle: TextStyle(
                          color: isActive ? Colors.white : Colors.white70,
                          fontSize: 13,
                        ),
                        onSelected: (_) {
                          setState(() {
                            _selectedCategory = cat.id;
                          });

                          context.read<DesignsBloc>().add(
                            FetchDesignsByCategory(
                              cat.id == 'all' ? null : cat.id,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }).toList(),
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white10),
          ),
          child: TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.white),
            onChanged: (value) {
              context.read<DesignsBloc>().add(SearchDesigns(value));
            },
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

  // ───────────────── UI STATES ─────────────────

  Widget _buildLoadingGrid(bool isDesktop, bool isMobile) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: isDesktop ? 6 : 3,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isDesktop ? 3 : (isMobile ? 1 : 2),
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        childAspectRatio: 1.45,
      ),
      itemBuilder:
          (_, __) => Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .04),
              borderRadius: BorderRadius.circular(24),
            ),
            height: 240,
          ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        children: [
          const Icon(Icons.auto_awesome, size: 60, color: Colors.white24),
          const SizedBox(height: 16),
          const Text(
            "No designs found",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Try adjusting filters or search keywords.",
            style: TextStyle(color: Colors.white.withValues(alpha: .5)),
          ),
        ],
      ),
    );
  }

  // Widget _buildError(String? message) {
  //   return Center(
  //     child: Text(
  //       message ?? "Failed to load designs",
  //       style: const TextStyle(color: Colors.redAccent),
  //     ),
  //   );
  // }

  Widget _sectionLabel(String text, ThemeData theme) {
    return Text(
      text.toUpperCase(),
      style: theme.textTheme.bodySmall?.copyWith(
        color: AppTheme.primary,
        fontWeight: FontWeight.w800,
        letterSpacing: 2,
      ),
    );
  }
}
