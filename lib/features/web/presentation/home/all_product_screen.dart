import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/features/web/presentation/seo/seo_widget.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({super.key});

  List<Map<String, dynamic>> get products => [
        {
          'title': 'Developer Services',
          'type': 'developer',
          'desc': 'Web, App & Backend Development',
          'tags': ['Flutter', 'APIs', 'Backend'],
          'icon': Icons.terminal_rounded,
          'badge': 'DEV',
        },
        {
          'title': 'Design Services',
          'type': 'design',
          'desc': 'UI/UX, Branding & Graphics',
          'tags': ['Figma', 'Branding', 'Motion'],
          'icon': Icons.palette_rounded,
          'badge': 'UX',
        },
        {
          'title': 'Marketing Services',
          'type': 'marketing',
          'desc': 'SEO, Ads & Growth Strategy',
          'tags': ['SEO', 'Ads', 'Growth'],
          'icon': Icons.trending_up_rounded,
          'badge': 'MKT',
        },
        {
          'title': 'Consulting',
          'type': 'consulting',
          'desc': 'Business & Tech Consulting',
          'tags': ['Strategy', 'Tech', 'Audit'],
          'icon': Icons.lightbulb_outline_rounded,
          'badge': 'CON',
        },
        {
          'title': 'Cloud & DevOps',
          'type': 'cloud',
          'desc': 'Infrastructure, CI/CD & Scaling',
          'tags': ['AWS', 'Docker', 'CI/CD'],
          'icon': Icons.cloud_queue_rounded,
          'badge': 'OPS',
        },
        {
          'title': 'Data & AI',
          'type': 'ai',
          'desc': 'ML Models, Analytics & Pipelines',
          'tags': ['ML', 'Analytics', 'LLMs'],
          'icon': Icons.auto_awesome_rounded,
          'badge': 'AI',
        },
      ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = Responsive.isMobile(context);

    int crossAxisCount = 2;
    if (width > 1200) {
      crossAxisCount = 3;
    } else if (width > 700) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 1;
    }

    return SeoWrapper(
      child: Scaffold(
        backgroundColor: AppTheme.darkBackground,

        /// ── APP BAR ──────────────────────────────────────────────────────
        appBar: AppBar(
          backgroundColor: AppTheme.darkBackground,
          elevation: 0,
          centerTitle: false,
          leadingWidth: 80,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: IconButton(
                      onPressed: () async {
                        final bool didPop =
                            await Navigator.of(context).maybePop();
                        if (!didPop && context.mounted) {
                          context.go('/');
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          title: const SeoHeader(
            child: SeoHeading("All Products"),
          ),
        ),

        /// ── BODY ─────────────────────────────────────────────────────────
        body: SeoBody(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: Responsive.maxContentWidth(context),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: Responsive.screenPadding(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),

                      /// ── HERO HEADER ─────────────────────────────────────
                      _HeroHeader(isMobile: isMobile),

                      const SizedBox(height: 40),

                      /// ── GRID ────────────────────────────────────────────
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: products.length,
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: isMobile ? 1.05 : 0.95,
                        ),
                        itemBuilder: (context, index) {
                          final p = products[index];
                          return _ProductCard(
                            title: p['title'] as String,
                            desc: p['desc'] as String,
                            tags: p['tags'] as List<String>,
                            icon: p['icon'] as IconData,
                            badge: p['badge'] as String,
                            onTap: () {
                              context.push('/product/detail/${p['type']}');
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// HERO HEADER
// ─────────────────────────────────────────────────────────────────────────────
class _HeroHeader extends StatelessWidget {
  final bool isMobile;
  const _HeroHeader({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label pill
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: AppTheme.primaryGreen.withOpacity(0.10),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
                color: AppTheme.primaryGreen.withOpacity(0.22)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "SERVICES CATALOGUE",
                style: TextStyle(
                  color: AppTheme.primaryGreen,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.8,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Headline
        Text(
          "Everything you\nneed to ship.",
          style: TextStyle(
            color: Colors.white,
            fontSize: isMobile ? 36 : 54,
            fontWeight: FontWeight.w900,
            height: 1.05,
            letterSpacing: -1.5,
          ),
        ),

        const SizedBox(height: 16),

        // Subtext
        Text(
          "Explore our full suite of expert-led services built\nfor modern teams and ambitious products.",
          style: TextStyle(
            color: Colors.white.withOpacity(0.45),
            fontSize: isMobile ? 14 : 16,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PRODUCT CARD  (mirrors BlogCard's dark aesthetic + LayoutBuilder tiers)
// ─────────────────────────────────────────────────────────────────────────────
class _ProductCard extends StatefulWidget {
  final String title;
  final String desc;
  final List<String> tags;
  final IconData icon;
  final String badge;
  final VoidCallback onTap;

  const _ProductCard({
    required this.title,
    required this.desc,
    required this.tags,
    required this.icon,
    required this.badge,
    required this.onTap,
  });

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        if (!isMobile) setState(() => _hovered = true);
      },
      onExit: (_) {
        if (!isMobile) setState(() => _hovered = false);
      },
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
          child: LayoutBuilder(
            builder: (context, box) {
              final w = box.maxWidth;
              final h = box.maxHeight;

              // Tier 1 – micro
              if (h < 110 || w < 120) {
                return _ProdMicro(icon: widget.icon);
              }
              // Tier 2 – minimal
              if (h < 180 || w < 180) {
                return _ProdMinimal(
                  icon: widget.icon,
                  title: widget.title,
                  badge: widget.badge,
                );
              }
              // Tier 3 – compact
              if (h < 280 || w < 240) {
                return _ProdCompact(
                  icon: widget.icon,
                  title: widget.title,
                  badge: widget.badge,
                  hovered: _hovered,
                  cardH: h,
                  cardW: w,
                );
              }
              // Tier 4/5 – full
              return _ProdFull(
                icon: widget.icon,
                title: widget.title,
                desc: widget.desc,
                tags: widget.tags,
                badge: widget.badge,
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

// ─── TIER 1 – MICRO ───────────────────────────────────────────────────────────
class _ProdMicro extends StatelessWidget {
  final IconData icon;
  const _ProdMicro({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppTheme.primaryGreen.withOpacity(0.10),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: AppTheme.primaryGreen, size: 20),
      ),
    );
  }
}

// ─── TIER 2 – MINIMAL ─────────────────────────────────────────────────────────
class _ProdMinimal extends StatelessWidget {
  final IconData icon;
  final String title;
  final String badge;
  const _ProdMinimal(
      {required this.icon, required this.title, required this.badge});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen.withOpacity(0.10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppTheme.primaryGreen, size: 16),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w800,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── TIER 3 – COMPACT ─────────────────────────────────────────────────────────
class _ProdCompact extends StatelessWidget {
  final IconData icon;
  final String title;
  final String badge;
  final bool hovered;
  final double cardH;
  final double cardW;
  const _ProdCompact({
    required this.icon,
    required this.title,
    required this.badge,
    required this.hovered,
    required this.cardH,
    required this.cardW,
  });

  @override
  Widget build(BuildContext context) {
    final double pad = cardW < 200 ? 12 : 16;
    return Padding(
      padding: EdgeInsets.all(pad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _IconBox(icon: icon),
              _BadgePill(badge: badge),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Text(
              title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: cardW < 200 ? 13 : 15,
                fontWeight: FontWeight.w700,
                height: 1.25,
              ),
            ),
          ),
          if (cardH > 200) _ReadArrow(hovered: hovered, compact: true),
        ],
      ),
    );
  }
}

// ─── TIER 4/5 – FULL ──────────────────────────────────────────────────────────
class _ProdFull extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  final List<String> tags;
  final String badge;
  final bool hovered;
  final double cardH;
  final double cardW;
  final bool isMobile;

  const _ProdFull({
    required this.icon,
    required this.title,
    required this.desc,
    required this.tags,
    required this.badge,
    required this.hovered,
    required this.cardH,
    required this.cardW,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final bool showImage = cardH > 380;
    final bool showDesc = cardH > 280 && cardW > 220;
    final bool showTags = cardH > 320;
    final double pad = cardW < 280 ? 14 : 20;
    final double titleSz = cardW < 280 ? 14.0 : (isMobile ? 15.0 : 17.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// ── Image / gradient area ────────────────────────────────────
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
                    icon,
                    color: AppTheme.primaryGreen.withOpacity(0.85),
                    size: cardH * 0.10,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
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

        /// ── Divider ─────────────────────────────────────────────────
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

        /// ── Text content ─────────────────────────────────────────────
        Padding(
          padding: EdgeInsets.all(pad),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon + badge (when no image area)
              if (!showImage) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _IconBox(icon: icon),
                    _BadgePill(badge: badge),
                  ],
                ),
                const SizedBox(height: 12),
              ] else ...[
                _BadgePill(badge: badge),
                const SizedBox(height: 8),
              ],

              // Title
              Text(
                title,
                maxLines: 2,
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
              if (showDesc) ...[
                const SizedBox(height: 7),
                Text(
                  desc,
                  maxLines: cardH > 460 ? 3 : 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.45),
                    fontSize: 12.5,
                    height: 1.5,
                  ),
                ),
              ],

              // Tags
              if (showTags) ...[
                const SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: tags
                      .map((t) => _TagChip(label: t))
                      .toList(),
                ),
              ],

              const SizedBox(height: 12),

              // CTA
              _ReadArrow(hovered: hovered, compact: false),
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

class _IconBox extends StatelessWidget {
  final IconData icon;
  const _IconBox({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen.withOpacity(0.10),
        borderRadius: BorderRadius.circular(12),
        border:
            Border.all(color: AppTheme.primaryGreen.withOpacity(0.22), width: 1),
      ),
      child: Icon(icon, color: AppTheme.primaryGreen, size: 20),
    );
  }
}

class _BadgePill extends StatelessWidget {
  final String badge;
  const _BadgePill({required this.badge});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primaryGreen.withOpacity(0.22)),
      ),
      child: Text(
        badge,
        style: TextStyle(
          color: AppTheme.primaryGreen,
          fontSize: 9.5,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String label;
  const _TagChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white.withOpacity(0.10)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white.withOpacity(0.50),
          fontSize: 10.5,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.2,
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
          compact ? "View" : "View details",
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