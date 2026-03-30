import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';

class ProductCard extends StatefulWidget {
  final bool isDeveloper;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.isDeveloper,
    required this.onTap,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDark   = Theme.of(context).brightness == Brightness.dark;

    final cardColor   = isDark ? AppTheme.darkCard    : AppTheme.cardLight;
    final borderColor = isDark ? AppTheme.borderColor : AppTheme.borderLight;
    final titleColor  = isDark ? AppTheme.textPrimary : AppTheme.textBlack;
    final descColor   = isDark ? AppTheme.textSecondary : AppTheme.textGrey;

    return GestureDetector(
      onTap: widget.onTap,
      child: Hero(
        tag: widget.isDeveloper ? "dev_prod" : "biz_prod",
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) { if (!isMobile) setState(() => _hovered = true); },
          onExit:  (_) { if (!isMobile) setState(() => _hovered = false); },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            clipBehavior: Clip.antiAlias,
            transform: Matrix4.identity()
              ..translate(0.0, _hovered && !isMobile ? -4.0 : 0.0),
            transformAlignment: Alignment.center,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _hovered
                    ? AppTheme.primaryGreen.withOpacity(0.50)
                    : borderColor,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.35 : 0.09),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
                if (_hovered && !isMobile)
                  BoxShadow(
                    color: AppTheme.primaryGreen.withOpacity(0.12),
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
                  return _MicroTile(
                    isDev: widget.isDeveloper,
                    isDark: isDark,
                  );
                }

