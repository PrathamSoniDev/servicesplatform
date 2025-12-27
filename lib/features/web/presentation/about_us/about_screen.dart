import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/features/web/presentation/about_us/about_values_section.dart';

import '../../../../core/app_router.dart';
import '../../widgets/top_nav_bar.dart';
import '../home/about_section.dart';

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
                const SizedBox(height: 72), // Navbar space
                // Header (Image 1 Style)
                Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [Colors.purple.withOpacity(0.3), Colors.black],
                      center: Alignment.center,
                      radius: 0.8,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(40),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.purple.withOpacity(0.5),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.withOpacity(0.3),
                              blurRadius: 50,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: const Text(
                          "About us",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Learn more about our journey and vision",
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),

                // Content
                const AboutValuesSection(),
                const AboutSection(),

                const SizedBox(height: 100),
              ],
            ),
          ),
          TopNavBar(
            activeIndex: 2,
            onHome: () => context.go(AppRouter.home),
            onDesigns: () {},
            onAbout: () {},
            onTestimonials: () {},
            onBlog: () {},
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
