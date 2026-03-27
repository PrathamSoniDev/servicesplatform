import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/widgets/product_card.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ScrollController _productScrollController = ScrollController();

  void openProduct(BuildContext context, bool isDeveloper) {
    final type = isDeveloper ? 'developer' : 'business';
    context.go('/product/$type');
  }

  void _scroll(bool isLeft) {
    // Adjusted move distance to be more dynamic for smaller screens
    double move = MediaQuery.of(context).size.width * 0.6; 
    _productScrollController.animateTo(
      isLeft 
          ? _productScrollController.offset - move 
          : _productScrollController.offset + move,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _productScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final horizontalPadding = Responsive.pagePadding(context);

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppTheme.bgOffWhite,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              const Spacer(flex: 2),

              /// TITLE & SUBTITLE SECTION
              Flexible(
                flex: 6,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Powering Developers & Businesses",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                              fontSize: isMobile ? 28 : 48,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -1,
                              color: AppTheme.textBlack,
                            ),
                      ),
                      const SizedBox(height: 16),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 700),
                        child: Text(
                          "Whether you're a developer looking to level up your skills\nor a company building high-performance teams.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontSize: isMobile ? 14 : 18,
                                height: 1.6,
                                color: AppTheme.textGrey,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(flex: 1),

              /// HORIZONTAL SCROLL AREA
              Flexible(
                flex: 14,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ListView(
                      controller: _productScrollController,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true, 
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      children: [
                        _buildConstrainedCard(context, true, constraints),
                        const SizedBox(width: 20),
                        _buildConstrainedCard(context, false, constraints),
                        const SizedBox(width: 20),
                        _buildConstrainedCard(context, true, constraints),
                        const SizedBox(width: 20),
                        _buildConstrainedCard(context, false, constraints),
                      ],
                    ),
                    
                    /// ARROWS: Now explicitly visible on Mobile/Small Screens
                    /// We use a small horizontal offset so they don't block the card content too much
                    if (isMobile) ...[
                      Positioned(
                        left: -10,
                        child: _ArrowButton(
                          icon: Icons.chevron_left, 
                          onTap: () => _scroll(true),
                          isSmall: true,
                        ),
                      ),
                      Positioned(
                        right: -10,
                        child: _ArrowButton(
                          icon: Icons.chevron_right, 
                          onTap: () => _scroll(false),
                          isSmall: true,
                        ),
                      ),
                    ] else ...[
                      // Optional: Keep arrows for desktop but style them differently if needed
                      Positioned(
                        left: 0,
                        child: _ArrowButton(icon: Icons.chevron_left, onTap: () => _scroll(true)),
                      ),
                      Positioned(
                        right: 0,
                        child: _ArrowButton(icon: Icons.chevron_right, onTap: () => _scroll(false)),
                      ),
                    ]
                  ],
                ),
              ),

              const Spacer(flex: 2),
            ],
          );
        },
      ),
    );
  }

  Widget _buildConstrainedCard(BuildContext context, bool isDev, BoxConstraints constraints) {
    final isMobile = Responsive.isMobile(context);
    // On mobile, card is slightly narrower to ensure the next card is partially visible
    double cardWidth = isMobile ? constraints.maxWidth * 0.75 : 350;

    return Center(
      child: SizedBox(
        width: cardWidth,
        child: ProductCard(
          isDeveloper: isDev,
          onTap: () => openProduct(context, isDev),
        ),
      ),
    );
  }
}

/// Updated Helper Widget for Scroll Arrows
class _ArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isSmall;

  const _ArrowButton({
    required this.icon, 
    required this.onTap,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        visualDensity: isSmall ? VisualDensity.compact : VisualDensity.standard,
        icon: Icon(
          icon, 
          color: AppTheme.textBlack,
          size: isSmall ? 20 : 24,
        ),
        onPressed: onTap,
      ),
    );
  }
}