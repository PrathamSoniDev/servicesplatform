import 'package:flutter/material.dart';
import 'package:servicesplatform/core/features/web/presentation/about_section.dart';
import 'package:servicesplatform/core/features/web/presentation/blog_section.dart';
import 'package:servicesplatform/core/features/web/presentation/contact_section.dart';
import 'package:servicesplatform/core/features/web/presentation/designs_section.dart';
import 'package:servicesplatform/core/features/web/presentation/hero_section.dart';
import 'package:servicesplatform/core/features/web/widgets/top_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  final heroKey = GlobalKey();
  final designsKey = GlobalKey();
  final aboutKey = GlobalKey();
  final blogKey = GlobalKey();
  final contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// ✅ Reliable scroll for web
  void scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return;

    final box = context.findRenderObject() as RenderBox;
    final position = box.localToGlobal(
      Offset.zero,
      ancestor: this.context.findRenderObject(),
    );

    final targetOffset =
        _scrollController.offset + position.dy - 72; // navbar height

    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// 🌍 ONE GLOBAL SCROLL (WEB SAFE)
          SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 72), // navbar space

                Container(
                  key: heroKey,
                  child: const HeroSection(),
                ),

                const SizedBox(height: 140),

                Container(
                  key: designsKey,
                  child: const DesignsSection(),
                ),

                const SizedBox(height: 140),

                Container(
                  key: aboutKey,
                  child: const AboutSection(),
                ),

                const SizedBox(height: 140),

                Container(
                  key: blogKey,
                  child: const BlogSection(),
                ),

                const SizedBox(height: 140),

                Container(
                  key: contactKey,
                  child: const ContactSection(),
                ),

                const SizedBox(height: 120),
              ],
            ),
          ),

          /// 🧭 FLOATING NAVBAR
          TopNavBar(
            onHome: () => scrollTo(heroKey),
            onDesigns: () => scrollTo(designsKey),
            onAbout: () => scrollTo(aboutKey),
            onBlog: () => scrollTo(blogKey),
            onContact: () => scrollTo(contactKey),
          ),
        ],
      ),
    );
  }
}
