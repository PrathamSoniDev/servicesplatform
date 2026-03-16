import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';
import 'package:servicesplatform/features/web/widgets/product_card.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  late PageController _pageController;
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.88);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final isMobile = Responsive.isMobile(context);
    final padding = Responsive.pagePadding(context);

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Container(
        width: double.infinity,
        color: const Color(0xFFFAFAFA),
        padding: EdgeInsets.symmetric(
          horizontal: padding,
          vertical: isMobile ? 40 : 70,
        ),

        child: Column(
          children: [

            /// HEADER
            _buildHeader(isMobile),

            SizedBox(height: isMobile ? 20 : 30),

            /// FEATURES
            Expanded(
              flex: isMobile ? 2 : 1,
              child: _buildProductIntro(isMobile),
            ),

            SizedBox(height: isMobile ? 10 : 30),

            /// PRODUCT CARDS
            Expanded(
              flex: 3,
              child: isMobile
                  ? _buildMobileCarousel()
                  : _buildDesktopGrid(),
            ),
          ],
        ),
      ),
    );
  }

  /// HEADER
  Widget _buildHeader(bool isMobile) {

    return Column(
      children: [

        Text(
          "Our Products",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile ? 30 : 48,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF1A1A1A),
            letterSpacing: -1,
          ),
        ),

        const SizedBox(height: 12),

        const Text(
          "We build platforms that help developers grow\nand companies build elite engineering teams.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF666666),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  /// FEATURES
  Widget _buildProductIntro(bool isMobile) {

    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: isMobile ? 18 : 40,
        runSpacing: isMobile ? 12 : 20,
        children: [

          _feature(
            Icons.psychology,
            "AI Learning",
            "Prepare for modern AI engineering.",
            isMobile,
          ),

          _feature(
            Icons.work_outline,
            "Hiring Platform",
            "Hire elite developers faster.",
            isMobile,
          ),

          _feature(
            Icons.trending_up,
            "Skill Tracking",
            "Track developer growth.",
            isMobile,
          ),
        ],
      ),
    );
  }

  Widget _feature(
    IconData icon,
    String title,
    String desc,
    bool isMobile,
  ) {

    return SizedBox(
      width: isMobile ? 110 : 220,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Container(
            height: isMobile ? 42 : 56,
            width: isMobile ? 42 : 56,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),

            child: Icon(
              icon,
              color: Colors.white,
              size: isMobile ? 20 : 26,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 13 : 16,
              fontWeight: FontWeight.w700,
            ),
          ),

          if (!isMobile) ...[
            const SizedBox(height: 6),

            Text(
              desc,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF666666),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// MOBILE
  Widget _buildMobileCarousel() {

    return Column(
      children: [

        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (idx) => setState(() => _activeIndex = idx),

            children: const [

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ProductCard(isDeveloper: true),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ProductCard(isDeveloper: false),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        _buildDots(),
      ],
    );
  }

  /// DESKTOP
  Widget _buildDesktopGrid() {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        _HoverLiftWrapper(
          child: const ProductCard(isDeveloper: true),
        ),

        const SizedBox(width: 40),

        _HoverLiftWrapper(
          child: const ProductCard(isDeveloper: false),
        ),
      ],
    );
  }

  /// DOTS
  Widget _buildDots() {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,

      children: List.generate(2, (index) {

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),

          height: 6,
          width: _activeIndex == index ? 20 : 6,

          decoration: BoxDecoration(
            color: _activeIndex == index
                ? Colors.black
                : Colors.black12,

            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    );
  }
}

/// HOVER LIFT EFFECT
class _HoverLiftWrapper extends StatefulWidget {

  final Widget child;

  const _HoverLiftWrapper({required this.child});

  @override
  State<_HoverLiftWrapper> createState() => _HoverLiftWrapperState();
}

class _HoverLiftWrapperState extends State<_HoverLiftWrapper> {

  bool hover = false;

  @override
  Widget build(BuildContext context) {

    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),

        transform: hover
            ? (Matrix4.identity()..translate(0, -12))
            : Matrix4.identity(),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),

          boxShadow: [

            BoxShadow(
              color: hover
                  ? Colors.black.withOpacity(0.15)
                  : Colors.transparent,

              blurRadius: 30,
              offset: const Offset(0, 20),
            ),
          ],
        ),

        child: widget.child,
      ),
    );
  }
}