import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';

class BlogCard extends StatefulWidget {
  final VoidCallback onTap;
  final String title;
  final String category;
  final String? description;

  const BlogCard({
    super.key,
    required this.onTap,
    required this.title,
    required this.category,
    this.description, required int customHeight,
  });

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) { if (!isMobile) setState(() => _hovered = true); },
      onExit:  (_) { if (!isMobile) setState(() => _hovered = false); },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          clipBehavior: Clip.antiAlias,
          transform: Matrix4.identity()
            ..translate(0.0, _hovered && !isMobile ? -4.0 : 0.0),
          transformAlignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFF111111),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _hovered
                  ? AppTheme.primaryGreen.withOpacity(0.65)
                  : Colors.white.withOpacity(0.07),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.40),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
              if (_hovered)
                BoxShadow(
                  color: AppTheme.primaryGreen.withOpacity(0.16),
                  blurRadius: 32,
                  spreadRadius: 2,
                  offset: const Offset(0, 10),
                ),
            ],
          ),
          // ── LayoutBuilder drives ALL responsive decisions ──────────────
          child: LayoutBuilder(
            builder: (context, box) {
              final w = box.maxWidth;
              final h = box.maxHeight;

              // Progressive breakpoints (purely by available card size)
              // Tier 1 – micro: only icon + category pill
              if (h < 110 || w < 120) {
                return _MicroCard(
                  category: widget.category,
                  hovered: _hovered,
                );
              }
              // Tier 2 – minimal: category + title only
              if (h < 180 || w < 180) {
                return _MinimalCard(
                  category: widget.category,
                  title: widget.title,
                  hovered: _hovered,
                  cardH: h,
                );
              }
              // Tier 3 – compact: category + title + arrow CTA
              if (h < 280 || w < 240) {
                return _CompactCard(
                  category: widget.category,
                  title: widget.title,
                  hovered: _hovered,
                  cardH: h,
                  cardW: w,
                );
              }
              // Tier 4 – standard: + image area + description (conditional)
              // Tier 5 – full:    + footer read-more
              return _FullCard(
                category: widget.category,
                title: widget.title,
                description: widget.description,
                hovered: _hovered,
                cardH: h,
                cardW: w,
                isMobile: isMobile,
              );
            },
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TIER 1 – MICRO  (h < 110 or w < 120)
// Just a centered category pill
// ─────────────────────────────────────────────────────────────────────────────
class _MicroCard extends StatelessWidget {
  final String category;
  final bool hovered;
  const _MicroCard({required this.category, required this.hovered});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        decoration: BoxDecoration(
          color: AppTheme.primaryGreen.withOpacity(0.12),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          category.toUpperCase(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppTheme.primaryGreen,
            fontSize: 8,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TIER 2 – MINIMAL  (h < 180 or w < 180)
// Category pill + title
// ─────────────────────────────────────────────────────────────────────────────
class _MinimalCard extends StatelessWidget {
  final String category;
  final String title;
  final bool hovered;
  final double cardH;
  const _MinimalCard({
    required this.category,
    required this.title,
    required this.hovered,
    required this.cardH,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _CategoryPill(category: category),
          const SizedBox(height: 8),
          Flexible(
            child: Text(
              title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TIER 3 – COMPACT  (h < 280 or w < 240)
// Category + title + arrow
// ─────────────────────────────────────────────────────────────────────────────
class _CompactCard extends StatelessWidget {
  final String category;
  final String title;
  final bool hovered;
  final double cardH;
  final double cardW;
  const _CompactCard({
    required this.category,
    required this.title,
    required this.hovered,
    required this.cardH,
    required this.cardW,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(cardW < 200 ? 12 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CategoryPill(category: category),
          const SizedBox(height: 10),
          Expanded(
            child: Text(
              title,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: cardW < 200 ? 13 : 15,
                fontWeight: FontWeight.w700,
                height: 1.25,
              ),
            ),
          ),
          // Only show arrow if there's space
          if (cardH > 200)
            _ReadArrow(hovered: hovered, compact: true),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TIER 4 / 5 – FULL CARD  (h ≥ 280 and w ≥ 240)
// Image area (tier 5 only) + category + title + description (tier 5) + footer
// ─────────────────────────────────────────────────────────────────────────────
class _FullCard extends StatelessWidget {
  final String category;
  final String title;
  final String? description;
  final bool hovered;
  final double cardH;
  final double cardW;
  final bool isMobile;

  const _FullCard({
    required this.category,
    required this.title,
    required this.description,
    required this.hovered,
    required this.cardH,
    required this.cardW,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    // Tier 5 gates
    final bool showImage       = cardH > 380;
    final bool showDescription = cardH > 320 && cardW > 260;
    final bool showFooter      = cardH > 280;

    final double pad      = cardW < 280 ? 14 : 20;
    final double titleSz  = cardW < 280 ? 14.0 : (isMobile ? 15.0 : 17.0);
    final double descSz   = 12.5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Image area ────────────────────────────────────────────────
        if (showImage)
          Expanded(
            flex: cardH > 480 ? 5 : 4,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF0D2016), Color(0xFF000000)],
                    ),
                  ),
                ),
                Center(
                  child: Icon(
                    Icons.auto_awesome_rounded,
                    color: AppTheme.primaryGreen.withOpacity(0.85),
                    size: cardH * 0.10,
                  ),
                ),
                // Gradient overlay at bottom of image
                Positioned(
                  bottom: 0, left: 0, right: 0,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          const Color(0xFF111111).withOpacity(0.95),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        // ── Divider ───────────────────────────────────────────────────
        if (showImage)
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryGreen.withOpacity(hovered ? 0.55 : 0.12),
                  Colors.transparent,
                ],
              ),
            ),
          ),

        // ── Text content ──────────────────────────────────────────────
        Padding(
          padding: EdgeInsets.all(pad),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _CategoryPill(category: category),
              const SizedBox(height: 7),

              // Title
              Text(
                title,
                maxLines: showDescription ? 2 : 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: titleSz,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                  letterSpacing: -0.2,
                ),
              ),

              // Description
              if (showDescription) ...[
                const SizedBox(height: 8),
                Text(
                  description ?? "Explore the new era of software engineering.",
                  maxLines: cardH > 460 ? 3 : 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.48),
                    fontSize: descSz,
                    height: 1.45,
                  ),
                ),
              ],

              // Footer
              if (showFooter) ...[
                const SizedBox(height: 12),
                _ReadArrow(hovered: hovered, compact: false),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SHARED SMALL WIDGETS
// ─────────────────────────────────────────────────────────────────────────────

class _CategoryPill extends StatelessWidget {
  final String category;
  const _CategoryPill({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen.withOpacity(0.10),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppTheme.primaryGreen.withOpacity(0.20)),
      ),
      child: Text(
        category.toUpperCase(),
        style: const TextStyle(
          color: AppTheme.primaryGreen,
          fontSize: 8.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.3,
        ),
      ),
    );
  }
}

class _ReadArrow extends StatelessWidget {
  final bool hovered;
  final bool compact;
  const _ReadArrow({required this.hovered, required this.compact});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          compact ? "View" : "Read article",
          style: TextStyle(
            color: AppTheme.primaryGreen,
            fontWeight: FontWeight.w600,
            fontSize: compact ? 11 : 12.5,
          ),
        ),
        const SizedBox(width: 4),
        AnimatedSlide(
          offset: hovered ? const Offset(0.25, 0) : Offset.zero,
          duration: const Duration(milliseconds: 250),
          child: Icon(
            Icons.arrow_forward_rounded,
            size: compact ? 13 : 14,
            color: AppTheme.primaryGreen,
          ),
        ),
      ],
    );
  }
}