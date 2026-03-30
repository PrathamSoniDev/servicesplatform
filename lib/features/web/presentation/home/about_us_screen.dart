import 'dart:async';
import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/presentation/seo/seo_widget.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  Timer? _timer;
  int currentIndex = 0;

  final List<Map<String, String>> steps = [
    {
      "title": "Product Discovery",
      "desc":
          "We collaborate with clients to understand goals and define the right digital solution."
    },
    {
      "title": "Design & Architecture",
      "desc":
          "Our team designs modern UI/UX and scalable architecture for long-term growth."
    },
    {
      "title": "Development",
      "desc":
          "We build high-performance web apps and mobile apps using modern technologies."
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        int next = currentIndex + 1;
        if (next >= steps.length) {
          _pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutQuart,
          );
        } else {
          _animateToPage(next);
        }
      }
    });
  }

  void _animateToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutQuart,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return SeoWrapper(
      child: SeoBody(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppTheme.bgSoftGrey,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: Responsive.maxContentWidth(context),
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: isMobile
                  ? _buildMobileLayout(context)
                  : _buildDesktopLayout(context),
            ),
          ),
        ),
      ),
    );
  }

  /// DESKTOP
  Widget _buildDesktopLayout(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Responsive.pagePadding(context)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: _buildHeroText(context, false), // ❌ removed FittedBox
          ),
          const SizedBox(width: 40),
          Expanded(
            flex: 6,
            child: _buildTimelineDesktop(context),
          ),
        ],
      ),
    );
  }

  /// MOBILE
  Widget _buildMobileLayout(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            const Spacer(flex: 2),
            Flexible(
              flex: 8,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Responsive.pagePadding(context)),
                child: _buildHeroText(context, true), // ❌ removed FittedBox
              ),
            ),
            const Spacer(flex: 1),
            SizedBox(
              height: constraints.maxHeight * 0.35,
              child: PageView.builder(
                controller: _pageController,
                itemCount: steps.length,
                onPageChanged: (index) =>
                    setState(() => currentIndex = index),
                itemBuilder: (context, index) {
                  return AnimatedScale(
                    scale: currentIndex == index ? 1.0 : 0.9,
                    duration: const Duration(milliseconds: 400),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 400),
                      opacity: currentIndex == index ? 1.0 : 0.6,
                      child: Center(
                        child: _buildCard(context, steps[index],
                            isMobile: true),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(steps.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 6,
                  width: currentIndex == index ? 20 : 6,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? AppTheme.primaryGreen
                        : AppTheme.textGrey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }),
            ),
            const Spacer(flex: 2),
          ],
        );
      },
    );
  }

  /// 🔥 HERO TEXT (BIG + RESPONSIVE)
  Widget _buildHeroText(BuildContext context, bool isMobile) {
    final width = MediaQuery.of(context).size.width;

    double headingSize;
    double descSize;

    if (width < 600) {
      headingSize = 30;
      descSize = 14;
    } else if (width < 1000) {
      headingSize = 42;
      descSize = 16;
    } else if (width < 1400) {
      headingSize = 52;
      descSize = 18;
    } else {
      headingSize = 60; // 🔥 BIG desktop
      descSize = 20;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.primaryGreen.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const SeoText(
            "About Our Company",
            style: TextStyle(
              color: AppTheme.primaryGreen,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),

        const SizedBox(height: 16),

        /// 🔥 BIG HEADING
        SeoHeading(
          "Building Digital Products That Drive Innovation",
          style: TextStyle(
            fontSize: headingSize,
            fontWeight: FontWeight.w900,
            height: 1.15,
            color: AppTheme.textBlack,
          ),
          align: isMobile ? TextAlign.center : TextAlign.start,
        ),

        const SizedBox(height: 14),

        /// 🔥 BIG DESCRIPTION
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: SeoText(
            "We build high-quality digital products including mobile apps, web platforms, and scalable enterprise solutions.",
            align:
                isMobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              fontSize: descSize,
              height: 1.6,
              color: AppTheme.textGrey,
            ),
          ),
        ),
      ],
    );
  }

  /// TIMELINE DESKTOP (UNCHANGED)
  Widget _buildTimelineDesktop(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(steps.length, (index) {
        final bool isLeft = index % 2 == 0;
        return Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                if (isLeft)
                  Expanded(
                      child: _HoverCard(
                          child: _buildCard(context, steps[index])))
                else
                  const Spacer(),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryGreen,
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLeft)
                  Expanded(
                      child: _HoverCard(
                          child: _buildCard(context, steps[index])))
                else
                  const Spacer(),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCard(BuildContext context, Map step,
      {bool isMobile = false}) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300, maxHeight: 180),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.auto_awesome,
                color: AppTheme.primaryGreen, size: 18),
          ),
          const SizedBox(height: 10),
          SeoHeading(
            step["title"]!,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: AppTheme.textBlack,
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: SeoText(
              step["desc"]!,
              style: TextStyle(
                fontSize: 13,
                color: AppTheme.textGrey,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HoverCard extends StatefulWidget {
  final Widget child;
  const _HoverCard({required this.child});

  @override
  State<_HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<_HoverCard> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.identity()..translate(0, hover ? -8 : 0),
        alignment: Alignment.center,
        child: widget.child,
      ),
    );
  }
}