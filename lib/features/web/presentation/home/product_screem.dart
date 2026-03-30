import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/features/web/presentation/seo/seo_widget.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/widgets/product_card.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _productScrollController = ScrollController();

  late final AnimationController _entranceCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  static const List<bool> _cards = [true, false, true, false];

  @override
  void initState() {
    super.initState();
    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnim = CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeOutCubic));
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _entranceCtrl.forward());
  }

  @override
  void dispose() {
    _entranceCtrl.dispose();
    _productScrollController.dispose();
    super.dispose();
  }

  void _scroll(bool isLeft, double viewportWidth) {
    final double move = viewportWidth * 0.78;
    final double target = isLeft
        ? (_productScrollController.offset - move)
            .clamp(0.0, _productScrollController.position.maxScrollExtent)
        : (_productScrollController.offset + move)
            .clamp(0.0, _productScrollController.position.maxScrollExtent);
    _productScrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 480),
      curve: Curves.easeInOutCubic,
    );
  }

 void _openProduct(BuildContext context, bool isDeveloper) {
context.push('/product/detail/${isDeveloper ? 'developer' : 'business'}');}
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final screenW = MediaQuery.of(context).size.width;
    final hPadding = Responsive.pagePadding(context);

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppTheme.bgOffWhite,
      child: FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: isMobile ? 24 : 44),

              // ── HEADER ──────────────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: hPadding),
                child: _ProductHeader(isMobile: isMobile, screenW: screenW),
              ),

              SizedBox(height: isMobile ? 20 : 36),

              // ── CARD SCROLL AREA ────────────────────────────────
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final maxW = constraints.maxWidth;
                    final maxH = constraints.maxHeight;

                    final double cardW = isMobile
                        ? (screenW < 300 ? screenW * 0.88 : maxW * 0.78)
                        : (isTablet ? 300.0 : 350.0);

                    final double cardH = maxH.clamp(160.0, 500.0);
                    final double arrowPad = isMobile ? 10.0 : 14.0;
                    final double arrowIcon = isMobile ? 18.0 : 22.0;

                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        // Card list
                        ListView.builder(
                          controller: _productScrollController,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 40 : 60,
                            vertical: 10,
                          ),
                          itemCount: _cards.length,
                          itemBuilder: (ctx, i) {
                            final isDev = _cards[i];
                            final route =
                                '/product/${isDev ? 'developer' : 'business'}';
                            final label =
                                isDev ? 'Developer Platform' : 'Business Platform';
                            return Padding(
                              padding: EdgeInsets.only(
                                  right: isMobile ? 16 : 24),
                              child: Center(
                                child: SizedBox(
                                  width: cardW,
                                  height: cardH - 20,
                                  child: SeoLink(
                                    url: route,
                                    text: label,
                                    child: ProductCard(
                                      isDeveloper: isDev,
                                      onTap: () => _openProduct(ctx, isDev),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        // ── ARROWS ────────────────────────────────
                        Positioned(
                          left: 8,
                          child: _ScrollArrow(
                            icon: Icons.arrow_back_ios_new_rounded,
                            onTap: () => _scroll(true, maxW),
                            padding: arrowPad,
                            iconSize: arrowIcon,
                          ),
                        ),
                        Positioned(
                          right: 8,
                          child: _ScrollArrow(
                            icon: Icons.arrow_forward_ios_rounded,
                            onTap: () => _scroll(false, maxW),
                            padding: arrowPad,
                            iconSize: arrowIcon,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              SizedBox(height: isMobile ? 20 : 32),

              // ── PLATFORM PILLS ────────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: hPadding),
                child: _PlatformPills(
  isMobile: isMobile,
  screenW: screenW,
),
              ),

              SizedBox(height: isMobile ? 24 : 44),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Header ────────────────────────────────────────────────────────────────────

class _ProductHeader extends StatelessWidget {
  final bool isMobile;
  final double screenW;
  const _ProductHeader({required this.isMobile, required this.screenW});

  @override
  Widget build(BuildContext context) {
    final titleSize = screenW < 360 ? 20.0 : (isMobile ? 26.0 : 46.0);
    final subSize = screenW < 360 ? 11.0 : (isMobile ? 13.0 : 16.0);
    final labelSize = screenW < 360 ? 9.0 : 11.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: 28,
                height: 1,
                color: AppTheme.primaryGreen.withOpacity(0.35)),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: AppTheme.primaryGreen.withOpacity(0.25)),
              ),
              child: SeoText(
                "OUR PLATFORMS",
                style: TextStyle(
                  color: AppTheme.primaryGreen,
                  fontWeight: FontWeight.w800,
                  fontSize: labelSize,
                  letterSpacing: 1.6,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
                width: 28,
                height: 1,
                color: AppTheme.primaryGreen.withOpacity(0.35)),
          ],
        ),
        SizedBox(height: isMobile ? 12 : 18),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: SeoHeading(
            "Powering Developers & Businesses",
            align: TextAlign.center,
            style: TextStyle(
              color: AppTheme.textBlack,
              fontSize: titleSize,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.8,
              height: 1.1,
            ),
          ),
        ),
        SizedBox(height: isMobile ? 8 : 12),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SeoText(
            "Whether you're a developer levelling up your skills\nor a company building high-performance teams.",
            align: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              color: AppTheme.textGrey,
              fontSize: subSize,
              height: 1.6,
            ),
          ),
        ),
        SizedBox(height: isMobile ? 10 : 14),
        Container(
          width: 44,
          height: 3,
          decoration: BoxDecoration(
            color: AppTheme.primaryGreen,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}

// ── Platform Pills ────────────────────────────────────────────────────────────

class _PlatformPills extends StatelessWidget {
  final bool isMobile;
  final double screenW;

  const _PlatformPills({
    required this.isMobile,
    required this.screenW,
  });

  void _openAllProducts(BuildContext context) {
  context.push('/product/all');
}

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 10,
      children: [
        SeoLink(
          url: '/product',
          text: 'All Products',
          child: _PlatformPill(
            label: "All Products",
            icon: Icons.apps, // 🔥 clean generic icon
            onTap: () => _openAllProducts(context),
            screenW: screenW,
          ),
        ),
      ],
    );
  }
}

class _PlatformPill extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final double screenW;
  const _PlatformPill({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.screenW,
  });

  @override
  State<_PlatformPill> createState() => _PlatformPillState();
}

