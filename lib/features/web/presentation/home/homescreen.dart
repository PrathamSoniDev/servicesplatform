import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/presentation/home/about_us_screen.dart';
import 'package:servicesplatform/features/web/presentation/home/blog_screen.dart';
import 'package:servicesplatform/features/web/presentation/home/hero_section.dart';
import 'package:servicesplatform/features/web/presentation/home/industries_section.dart';
import 'package:servicesplatform/features/web/presentation/home/new_contact_screen.dart';
import 'package:servicesplatform/features/web/presentation/home/product_screem.dart';
/// ✅ SEO IMPORT
import 'package:servicesplatform/features/web/presentation/seo/seo_widget.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final PageController _pageController = PageController();
  double _currentPage = 0.0;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (mounted) {
        setState(() {
          _currentPage = _pageController.page ?? 0.0;
        });
      }
    });
  }

  void _safeScroll(int index, int total) {
    if (index < 0 || index >= total || _isAnimating) return;

    setState(() => _isAnimating = true);

    _pageController
        .animateToPage(
          index,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutQuart,
        )
        .then((_) {
          if (mounted) setState(() => _isAnimating = false);
        });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> sections = [
      /// ✅ HERO → HEADER (VERY IMPORTANT FOR SEO)
      SeoHeader(
        child: HeroSection(
          key: const ValueKey('hero'),
          onHomeTap: () => _safeScroll(0, 6),
          onAboutTap: () => _safeScroll(1, 6),
          onProductTap: () => _safeScroll(2, 6),
          onIndustriesTap: () => _safeScroll(3, 6),
          onBlogTap: () => _safeScroll(4, 6),
          onContactTap: () => _safeScroll(5, 6),
        ),
      ),

      /// ✅ बाकी sections → normal (already SEO inside them if needed)
      const AboutUsScreen(key: ValueKey('about')),
      const ProductScreen(key: ValueKey('product')),
      const IndustriesSection(key: ValueKey('industries')),
      const BlogScreen(key: ValueKey('blog')),
      const ContactScreen(key: ValueKey('contact')),
    ];

    return SeoWrapper(
      // 🔥 MOST IMPORTANT WRAPPER
      child: Scaffold(
        backgroundColor: AppTheme.darkBackground,

        body: SeoBody(
          // 🔥 BODY SEO
          child: Listener(
            onPointerSignal: (pointerSignal) {
              if (pointerSignal is PointerScrollEvent && !_isAnimating) {
                if (pointerSignal.scrollDelta.dy > 10) {
                  _safeScroll(_currentPage.round() + 1, sections.length);
                } else if (pointerSignal.scrollDelta.dy < -10) {
                  _safeScroll(_currentPage.round() - 1, sections.length);
                }
              }
            },
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (_isAnimating) return;
                if (details.delta.dy < -5) {
                  _safeScroll(_currentPage.round() + 1, sections.length);
                } else if (details.delta.dy > 5) {
                  _safeScroll(_currentPage.round() - 1, sections.length);
                }
              },
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                itemCount: sections.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  double relativePosition = index - _currentPage;
                  return ScrollRevealItem(
                    position: relativePosition,
                    child: sections[index],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ScrollRevealItem extends StatelessWidget {
  final Widget child;
  final double position;

  const ScrollRevealItem({
    super.key,
    required this.child,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    double scale = 1.0;
    double opacity = 1.0;

    if (position < 0 && position > -1) {
      scale = 1.0 + (position * 0.12);
      opacity = 1.0 + position;
    }

    return Opacity(
      opacity: opacity.clamp(0.0, 1.0),
      child: Transform(
        alignment: Alignment.center,
        transform:
            Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..scale(scale.clamp(0.85, 1.0)),
        child: child,
      ),
    );
  }
}
