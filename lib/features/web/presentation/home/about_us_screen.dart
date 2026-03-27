import 'dart:async';
import 'package:flutter/material.dart';
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
      "desc": "We collaborate with clients to understand goals and define the right digital solution."
    },
    {
      "title": "Design & Architecture",
      "desc": "Our team designs modern UI/UX and scalable architecture for long-term growth."
    },
    {
      "title": "Development",
      "desc": "We build high-performance web apps and mobile apps using modern technologies."
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

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppTheme.bgSoftGrey,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: Responsive.maxContentWidth(context),
            maxHeight: MediaQuery.of(context).size.height, // Hard constraint to screen height
          ),
          child: isMobile ? _buildMobileLayout(context) : _buildDesktopLayout(context),
        ),
      ),
    );
  }

  /// DESKTOP LAYOUT
  Widget _buildDesktopLayout(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.pagePadding(context)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5, 
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: _buildHeroText(context, false),
            ),
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

  /// MOBILE LAYOUT
  Widget _buildMobileLayout(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            const Spacer(flex: 2),
            // Hero section wrapped in Flexible to handle height constraints
            Flexible(
              flex: 8,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Responsive.pagePadding(context)),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: _buildHeroText(context, true),
                ),
              ),
            ),
            const Spacer(flex: 1),
            
            // Auto-Scrolling Card Carousel
            SizedBox(
              height: constraints.maxHeight * 0.35, // Dynamic height relative to screen
              child: PageView.builder(
                controller: _pageController,
                itemCount: steps.length,
                onPageChanged: (index) => setState(() => currentIndex = index),
                itemBuilder: (context, index) {
                  return AnimatedScale(
                    scale: currentIndex == index ? 1.0 : 0.9,
                    duration: const Duration(milliseconds: 400),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 400),
                      opacity: currentIndex == index ? 1.0 : 0.6,
                      child: Center(
                        child: _buildCard(context, steps[index], isMobile: true),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 15),

            // Animated Dots Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(steps.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 6,
                  width: currentIndex == index ? 20 : 6,
                  decoration: BoxDecoration(
                    color: currentIndex == index ? AppTheme.primaryGreen : AppTheme.textGrey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }),
            ),
            const Spacer(flex: 2),
          ],
        );
      }
    );
  }

  /// HERO TEXT
  Widget _buildHeroText(BuildContext context, bool isMobile) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.primaryGreen.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            "About Our Company",
            style: TextStyle(
              color: AppTheme.primaryGreen,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 16),
        RichText(
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          text: TextSpan(
            style: TextStyle(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.w900,
              height: 1.1,
              color: AppTheme.textBlack,
            ),
            children: [
              const TextSpan(text: "Building Digital\nProducts That\n"),
              TextSpan(
                text: "Drive Innovation",
                style: TextStyle(color: AppTheme.primaryGreen),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: Text(
            "We build high-quality digital products including mobile apps, web platforms, and scalable enterprise solutions.",
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: AppTheme.textGrey,
            ),
          ),
        ),
      ],
    );
  }

  /// TIMELINE DESKTOP
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
                if (isLeft) Expanded(child: _HoverCard(child: _buildCard(context, steps[index]))) else const Spacer(),
                
                // Vertical Connector Dot
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryGreen, 
                    shape: BoxShape.circle,
                  ),
                ),

                if (!isLeft) Expanded(child: _HoverCard(child: _buildCard(context, steps[index]))) else const Spacer(),
              ],
            ),
          ),
        );
      }),
    );
  }

  /// UNIVERSAL CARD
  Widget _buildCard(BuildContext context, Map step, {bool isMobile = false}) {
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.auto_awesome, color: AppTheme.primaryGreen, size: 18),
          ),
          const SizedBox(height: 10),
          Text(
            step["title"]!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w800, 
              fontSize: 16, 
              color: AppTheme.textBlack,
            ),
          ),
          const SizedBox(height: 4),
          Flexible(
            child: Text(
              step["desc"]!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
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