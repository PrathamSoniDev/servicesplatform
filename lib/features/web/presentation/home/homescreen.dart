import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/core/app_router.dart';
import 'package:servicesplatform/features/web/presentation/home/testimonials_section.dart';
import 'package:servicesplatform/features/web/widgets/button.dart';

import '../../../../core/bootstrap/bloc/app_bootstrap_bloc.dart';
import '../../../../core/bootstrap/bloc/app_bootstrap_event.dart';
import '../../../../core/bootstrap/bloc/app_bootstrap_state.dart';
import '../../../../core/hero/hero_mapper.dart';
import '../../../../services/hero_repository.dart';
import '../../widgets/top_nav_bar.dart';
import '../common/footer_section.dart';
import 'about_section.dart';
import 'blog_section.dart';
import 'contact_section.dart';
import 'custom_shimmer.dart';
import 'designs_section.dart';
import 'hero_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  late String currentRoute;
  // Section keys
  final heroKey = GlobalKey();
  final designsKey = GlobalKey();
  final aboutKey = GlobalKey();
  final testimonialsKey = GlobalKey();
  final blogKey = GlobalKey();
  final contactKey = GlobalKey();
  late final List<GlobalKey> _sectionKeys;
  late final HeroRepository _heroRepository;

  int currentSectionIndex = 0;

  @override
  void initState() {
    super.initState();

    _heroRepository = HeroRepository();
    // _heroRepository.refreshHeroes();
    _sectionKeys = [
      heroKey,
      designsKey,
      aboutKey,
      testimonialsKey,
      blogKey,
      contactKey,
    ];

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    currentRoute = GoRouterState.of(context).uri.toString();
    super.didChangeDependencies();
  }

  // ───────────────── SCROLL SPY ─────────────────
  void _onScroll() {
    for (int i = 0; i < _sectionKeys.length; i++) {
      final context = _sectionKeys[i].currentContext;
      if (context == null) continue;

      final box = context.findRenderObject() as RenderBox;
      final position = box.localToGlobal(Offset.zero).dy;

      // Navbar height ≈ 72
      if (position <= 120 && position + box.size.height > 120) {
        if (currentSectionIndex != i) {
          setState(() => currentSectionIndex = i);
        }
        break;
      }
    }
  }

  // ───────────────── SCROLL TO SECTION ─────────────────
  void scrollToSection(int index) {
    final ctx = _sectionKeys[index].currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
        alignment: 0.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ───────── CONTENT ─────────
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 72), // space for navbar
                // Container(
                //   key: heroKey,
                //   child: FutureBuilder<List<HeroModel>>(
                //     future: _heroRepository.getHeroes(),
                //     builder: (context, snapshot) {
                //       // ⏳ Loading (Shimmer / Placeholder)
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return HeroSection(title: "", isLoading: true);
                //       }
                //
                //       // ❌ Error or empty
                //       if (snapshot.hasError ||
                //           !snapshot.hasData ||
                //           snapshot.data!.isEmpty) {
                //         return const SizedBox.shrink();
                //       }
                //
                //       // ✅ Pick HOME hero
                //       final hero = snapshot.data!.firstWhere(
                //         (h) => h.key == 'home' && h.isActive,
                //         orElse: () => snapshot.data!.first,
                //       );
                //       debugPrint("Debugging Asset Url : ${hero.assetUrl}");
                //       return HeroSection(
                //         title: hero.headingText,
                //         subtitle: hero.subHeadingText,
                //         imagePath: resolveAssetUrl(hero.assetUrl),
                //         gradientText: hero.gradientText,
                //         showGradient: hero.gradientText != null,
                //
                //         isOverlayMode: true,
                //         contentAlignment:
                //             hero.isContentLeft
                //                 ? HeroContentAlignment.left
                //                 : hero.isContentRight
                //                 ? HeroContentAlignment.right
                //                 : HeroContentAlignment.center,
                //
                //         customButtons: [
                //           AppButton(
                //             text: hero.primaryButtonText ?? "View Designs",
                //             onPressed:
                //                 () => context.push(
                //                   hero.ctaPrimary ?? AppRouter.blog,
                //                 ),
                //           ),
                //
                //           AppButton(
                //             text: "Book Us",
                //             type: AppButtonType.outline,
                //             onPressed: () => context.push(AppRouter.contact),
                //           ),
                //         ],
                //       );
                //     },
                //   ),
                // ),
                BlocBuilder<AppBootstrapBloc, AppBootstrapState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case AppBootstrapStatus.loading:
                        return const AdaptiveShimmer(
                          layout: ShimmerLayout.hero,
                        );

                      case AppBootstrapStatus.failure:
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('Failed to load app data'),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<AppBootstrapBloc>().add(
                                    RetryAppBootstrap(),
                                  );
                                },
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        );

                      case AppBootstrapStatus.success:
                        final data = state.data!;
                        final hero = data.heroes.firstWhere(
                          (h) => h.key == 'home' && h.isActive,
                          orElse: () => data.heroes.first,
                        );
                        return Container(
                          key: heroKey,
                          child: HeroSection(
                            title: hero.headingText,
                            subtitle: hero.subHeadingText,
                            imagePath: resolveAssetUrl(hero.assetUrl),
                            gradientText: hero.gradientText,
                            showGradient: hero.gradientText != null,

                            isOverlayMode: true,
                            contentAlignment:
                                hero.isContentLeft
                                    ? HeroContentAlignment.left
                                    : hero.isContentRight
                                    ? HeroContentAlignment.right
                                    : HeroContentAlignment.center,

                            customButtons: [
                              AppButton(
                                text: hero.primaryButtonText ?? "View Designs",
                                onPressed:
                                    () => context.go(
                                      hero.ctaPrimary ?? AppRouter.blog,
                                    ),
                              ),

                              AppButton(
                                text:
                                    hero.secondaryButtonText ?? "View Designs",
                                type: AppButtonType.outline,
                                onPressed:
                                    () => context.go(
                                      hero.ctaSecondary ?? AppRouter.blog,
                                    ),
                              ),
                            ],
                          ),
                        );

                      default:
                        return const SizedBox.shrink();
                    }
                  },
                ),
                Container(key: designsKey, child: const DesignsSection()),
                Container(key: aboutKey, child: const AboutSection()),
                Container(
                  key: testimonialsKey,
                  child: const TestimonialSection(),
                ),
                Container(key: blogKey, child: const BlogSection()),
                Container(key: contactKey, child: const ContactSection()),
                const FooterSection(),
              ],
            ),
          ),

          // ───────── NAVBAR ─────────
          TopNavBar(
            activeIndex: currentSectionIndex,
            onHome:
                () =>
                    currentRoute == AppRouter.home
                        ? scrollToSection(0)
                        : context.go(AppRouter.home),
            onDesigns: () => scrollToSection(1),
            onAbout:
                () =>
                    currentRoute == AppRouter.home
                        ? scrollToSection(2)
                        : context.push(AppRouter.aboutUs),
            onTestimonials: () => scrollToSection(3),
            onBlog: () => scrollToSection(4),
            onContact:
                () =>
                    currentRoute == AppRouter.home
                        ? scrollToSection(5)
                        : context.push(AppRouter.contact),
          ),
        ],
      ),
    );
  }
}
