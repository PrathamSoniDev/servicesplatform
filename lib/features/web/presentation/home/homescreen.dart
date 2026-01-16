import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/core/app_router.dart';
import 'package:servicesplatform/features/web/presentation/home/testimonials_section.dart';
import 'package:servicesplatform/features/web/widgets/button.dart';

import '../../../../core/hero/hero_mapper.dart';
import '../../../../core/hero/hero_model.dart';
import '../../../../services/hero_repository.dart';
import '../../widgets/top_nav_bar.dart';
import '../common/footer_section.dart';
import 'about_section.dart';
import 'blog_section.dart';
import 'contact_section.dart';
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
  bool _isAutoScrolling = false;
  final ValueNotifier<int> _sectionIndex = ValueNotifier(0);

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
    _sectionIndex.dispose();
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
      final ctx = _sectionKeys[i].currentContext;
      if (ctx == null) continue;

      final box = ctx.findRenderObject() as RenderBox;
      final position = box.localToGlobal(Offset.zero).dy;

      if (position <= 120 && position + box.size.height > 120) {
        if (_sectionIndex.value != i) {
          _sectionIndex.value = i; // ✅ NO REBUILD
        }
        break;
      }
    }
  }

  // ───────────────── SCROLL TO SECTION ─────────────────
  void scrollToSection(int index) async {
    final ctx = _sectionKeys[index].currentContext;
    if (ctx == null) return;

    _isAutoScrolling = true;

    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );

    // Delay allows scroll to settle
    Future.delayed(const Duration(milliseconds: 200), () {
      _isAutoScrolling = false;
    });
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
                //   child: HeroSection(
                //     title: "Your Digital Journey", // Main text
                //     gradientText:
                //         "Starts Here", // Text that will have the gradient
                //     showGradient: true, // Turn on gradient for Home
                //     subtitle: "Unlock bespoke web & app services.",
                //     imagePath: "assets/gif/jelly.gif",
                //     isOverlayMode: true,
                //     contentAlignment: HeroContentAlignment.center,
                //     customButtons: [
                //       const AppButton(text: "View Designs", onPressed: null),
                //       AppButton(
                //         text: "Book Us",
                //         type: AppButtonType.outline,
                //         onPressed: () {
                //           context.push(AppRouter.contact);
                //         },
                //       ),
                //     ],
                //   ),
                // ),
                Container(
                  key: heroKey,
                  child: FutureBuilder<List<HeroModel>>(
                    future: _heroRepository.getHeroes(),
                    builder: (context, snapshot) {
                      // ⏳ Loading (Shimmer / Placeholder)
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return HeroSection(title: "", isLoading: true);
                      }

                      // ❌ Error or empty
                      if (snapshot.hasError ||
                          !snapshot.hasData ||
                          snapshot.data!.isEmpty) {
                        return const SizedBox.shrink();
                      }

                      // ✅ Pick HOME hero
                      final hero = snapshot.data!.firstWhere(
                        (h) => h.key == 'home' && h.isActive,
                        orElse: () => snapshot.data!.first,
                      );
                      debugPrint("Debugging Asset Url : ${hero.assetUrl}");
                      return HeroSection(
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
                                () => context.push(
                                  hero.ctaPrimary ?? AppRouter.blog,
                                ),
                          ),

                          AppButton(
                            text: "Book Us",
                            type: AppButtonType.outline,
                            onPressed: () => context.push(AppRouter.contact),
                          ),
                        ],
                      );
                    },
                  ),
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
          ValueListenableBuilder<int>(
            valueListenable: _sectionIndex,
            builder: (_, index, __) {
              return TopNavBar(
                activeIndex: index,
                onHome: () => scrollToSection(0),
                onDesigns: () => scrollToSection(1),
                onAbout: () => scrollToSection(2),
                onTestimonials: () => scrollToSection(3),
                onBlog: () => scrollToSection(4),
                onContact: () => scrollToSection(5),
              );
            },
          ),
        ],
      ),
    );
  }
}
