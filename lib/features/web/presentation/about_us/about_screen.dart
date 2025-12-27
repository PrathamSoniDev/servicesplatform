import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/features/web/presentation/about_us/about_process_section.dart';
import 'package:servicesplatform/features/web/presentation/about_us/about_service_section.dart';
import 'package:servicesplatform/features/web/presentation/about_us/about_values_section.dart';
import 'package:servicesplatform/features/web/presentation/common/footer_section.dart';
import 'package:servicesplatform/features/web/presentation/home/blog_section.dart';
import 'package:servicesplatform/features/web/presentation/home/contact_section.dart';
import 'package:servicesplatform/features/web/presentation/home/hero_section.dart';

import '../../../../core/app_router.dart';
import '../../widgets/top_nav_bar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const HeroSection(
                  title: "We’re the most trusted IT\n folks in India ",
                  imagePath: "assets/images/aboutUsRing.png",
                  contentAlignment: HeroContentAlignment.center,
                  isOverlayMode: true,
                  subtitle:
                      "Unlock bespoke web & app services at unbeatable prices",
                ),

                // Content
                const AboutValuesSection(),
                const ServicesSection(),
                const ProcessSection(),
                const BlogSection(),
                const ContactSection(),
                const FooterSection(),
              ],
            ),
          ),
          TopNavBar(
            activeIndex: 2,
            onHome: () => context.go(AppRouter.home),
            onDesigns: () {},
            onAbout: () {},
            onTestimonials: () {},
            onBlog: () => context.push(AppRouter.blog),
            onContact: () {},
          ),
          // Navbar
          // TopNavBar(
          //   onHome:
          //       () => Navigator.of(context).pushAndRemoveUntil(
          //         MaterialPageRoute(builder: (context) => const HomeScreen()),
          //         (route) => false,
          //       ),
          //   onDesigns:
          //       () => Navigator.of(context).pushAndRemoveUntil(
          //         MaterialPageRoute(
          //           builder: (context) => const HomeScreen(),
          //         ), // Ideally modify HomeScreen to scroll to Designs
          //         (route) => false,
          //       ),
          //   onAbout: () {}, // Already here
          //   onBlog:
          //       () => Navigator.of(context).pushAndRemoveUntil(
          //         MaterialPageRoute(builder: (context) => const HomeScreen()),
          //         (route) => false,
          //       ),
          //   onContact:
          //       () => Navigator.of(context).pushAndRemoveUntil(
          //         MaterialPageRoute(builder: (context) => const HomeScreen()),
          //         (route) => false,
          //       ),
          // ),
        ],
      ),
    );
  }
}