class _PlatformPillState extends State<_PlatformPill> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: widget.screenW < 360 ? 14 : 18,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: _hovered ? AppTheme.primaryGreen : AppTheme.cardLight,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: _hovered ? AppTheme.primaryGreen : AppTheme.borderLight,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: widget.screenW < 360 ? 14 : 16,
                color: _hovered ? Colors.white : AppTheme.primaryGreen,
              ),
              const SizedBox(width: 7),
              Text(
                widget.label,
                style: TextStyle(
                  color: _hovered ? Colors.white : AppTheme.textBlack,
                  fontSize: widget.screenW < 360 ? 11 : 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Scroll Arrow ──────────────────────────────────────────────────────────────

class _ScrollArrow extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double padding;
  final double iconSize;
  const _ScrollArrow({
    required this.icon,
    required this.onTap,
    required this.padding,
    required this.iconSize,
  });

  @override
  State<_ScrollArrow> createState() => _ScrollArrowState();
}

class _ScrollArrowState extends State<_ScrollArrow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.all(widget.padding),
          decoration: BoxDecoration(
            color: _hovered ? AppTheme.primaryGreen : AppTheme.cardLight,
            shape: BoxShape.circle,
            border: Border.all(
              color: _hovered ? AppTheme.primaryGreen : AppTheme.borderLight,
              width: 1.5,
            ),
          ),
          child: Icon(
            widget.icon,
            size: widget.iconSize,
            color: _hovered ? Colors.white : AppTheme.textBlack,
          ),
        ),
      ),
    );
  }
}