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

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        int next = currentIndex + 1;
        if (next >= steps.length) next = 0;

        _pageController.animateToPage(
          next,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final padding = Responsive.pagePadding(context);
    final isMobile = Responsive.isMobile(context);

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Container(
        width: double.infinity,
        color: const Color(0xFFF7F8FA),

        padding: EdgeInsets.symmetric(
          horizontal: padding,
          vertical: isMobile ? 40 : 55,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1150),
            child: isMobile
                ? _buildMobileLayout()
                : _buildDesktopLayout(),
          ),
        ),
      ),
    );
  }

  /// DESKTOP
  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 5, child: _buildHeroText(false)),
        const SizedBox(width: 60),
        Expanded(flex: 5, child: _buildTimelineDesktop()),
      ],
    );
  }

  /// 🔥 MOBILE WITH ARROWS
  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        _buildHeroText(true),

        const SizedBox(height: 28),

        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _pageController,
            itemCount: steps.length,
            onPageChanged: (index) {
              setState(() => currentIndex = index);
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _HoverCard(
                  child: _buildCard(steps[index]),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 16),

        /// 🔥 ARROWS
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// LEFT BUTTON
            _navButton(
              icon: Icons.chevron_left,
              onTap: () {
                int prev = currentIndex - 1;
                if (prev < 0) prev = steps.length - 1;

                _pageController.animateToPage(
                  prev,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              },
            ),

            const SizedBox(width: 20),

            /// RIGHT BUTTON
            _navButton(
              icon: Icons.chevron_right,
              onTap: () {
                int next = currentIndex + 1;
                if (next >= steps.length) next = 0;

                _pageController.animateToPage(
                  next,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  /// NAV BUTTON UI
  Widget _navButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Icon(icon, size: 20, color: Colors.black87),
      ),
    );
  }

  /// HERO TEXT
  Widget _buildHeroText(bool isMobile) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen.withOpacity(0.12),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              "About Our Company",
              style: TextStyle(
                color: AppTheme.primaryGreen,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),

          const SizedBox(height: 18),

          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: isMobile ? 30 : 42,
                fontWeight: FontWeight.w800,
                height: 1.15,
                color: const Color(0xFF111827),
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

          const SizedBox(height: 16),

          const Text(
            "We build high-quality digital products including mobile apps, "
            "web platforms, and scalable enterprise solutions.",
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Color(0xFF4B5563),
            ),
          ),
        ],
      ),
    );
  }

  /// DESKTOP TIMELINE
  Widget _buildTimelineDesktop() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(steps.length, (index) {
        final bool left = index % 2 == 0;

        return Row(
          children: [
            if (left) _HoverCard(child: _buildCard(steps[index])),
            const Spacer(),
            Container(
              width: 9,
              height: 9,
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen,
                shape: BoxShape.circle,
              ),
            ),
            const Spacer(),
            if (!left) _HoverCard(child: _buildCard(steps[index])),
          ],
        );
      }),
    );
  }

  /// CARD
  Widget _buildCard(Map step) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.auto_awesome, color: AppTheme.primaryGreen, size: 16),
          ),

          const SizedBox(height: 10),

          Text(
            step["title"]!,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111827),
            ),
          ),

          const SizedBox(height: 4),

          Text(
            step["desc"]!,
            style: const TextStyle(
              fontSize: 12.5,
              height: 1.5,
              color: Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}

/// HOVER EFFECT
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
        duration: const Duration(milliseconds: 180),
        transform: Matrix4.identity()..translate(0, hover ? -6 : 0),
        child: widget.child,
      ),
    );
  }
}