                // ── TIER 2: MINIMAL – h<150 or w<160 ──────────────────────
                // Icon + Title
                if (h < 150 || w < 160) {
                  return _MinimalTile(
                    isDev: widget.isDeveloper,
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
                    isDev: widget.isDeveloper,
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
                    isDev: widget.isDeveloper,
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
                  isDev: widget.isDeveloper,
                  isDark: isDark,
                  hovered: _hovered,
                  isMobile: isMobile,
                  titleColor: titleColor,
                  descColor: descColor,
                  cardW: w,
                  cardH: h,
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
  final bool isDev;
  final bool isDark;
  const _MicroTile({required this.isDev, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppTheme.primaryGreen.withOpacity(0.10),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          isDev ? Icons.terminal_rounded : Icons.business_center_rounded,
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
  final bool isDev;
  final bool isDark;
  final Color titleColor;
  final double cardW;
  final double cardH;
  const _MinimalTile({
    required this.isDev,
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
              color: AppTheme.primaryGreen.withOpacity(0.10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isDev ? Icons.terminal_rounded : Icons.business_center_rounded,
              color: AppTheme.primaryGreen,
              size: 16,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              isDev ? "Developer" : "Business",
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
  final bool isDev;
  final bool isDark;
  final bool hovered;
  final bool isMobile;
  final Color titleColor;
  final double cardW;
  final double cardH;
  const _CompactTile({
    required this.isDev,
    required this.isDark,
    required this.hovered,
    required this.isMobile,
    required this.titleColor,
    required this.cardW,
    required this.cardH,
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
              _IconBox(isDev: isDev, size: 18, padding: 9),
              _BadgePill(isDev: isDev, fontSize: 8),
            ],
          ),
          const SizedBox(height: 10),
          // Title
          Text(
            isDev ? "Developer Platform" : "Business Platform",
            maxLines: 2,
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
  final bool isDev;
  final bool isDark;
  final bool hovered;
  final bool isMobile;
  final Color titleColor;
  final Color descColor;
  final double cardW;
  final double cardH;
  const _StandardTile({
    required this.isDev,
    required this.isDark,
    required this.hovered,
    required this.isMobile,
    required this.titleColor,
    required this.descColor,
    required this.cardW,
    required this.cardH,
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
              _IconBox(isDev: isDev, size: 20, padding: 10),
              _BadgePill(isDev: isDev, fontSize: 9),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            isDev ? "Developer Platform" : "Business Platform",
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
            isDev
                ? "Powerful tools to help engineers build, ship and scale smarter."
                : "Everything your team needs to hire better and grow faster.",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: descColor,
              height: 1.5,
              fontSize: 12.5,
            ),
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
  final bool isDev;
  final bool isDark;
  final bool hovered;
  final bool isMobile;
  final Color titleColor;
  final Color descColor;
  final double cardW;
  final double cardH;
  const _FullTile({
    required this.isDev,
    required this.isDark,
    required this.hovered,
    required this.isMobile,
    required this.titleColor,
    required this.descColor,
    required this.cardW,
    required this.cardH,
  });

  @override
  Widget build(BuildContext context) {
    final double pad       = isMobile ? 18 : 24;
    final double iconSize  = isMobile ? 22 : 26;
    final double iconPad   = isMobile ? 10 : 13;
    final double titleSize = isMobile ? 18 : 21;
    final double descSize  = isMobile ? 12.5 : 13.5;

    final tags = isDev
        ? ["API Access", "CLI Tools", "SDKs"]
        : ["Analytics", "Hiring", "Reports"];

    return Padding(
      padding: EdgeInsets.all(pad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Icon + Badge ─────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: EdgeInsets.all(iconPad),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withOpacity(hovered ? 0.15 : 0.09),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppTheme.primaryGreen.withOpacity(hovered ? 0.40 : 0.18),
                    width: 1,
                  ),
                ),
                child: Icon(
                  isDev ? Icons.terminal_rounded : Icons.business_center_rounded,
                  color: AppTheme.primaryGreen,
                  size: iconSize,
                ),
              ),
              _BadgePill(isDev: isDev, fontSize: 9.5),
            ],
          ),

          SizedBox(height: isMobile ? 14 : 20),

          // ── Title ───────────────────────────────────────────────────
          Text(
            isDev ? "Developer Platform" : "Business Platform",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: titleColor,
              fontSize: titleSize,
              fontWeight: FontWeight.w800,
              height: 1.2,
              letterSpacing: -0.3,
            ),
          ),

          const SizedBox(height: 8),

          // ── Description ─────────────────────────────────────────────
          Text(
            isDev
                ? "Powerful tools designed to help engineers build, ship and scale smarter."
                : "Everything your team needs to hire better and grow faster.",
            maxLines: isMobile ? 2 : 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: descColor,
              height: 1.55,
              fontSize: descSize,
            ),
          ),

          SizedBox(height: isMobile ? 14 : 20),

          // ── Feature tags (Wrap → never overflows) ───────────────────
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: tags.map((t) => _TagChip(label: t, isDark: isDark)).toList(),
          ),

          SizedBox(height: isMobile ? 14 : 18),

          // ── CTA ──────────────────────────────────────────────────────
          _CtaArrow(
            hovered: hovered,
            titleColor: titleColor,
            fontSize: isMobile ? 12 : 14,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SHARED SMALL WIDGETS
// ─────────────────────────────────────────────────────────────────────────────

class _IconBox extends StatelessWidget {
  final bool isDev;
  final double size;
  final double padding;
  const _IconBox({required this.isDev, required this.size, required this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen.withOpacity(0.10),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primaryGreen.withOpacity(0.22), width: 1),
      ),
      child: Icon(
        isDev ? Icons.terminal_rounded : Icons.business_center_rounded,
        color: AppTheme.primaryGreen,
        size: size,
      ),
    );
  }
}

class _BadgePill extends StatelessWidget {
  final bool isDev;
  final double fontSize;
  const _BadgePill({required this.isDev, required this.fontSize});

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
        isDev ? "DEV" : "BIZ",
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
  const _CtaArrow({required this.hovered, required this.titleColor, required this.fontSize});

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
        color: isDark
            ? Colors.white.withOpacity(0.05)
            : Colors.black.withOpacity(0.04),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.10)
              : Colors.black.withOpacity(0.08),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isDark
              ? Colors.white.withOpacity(0.55)
              : Colors.black.withOpacity(0.45),
          fontSize: 10.5,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}