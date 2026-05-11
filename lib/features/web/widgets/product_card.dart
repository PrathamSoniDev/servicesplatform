import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/presentation/seo/seo_widget.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';
import 'package:servicesplatform/models/service_model.dart';

class ProductCard extends StatefulWidget {
  final VoidCallback onTap;
  final ServiceModel service;

  const ProductCard({super.key, required this.onTap, required this.service});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardColor = isDark ? AppTheme.darkCard : AppTheme.cardLight;
    final borderColor = isDark ? AppTheme.borderColor : AppTheme.borderLight;
    final titleColor = isDark ? AppTheme.textPrimary : AppTheme.textBlack;
    final descColor = isDark ? AppTheme.textSecondary : AppTheme.textGrey;

    return GestureDetector(
      onTap: widget.onTap,
      child: Hero(
        tag: DateTime.now().millisecondsSinceEpoch,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) {
            if (!isMobile) setState(() => _hovered = true);
          },
          onExit: (_) {
            if (!isMobile) setState(() => _hovered = false);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            clipBehavior: Clip.antiAlias,
            transform:
                Matrix4.identity()
                  ..translate(0.0, _hovered && !isMobile ? -4.0 : 0.0),
            transformAlignment: Alignment.center,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color:
                    _hovered
                        ? AppTheme.primaryGreen.withValues(alpha: .50)
                        : borderColor,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.09),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
                if (_hovered && !isMobile)
                  BoxShadow(
                    color: AppTheme.primaryGreen.withValues(alpha: .12),
                    blurRadius: 30,
                    spreadRadius: 2,
                    offset: const Offset(0, 8),
                  ),
              ],
            ),
            // ── All layout decisions come from LayoutBuilder ───────────────
            child: LayoutBuilder(
              builder: (context, box) {
                final w = box.maxWidth;
                final h = box.maxHeight;

                // ── TIER 1: MICRO – h<90 or w<110 ─────────────────────────
                // Just the icon badge
                if (h < 90 || w < 110) {
                  return _MicroTile(isDark: isDark);
                }

                // ── TIER 2: MINIMAL – h<150 or w<160 ──────────────────────
                // Icon + Title
                if (h < 150 || w < 160) {
                  return _MinimalTile(
                    text: widget.service.name,
                    isDark: isDark,
                    titleColor: titleColor,
                    cardW: w,
                    cardH: h,
                  );
                }

                // ── TIER 3: COMPACT – h<240 or w<220 ──────────────────────
                // Icon + Badge + Title + CTA arrow
                if (h < 240 || w < 220) {
                  return _CompactTile(
                    title: widget.service.name,
                    desc: widget.service.description,
                    isDark: isDark,
                    hovered: _hovered,
                    isMobile: isMobile,
                    titleColor: titleColor,
                    cardW: w,
                    cardH: h,
                  );
                }

                // ── TIER 4: STANDARD – h<360 or w<280 ─────────────────────
                // Icon + Badge + Title + Description + CTA
                if (h < 360 || w < 280) {
                  return _StandardTile(
                    title: widget.service.name,
                    desc: widget.service.description,
                    isDark: isDark,
                    hovered: _hovered,
                    isMobile: isMobile,
                    titleColor: titleColor,
                    descColor: descColor,
                    cardW: w,
                    cardH: h,
                  );
                }

                // ── TIER 5: FULL – all elements ────────────────────────────
                return _FullTile(
                  service: widget.service,

                  hovered: _hovered,
                  isMobile: isMobile,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TIER 1 – MICRO   h<90 or w<110
// ─────────────────────────────────────────────────────────────────────────────
class _MicroTile extends StatelessWidget {
  final bool isDark;

  const _MicroTile({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppTheme.primaryGreen.withValues(alpha: .10),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.business_center_rounded,
          color: AppTheme.primaryGreen,
          size: 20,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TIER 2 – MINIMAL   h<150 or w<160
// ─────────────────────────────────────────────────────────────────────────────
class _MinimalTile extends StatelessWidget {
  final String text;
  final bool isDark;
  final Color titleColor;
  final double cardW;
  final double cardH;

  const _MinimalTile({
    required this.text,
    required this.isDark,
    required this.titleColor,
    required this.cardW,
    required this.cardH,
  });

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
              color: AppTheme.primaryGreen.withValues(alpha: .10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.business_center_rounded,
              color: AppTheme.primaryGreen,
              size: 16,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: titleColor,
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

// ─────────────────────────────────────────────────────────────────────────────
// TIER 3 – COMPACT   h<240 or w<220
// ─────────────────────────────────────────────────────────────────────────────
class _CompactTile extends StatelessWidget {
  final bool isDark;
  final bool hovered;
  final bool isMobile;
  final Color titleColor;
  final double cardW;
  final double cardH;
  final String title;
  final String desc;

  const _CompactTile({
    required this.isDark,
    required this.hovered,
    required this.isMobile,
    required this.titleColor,
    required this.cardW,
    required this.cardH,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    final double pad = cardW < 180 ? 12 : 16;
    return Padding(
      padding: EdgeInsets.all(pad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon row + badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _IconBox(size: 18, padding: 9),
              _BadgePill(text: title, fontSize: 8),
            ],
          ),
          const SizedBox(height: 10),
          // Title
          SeoText(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: titleColor,
              fontSize: cardW < 180 ? 13 : 15,
              fontWeight: FontWeight.w800,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          SeoText(
            desc,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: titleColor,
              fontSize: cardW < 180 ? 13 : 15,
              fontWeight: FontWeight.w800,
              height: 1.2,
            ),
          ),
          if (cardH > 190) ...[
            const SizedBox(height: 10),
            _CtaArrow(hovered: hovered, titleColor: titleColor, fontSize: 12),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TIER 4 – STANDARD   h<360 or w<280
// ─────────────────────────────────────────────────────────────────────────────
class _StandardTile extends StatelessWidget {
  final bool isDark;
  final bool hovered;
  final bool isMobile;
  final Color titleColor;
  final Color descColor;
  final double cardW;
  final double cardH;
  final String title;
  final String desc;

  const _StandardTile({
    required this.isDark,
    required this.hovered,
    required this.isMobile,
    required this.titleColor,
    required this.descColor,
    required this.cardW,
    required this.cardH,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    final double pad = cardW < 240 ? 14 : 18;
    return Padding(
      padding: EdgeInsets.all(pad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _IconBox(size: 20, padding: 10),
              _BadgePill(text: '', fontSize: 9),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: titleColor,
              fontSize: 16,
              fontWeight: FontWeight.w800,
              height: 1.2,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            desc,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: descColor, height: 1.5, fontSize: 12.5),
          ),
          if (cardH > 260) ...[
            const SizedBox(height: 14),
            _CtaArrow(hovered: hovered, titleColor: titleColor, fontSize: 13),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TIER 5 – FULL   h≥360 and w≥280
// ─────────────────────────────────────────────────────────────────────────────
class _FullTile extends StatelessWidget {
  final ServiceModel service;
  final bool hovered;
  final bool isMobile;

  const _FullTile({
    required this.service,
    required this.hovered,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      padding: EdgeInsets.all(isMobile ? 22 : 28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF101827),
            hovered
                ? AppTheme.primaryGreen.withValues(alpha: .18)
                : const Color(0xFF111827),
          ],
        ),
        border: Border.all(
          color:
              hovered
                  ? AppTheme.primaryGreen.withValues(alpha: .35)
                  : Colors.white.withValues(alpha: .05),
        ),
        boxShadow: [
          BoxShadow(
            color:
                hovered
                    ? AppTheme.primaryGreen.withValues(alpha: .15)
                    : Colors.black.withValues(alpha: .15),
            blurRadius: hovered ? 40 : 18,
            spreadRadius: hovered ? 2 : 0,
            offset: const Offset(0, 20),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TOP ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                width: hovered ? 78 : 70,
                height: hovered ? 78 : 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryGreen,
                      AppTheme.primaryGreen.withValues(alpha: .55),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryGreen.withValues(alpha: .25),
                      blurRadius: 25,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  color: Colors.black,
                  size: 34,
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white.withValues(alpha: .05),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: .08),
                  ),
                ),
                child: SeoText(
                  "PREMIUM",
                  style: TextStyle(
                    color: AppTheme.primaryGreen,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.4,
                  ),
                ),
              ),
            ],
          ),

          const Spacer(),

          /// TITLE
          SeoText(
            service.name,
            maxLines: 2,
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 24 : 30,
              fontWeight: FontWeight.w900,
              height: 1.05,
              letterSpacing: -1,
            ),
          ),

          const SizedBox(height: 18),

          /// DESCRIPTION
          SeoText(
            service.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white.withValues(alpha: .70),
              fontSize: isMobile ? 13 : 15,
              height: 1.8,
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(height: 24),

          /// TECH STACK
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _buildTech("Flutter"),
              _buildTech("Firebase"),
              _buildTech("API"),
            ],
          ),

          const SizedBox(height: 30),

          /// CTA
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color:
                  hovered
                      ? AppTheme.primaryGreen
                      : Colors.white.withValues(alpha: .06),
            ),
            child: Row(
              children: [
                Expanded(
                  child: SeoText(
                    "Explore Solution",
                    style: TextStyle(
                      color: hovered ? Colors.black : Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                ),

                AnimatedSlide(
                  duration: const Duration(milliseconds: 250),
                  offset: hovered ? const Offset(.2, 0) : Offset.zero,
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    color: hovered ? Colors.black : AppTheme.primaryGreen,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTech(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.white.withValues(alpha: .05),
        border: Border.all(color: Colors.white.withValues(alpha: .06)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SHARED SMALL WIDGETS
// ─────────────────────────────────────────────────────────────────────────────

class _IconBox extends StatelessWidget {
  final double size;
  final double padding;

  const _IconBox({required this.size, required this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen.withValues(alpha: .10),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.primaryGreen.withValues(alpha: .22),
          width: 1,
        ),
      ),
      child: Icon(
        Icons.business_center_rounded,
        color: AppTheme.primaryGreen,
        size: size,
      ),
    );
  }
}

class _BadgePill extends StatelessWidget {
  final String text;
  final double fontSize;

  const _BadgePill({required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primaryGreen.withValues(alpha: .22)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: AppTheme.primaryGreen,
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _CtaArrow extends StatelessWidget {
  final bool hovered;
  final Color titleColor;
  final double fontSize;

  const _CtaArrow({
    required this.hovered,
    required this.titleColor,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "View Details",
          style: TextStyle(
            color: titleColor,
            fontWeight: FontWeight.w700,
            fontSize: fontSize,
          ),
        ),
        const SizedBox(width: 5),
        AnimatedSlide(
          offset: hovered ? const Offset(0.30, 0) : Offset.zero,
          duration: const Duration(milliseconds: 250),
          child: Icon(
            Icons.arrow_forward_rounded,
            size: fontSize + 2,
            color: AppTheme.primaryGreen,
          ),
        ),
      ],
    );
  }
}

class _TagChip extends StatelessWidget {
  final String label;
  final bool isDark;

  const _TagChip({required this.label, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color:
            isDark
                ? Colors.white.withValues(alpha: .05)
                : Colors.black.withValues(alpha: .04),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color:
              isDark
                  ? Colors.white.withValues(alpha: .10)
                  : Colors.black.withValues(alpha: .08),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color:
              isDark
                  ? Colors.white.withValues(alpha: .55)
                  : Colors.black.withValues(alpha: .45),
          fontSize: 10.5,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
