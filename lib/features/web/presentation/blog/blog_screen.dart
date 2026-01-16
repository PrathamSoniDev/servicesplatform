// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:servicesplatform/features/web/presentation/common/footer_section.dart';
// import 'package:servicesplatform/features/web/presentation/home/contact_section.dart';
// import 'package:servicesplatform/features/web/presentation/home/hero_section.dart';
// import 'package:servicesplatform/features/web/widgets/top_nav_bar.dart';
// import 'package:servicesplatform/services/hero_repository.dart';
//
// import '../../../../core/app_router.dart';
// import '../../../../core/bootstrap/bloc/app_bootstrap_bloc.dart';
// import '../../../../core/bootstrap/bloc/app_bootstrap_event.dart';
// import '../../../../core/bootstrap/bloc/app_bootstrap_state.dart';
// import '../../../../core/hero/hero_mapper.dart';
// import '../../../../models/blog_model.dart';
// import '../../utils/responsive.dart';
// import '../../widgets/blog_card.dart';
// import '../home/custom_shimmer.dart';
//
// class BlogScreen extends StatefulWidget {
//   const BlogScreen({super.key});
//
//   @override
//   State<BlogScreen> createState() => _BlogScreenState();
// }
//
// class _BlogScreenState extends State<BlogScreen> {
//   String selectedCategory = "All";
//   int currentPage = 1;
//   final int itemsPerPage = 9;
//   final int totalPages = 10;
//   late HeroRepository heroRepository;
//   final List<String> categories = [
//     "All",
//     "Marketing",
//     "Education",
//     "Web developement",
//     "Design",
//   ];
//
//   int _getCrossAxisCount(double width) {
//     if (width >= 1100) return 3;
//     if (width >= 700) return 2;
//     return 1;
//   }
//
//   void _changePage(int page) {
//     if (page >= 1 && page <= totalPages) {
//       setState(() {
//         currentPage = page;
//       });
//     }
//   }
//
//   // RESOLUTION: Dynamic Aspect Ratio to prevent card overflows
//   double _getResponsiveAspectRatio(double width, bool isMobile, bool isTablet) {
//     if (isMobile) return (width / 680);
//     if (isTablet) return 0.75;
//     return 0.85;
//   }
//
//   // REAL WORKING PAGINATION LOGIC (Sliding Window)
//   List<int> _getVisiblePageNumbers() {
//     List<int> pages = [];
//     if (totalPages <= 5) {
//       pages = List.generate(totalPages, (i) => i + 1);
//     } else {
//       // Always show first page
//       pages.add(1);
//
//       int start = (currentPage - 1).clamp(2, totalPages - 2);
//       int end = (currentPage + 1).clamp(3, totalPages - 1);
//
//       if (start > 2) pages.add(-1); // -1 is the "..." ellipsis
//
//       for (int i = start; i <= end; i++) {
//         if (!pages.contains(i)) pages.add(i);
//       }
//
//       if (end < totalPages - 1) pages.add(-2); // Second ellipsis
//
//       // Always show last page
//       if (!pages.contains(totalPages)) pages.add(totalPages);
//     }
//     return pages;
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     heroRepository = HeroRepository();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final isMobile = Responsive.isMobile(context);
//     final isTablet = Responsive.isTablet(context);
//
//     return Scaffold(
//       backgroundColor: const Color(0xFF080808),
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   TopNavBar(
//                     activeIndex: 4,
//                     onHome: () => context.go(AppRouter.home),
//                     onDesigns: () {},
//                     onAbout: () {},
//                     onTestimonials: () {},
//                     onBlog: () {},
//                     onContact: () {},
//                   ),
//
//                   Container(
//                     width: double.infinity,
//                     padding: EdgeInsets.symmetric(
//                       horizontal: isMobile ? 24 : 100,
//                       vertical: 60,
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         BlocBuilder<AppBootstrapBloc, AppBootstrapState>(
//                           builder: (context, state) {
//                             switch (state.status) {
//                               case AppBootstrapStatus.loading:
//                                 return const AdaptiveShimmer(
//                                   layout: ShimmerLayout.hero,
//                                 );
//
//                               case AppBootstrapStatus.failure:
//                                 return Center(
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       const Text('Failed to load app data'),
//                                       const SizedBox(height: 12),
//                                       ElevatedButton(
//                                         onPressed: () {
//                                           context.read<AppBootstrapBloc>().add(
//                                             RetryAppBootstrap(),
//                                           );
//                                         },
//                                         child: const Text('Retry'),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//
//                               case AppBootstrapStatus.success:
//                                 final data = state.data!;
//                                 final hero = data.heroes.firstWhere(
//                                   (h) => h.key == 'blog' && h.isActive,
//                                   orElse: () => data.heroes.first,
//                                 );
//                                 return HeroSection(
//                                   title: hero.headingText,
//                                   subtitle: hero.subHeadingText,
//                                   imagePath: resolveAssetUrl(hero.assetUrl),
//                                   featuredText: hero.gradientText,
//                                   showGradient: false,
//                                   isOverlayMode: false,
//                                   contentAlignment:
//                                       hero.isContentLeft
//                                           ? HeroContentAlignment.left
//                                           : hero.isContentRight
//                                           ? HeroContentAlignment.right
//                                           : HeroContentAlignment.center,
//                                 );
//
//                               default:
//                                 return const SizedBox.shrink();
//                             }
//                           },
//                         ),
//                         const SizedBox(height: 100),
//
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               "Browse Topics",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                                 letterSpacing: 1.2,
//                               ),
//                             ),
//                             if (!isMobile) _buildCategoryFilters(),
//                           ],
//                         ),
//
//                         if (isMobile) ...[
//                           const SizedBox(height: 20),
//                           _buildCategoryFilters(),
//                         ],
//                         const SizedBox(height: 40),
//                         const Divider(color: Colors.white10),
//                         const SizedBox(height: 60),
//
//                         // --- MAIN BLOG GRID ---
//                         GridView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: itemsPerPage,
//                           gridDelegate:
//                               SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: _getCrossAxisCount(width),
//                                 crossAxisSpacing: 35,
//                                 mainAxisSpacing: 50,
//                                 childAspectRatio: _getResponsiveAspectRatio(
//                                   width,
//                                   isMobile,
//                                   isTablet,
//                                 ),
//                               ),
//                           itemBuilder: (_, index) {
//                             int blogId =
//                                 ((currentPage - 1) * itemsPerPage) + index + 1;
//                             final currentBlog = BlogModel(
//                               id: "$blogId",
//                               title: "How to Scale your Business $blogId",
//                               shortDescription:
//                                   "Explore our most popular designs crafted with precision and creativity.",
//                               placeholderImage:
//                                   "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f",
//                               categoryId: "Marketing",
//                               author: "John Doe",
//                               createdAt: DateTime(2025, 12, 24),
//                               readingTime: 3,
//                               categoryName: "",
//                             );
//
//                             return BlogCard(
//                               blog: currentBlog,
//                               onTap:
//                                   () => context.go(
//                                     '/blog/$blogId',
//                                     extra: currentBlog,
//                                   ),
//                             );
//                           },
//                         ),
//
//                         const SizedBox(height: 80),
//                         _buildPaginationControls(), // Updated functional widget
//                         const SizedBox(height: 60),
//                         Divider(
//                           color: Colors.white.withOpacity(0.08),
//                           thickness: 1,
//                         ),
//                         const SizedBox(height: 80),
//
//                         HeroSection(
//                           title: "Featured Articles",
//                           subtitle: "",
//                           featuredText: "TRENDING TOPICS",
//                           featuredColor: Colors.redAccent,
//                           showNavigationArrows: false,
//                           isOverlayMode: false,
//                           contentAlignment: HeroContentAlignment.left,
//                           customButtons: const [],
//                         ),
//
//                         const SizedBox(height: 50),
//                         _buildTrendingSection(width, isMobile, isTablet),
//                         const SizedBox(height: 60),
//                         Divider(
//                           color: Colors.white.withOpacity(0.08),
//                           thickness: 1,
//                         ),
//                         const SizedBox(height: 40),
//                         const ContactSection(),
//                         const FooterSection(),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTrendingSection(double width, bool isMobile, bool isTablet) {
//     return Column(
//       children: [
//         GridView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: 3,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: _getCrossAxisCount(width),
//             crossAxisSpacing: 35,
//             mainAxisSpacing: 50,
//             childAspectRatio: _getResponsiveAspectRatio(
//               width,
//               isMobile,
//               isTablet,
//             ),
//           ),
//           itemBuilder: (_, index) {
//             final trendingId = "trending_$index";
//             final trendingBlog = BlogModel(
//               id: trendingId,
//               title: "Trending Article Title ${index + 1}",
//               shortDescription: "Explore our most popular designs.",
//               placeholderImage:
//                   "https://images.unsplash.com/photo-1552664730-d307ca884978",
//               categoryId: "ED-Tech",
//               author: "Name",
//               createdAt: DateTime(2025, 12, 24),
//               readingTime: 3,
//               categoryName: "",
//             );
//
//             return BlogCard(
//               blog: trendingBlog,
//               onTap: () => context.go('/blog/$trendingId', extra: trendingBlog),
//             );
//           },
//         ),
//         const SizedBox(height: 50),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _pageArrow(Icons.arrow_back_ios_new, true, () {}),
//             const SizedBox(width: 40),
//             _pageArrow(Icons.arrow_forward_ios, true, () {}),
//           ],
//         ),
//       ],
//     );
//   }
//
//   // RESOLUTION: Fixed Right Overflow by using Wrap and dynamic mapping
//   Widget _buildPaginationControls() {
//     final visiblePages = _getVisiblePageNumbers();
//
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 20),
//       child: Wrap(
//         // Wrap prevents the Right Overflow error
//         alignment: WrapAlignment.center,
//         crossAxisAlignment: WrapCrossAlignment.center,
//         spacing: 10, // Horizontal space between numbers
//         runSpacing: 10, // Vertical space if it wraps to next line
//         children: [
//           _pageArrow(
//             Icons.chevron_left,
//             currentPage > 1,
//             () => _changePage(currentPage - 1),
//           ),
//
//           ...visiblePages.map((num) {
//             if (num < 0) {
//               return const Text(
//                 "...",
//                 style: TextStyle(color: Colors.white24, fontSize: 18),
//               );
//             }
//             return _pageNumber(num);
//           }),
//
//           _pageArrow(
//             Icons.chevron_right,
//             currentPage < totalPages,
//             () => _changePage(currentPage + 1),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _pageNumber(int num) {
//     bool active = currentPage == num;
//     return GestureDetector(
//       onTap: () => _changePage(num),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
//         decoration: BoxDecoration(
//           color:
//               active ? const Color(0xFF8B5CF6) : Colors.white.withOpacity(0.03),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: active ? Colors.white24 : Colors.transparent,
//           ),
//         ),
//         child: Text(
//           "$num",
//           style: TextStyle(
//             color: active ? Colors.white : Colors.white54,
//             fontWeight: active ? FontWeight.bold : FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _pageArrow(IconData icon, bool enabled, VoidCallback onTap) {
//     return InkWell(
//       onTap: enabled ? onTap : null,
//       borderRadius: BorderRadius.circular(50),
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: enabled ? Colors.white.withOpacity(0.02) : Colors.transparent,
//         ),
//         child: Icon(
//           icon,
//           color: enabled ? Colors.white : Colors.white12,
//           size: 18,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCategoryFilters() {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       physics: const BouncingScrollPhysics(),
//       child: Row(
//         children:
//             categories.map((cat) {
//               bool isSelected = selectedCategory == cat;
//               return GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     selectedCategory = cat;
//                     currentPage = 1;
//                   });
//                 },
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 200),
//                   margin: const EdgeInsets.only(right: 16),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 20,
//                     vertical: 10,
//                   ),
//                   decoration: BoxDecoration(
//                     color:
//                         isSelected
//                             ? Colors.white.withOpacity(0.08)
//                             : Colors.transparent,
//                     borderRadius: BorderRadius.circular(30),
//                     border: Border.all(
//                       color:
//                           isSelected
//                               ? const Color(0xFF8B5CF6).withOpacity(0.5)
//                               : Colors.white10,
//                     ),
//                   ),
//                   child: Text(
//                     cat,
//                     style: TextStyle(
//                       color: isSelected ? Colors.white : Colors.white38,
//                       fontWeight:
//                           isSelected ? FontWeight.bold : FontWeight.normal,
//                     ),
//                   ),
//                 ),
//               );
//             }).toList(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/bootstrap/bloc/app_bootstrap_bloc.dart';
import '../../../../core/bootstrap/bloc/app_bootstrap_event.dart';
import '../../../../core/hero/hero_mapper.dart';
import '../../utils/responsive.dart';
import '../../widgets/blog_card.dart';
import '../../widgets/top_nav_bar.dart';
import '../blog/bloc/blog_bloc.dart';
import '../blog/bloc/blog_event.dart';
import '../blog/bloc/blog_state.dart';
import '../common/footer_section.dart';
import '../home/contact_section.dart';
import '../home/custom_shimmer.dart';
import '../home/hero_section.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  String selectedCategory = "All";

  final List<String> categories = const [
    "All",
    "Marketing",
    "Education",
    "Web developement",
    "Design",
  ];

  int _getCrossAxisCount(double width) {
    if (width >= 1100) return 3;
    if (width >= 700) return 2;
    return 1;
  }

  double _getAspectRatio(double width, bool isMobile, bool isTablet) {
    if (isMobile) return width / 680;
    if (isTablet) return 0.78;
    return 0.85;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final heros = context.watch<AppBootstrapBloc>().state.data;
    final bootStrap = context.watch<AppBootstrapBloc>().state.data?.profile;
    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopNavBar(
              activeIndex: 4,
              onHome: () => context.push("/"),
              onDesigns: () => context.push("/designs"),
              onAbout: () => context.push("/about"),
              onTestimonials: () {},
              onBlog: () {},
              onContact: () => context.push("/contact"),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 100,
                vertical: 60,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ───────── HERO ─────────
                  BlocBuilder<BlogBloc, BlogState>(
                    builder: (context, state) {
                      if (state.detailStatus == BlogStatus.initial) {
                        return const AdaptiveShimmer(
                          layout: ShimmerLayout.hero,
                        );
                      }

                      if (state.detailStatus == BlogStatus.failure) {
                        return Center(
                          child: ElevatedButton(
                            onPressed:
                                () => context.read<AppBootstrapBloc>().add(
                                  RetryAppBootstrap(),
                                ),
                            child: const Text("Retry"),
                          ),
                        );
                      }

                      final hero = heros!.heroes.firstWhere(
                        (h) => h.key == 'blog' && h.isActive,
                        orElse: () => heros.heroes.first,
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

                  const SizedBox(height: 100),

                  // ───────── CATEGORY FILTER ─────────
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
                      if (!isMobile) _buildCategoryFilters(context),
                    ],
                  ),

                  if (isMobile) ...[
                    const SizedBox(height: 20),
                    _buildCategoryFilters(context),
                  ],

                  const SizedBox(height: 60),
                  const Divider(color: Colors.white10),

                  const SizedBox(height: 60),

                  // ───────── BLOG GRID ─────────
                  BlocBuilder<BlogBloc, BlogState>(
                    builder: (context, state) {
                      if (state.listStatus == BlogStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state.listStatus == BlogStatus.failure) {
                        return _EmptyState(
                          title: "Failed to load blogs",
                          subtitle: state.errorMessage ?? "Try again later",
                        );
                      }

                      if (state.blogs.isEmpty) {
                        return const _EmptyState(
                          title: "No blogs found",
                          subtitle: "We’ll be publishing fresh content soon.",
                        );
                      }

                      return Column(
                        children: [
                          GridView.builder(
                            addSemanticIndexes: true,
                            addRepaintBoundaries: true,
                            addAutomaticKeepAlives: true,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.blogs.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: _getCrossAxisCount(width),
                                  crossAxisSpacing: 35,
                                  mainAxisSpacing: 50,
                                  childAspectRatio: _getAspectRatio(
                                    width,
                                    isMobile,
                                    isTablet,
                                  ),
                                ),
                            itemBuilder: (_, index) {
                              final blog = state.blogs[index];
                              return RepaintBoundary(
                                child: BlogCard(
                                  blog: blog,
                                  onTap:
                                      () => context.push(
                                        '/blog/${blog.id}',
                                        extra: blog,
                                      ),
                                ),
                              );
                            },
                          ),

                          if (state.hasMore) ...[
                            const SizedBox(height: 60),
                            ElevatedButton(
                              autofocus: true,
                              onPressed:
                                  () => context.read<BlogBloc>().add(
                                    FetchBlogs(
                                      page: state.page + 1,
                                      categoryId:
                                          selectedCategory == "All"
                                              ? null
                                              : selectedCategory,
                                      loadMore: true,
                                    ),
                                  ),
                              child: const Text("Load More"),
                            ),
                          ],
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
            const ContactSection(),
            const FooterSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilters(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            categories.map((cat) {
              final isSelected = selectedCategory == cat;
              return GestureDetector(
                onTap: () {
                  setState(() => selectedCategory = cat);
                  context.read<BlogBloc>().add(
                    FetchBlogs(page: 1, categoryId: cat == "All" ? null : cat),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color:
                          isSelected ? const Color(0xFF8B5CF6) : Colors.white12,
                    ),
                  ),
                  child: Text(
                    cat,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white54,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String title;
  final String subtitle;

  const _EmptyState({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          const Icon(Icons.article_outlined, size: 64, color: Colors.white24),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white38),
          ),
        ],
      ),
    );
  }
}
