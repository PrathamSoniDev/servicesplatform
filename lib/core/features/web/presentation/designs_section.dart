import 'package:flutter/material.dart';
import 'package:servicesplatform/core/features/web/models/design_item_models.dart';
import 'package:servicesplatform/core/features/web/utils/responsive.dart';
import 'package:servicesplatform/core/features/web/widgets/animated_border.dart';
import 'package:servicesplatform/core/features/web/widgets/card.dart';

class DesignsSection extends StatefulWidget {
  const DesignsSection({super.key});

  @override
  State<DesignsSection> createState() => _DesignsSectionState();
}

class _DesignsSectionState extends State<DesignsSection> {
  final ScrollController _scrollController = ScrollController();

  void _scroll(double offset) {
    _scrollController.animateTo(
      _scrollController.offset + offset,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutQuart,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    
final double sidePadding = Responsive.isDesktop(context)
    ? 96
    : Responsive.isTablet(context)
        ? 56
        : 24;

final double cardWidth = Responsive.isDesktop(context)
    ? 320
    : Responsive.isTablet(context)
        ? 300
        : 260;

final double sectionHeight = Responsive.isDesktop(context)
    ? 520
    : Responsive.isTablet(context)
        ? 480
        : 440;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 96),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Color(0xFF0A0A0A),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ───────────────── HEADER ─────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sidePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "PORTFOLIO",
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 13,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Selected Work",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 52,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.4,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "A carefully curated selection of interface designs,\ncrafted with precision, clarity, and refined motion.",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 17,
                    height: 1.7,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 64),

          // ───────────────── CARD SHOWCASE ─────────────────
          SizedBox(
            height: sectionHeight,
            child: Stack(
              children: [
                ListView.separated(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: sidePadding),
                  itemCount: designs.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 48),
                  itemBuilder: (context, index) {
                    final item = designs[index];

                    return SizedBox(
                      width: cardWidth,
                      child: AnimatedBorder(
                        radius: 22,
                        child: SimpleContentCard(
                          imageUrl: item.image,
                          title: item.title,
                          description: item.description,
                          likes: item.likes,
                          views: item.views,
                        ),
                      ),
                    );
                  },
                ),

                // Left Arrow
                if (isDesktop)
                  Positioned(
                    left: 24,
                    top: 0,
                    bottom: 0,
                    child: _LuxuryArrow(
                      icon: Icons.arrow_back_ios_new,
                      onTap: () => _scroll(-cardWidth * 1.3),
                    ),
                  ),

                // Right Arrow
                if (isDesktop)
                  Positioned(
                    right: 24,
                    top: 0,
                    bottom: 0,
                    child: _LuxuryArrow(
                      icon: Icons.arrow_forward_ios,
                      onTap: () => _scroll(cardWidth * 1.3),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 48),

          // ───────────────── FOOTER CTA ─────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sidePadding),
            child: Row(
              children: const [
                Text(
                  "View complete case studies",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    letterSpacing: 0.6,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                Spacer(),
                Text(
                  "Drag or scroll horizontally",
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 14,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LuxuryArrow extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _LuxuryArrow({
    required this.icon,
    required this.onTap,
  });

  @override
  State<_LuxuryArrow> createState() => _LuxuryArrowState();
}

class _LuxuryArrowState extends State<_LuxuryArrow> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOutCubic,
        child: AnimatedOpacity(
          opacity: _pressed ? 0.9 : 1.0,
          duration: const Duration(milliseconds: 140),
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOutCubic,
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.45),
                border: Border.all(color: Colors.white24),
                boxShadow: [
                  // 🔹 INNER GLOW illusion (top)
                  BoxShadow(
                    color: Colors.white.withOpacity(_pressed ? 0.18 : 0.10),
                    blurRadius: 6,
                    spreadRadius: -2,
                    offset: const Offset(0, -1),
                  ),

                  // 🔹 INNER GLOW illusion (bottom)
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    blurRadius: 6,
                    spreadRadius: -2,
                    offset: const Offset(0, 2),
                  ),

                  // 🔹 SUBTLE OUTER LIFT (very light)
                  if (_pressed)
                    BoxShadow(
                      color: Colors.white.withOpacity(0.08),
                      blurRadius: 12,
                      spreadRadius: 1,
                    ),
                ],
              ),
              child: Icon(
                widget.icon,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
