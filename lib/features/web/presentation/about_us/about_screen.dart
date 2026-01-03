import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/features/web/presentation/about_us/about_process_section.dart';
import 'package:servicesplatform/features/web/presentation/about_us/about_service_section.dart';
import 'package:servicesplatform/features/web/presentation/about_us/about_values_section.dart';
import 'package:servicesplatform/features/web/presentation/common/footer_section.dart';
import 'package:servicesplatform/features/web/presentation/home/blog_section.dart';
import 'package:servicesplatform/features/web/presentation/home/contact_section.dart';
import 'package:servicesplatform/features/web/presentation/home/hero_section.dart';

import '../../../../core/bootstrap/bloc/app_bootstrap_bloc.dart';
import '../../../../core/bootstrap/bloc/app_bootstrap_event.dart';
import '../../../../core/bootstrap/bloc/app_bootstrap_state.dart';
import '../../../../core/hero/hero_mapper.dart';
import '../../widgets/top_nav_bar.dart';
import '../home/custom_shimmer.dart';

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
                          (h) => h.key == 'about' && h.isActive,
                          orElse: () => data.heroes.first,
                        );

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
                        );

                      default:
                        return const SizedBox.shrink();
                    }
                  },
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
            onHome: () => context.go('/'),
            onDesigns: () => context.go('/designs'),
            onAbout: () {},
            onTestimonials: () {},
            onBlog: () => context.go('/blog'),
            onContact: () => context.go('/contact'),
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
