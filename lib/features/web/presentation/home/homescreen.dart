import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/features/web/presentation/home/testimonials_section.dart';

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

  int currentSectionIndex = 0;

  @override
  void initState() {
    super.initState();

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

                Container(key: heroKey, child: const HeroSection()),
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
            onHome: () => scrollToSection(0),
            onDesigns: () => scrollToSection(1),
            onAbout: () => scrollToSection(2),
            onTestimonials: () => scrollToSection(3),
            onBlog: () => scrollToSection(4),
            onContact: () => scrollToSection(5),
          ),
        ],
      ),
    );
  }
}
