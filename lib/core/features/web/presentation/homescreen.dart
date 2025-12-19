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
  final heroKey = GlobalKey();
  final designsKey = GlobalKey();
  final aboutKey = GlobalKey();
  final blogKey = GlobalKey();
  final contactKey = GlobalKey();

  void scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 72), // space for navbar

                Container(
                  key: heroKey,
                  child: const HeroSection(),
                ),
                Container(
                  key: designsKey,
                  child: const DesignsSection(),
                ),
                Container(
                  key: aboutKey,
                  child: const AboutSection(),
                ),
                Container(
                  key: blogKey,
                  child: const BlogSection(),
                ),
                Container(
                  key: contactKey,
                  child: const ContactSection(),
                ),
              ],
            ),
          ),

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
