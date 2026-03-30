import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';

class AboutUsGlassCard extends StatelessWidget {
  final bool isMobile;
  final AnimationController controller;

  const AboutUsGlassCard({
    super.key,
    required this.isMobile,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final size   = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final double cardWidth = size.width < 400
        ? size.width * 0.88
        : size.width < 900
            ? size.width * 0.42
            : 360;

    final Animation<Offset> slide = Tween<Offset>(
      begin: const Offset(0.18, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.45, 1.0, curve: Curves.easeOutCubic),
    ));

    final Animation<double> fade = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.45, 0.90),
    );

    return FadeTransition(
      opacity: fade,
      child: SlideTransition(
        position: slide,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: cardWidth, minWidth: 200),
            child: LayoutBuilder(
              builder: (context, box) {
                final w = box.maxWidth;

                final cardColor   = isDark ? AppTheme.darkCard    : Colors.white;
                final borderColor = isDark ? AppTheme.borderColor : AppTheme.primaryGreen.withOpacity(0.10);
                final titleColor  = isDark ? AppTheme.textPrimary  : AppTheme.textBlack;
                final subColor    = isDark ? AppTheme.textSecondary : AppTheme.textGrey;

                // ── TIER 1: MICRO – w<220 ────────────────────────────────
                if (w < 220) {
                  return _cardShell(
                    cardColor: cardColor,
                    borderColor: borderColor,
                    padding: 12,
                    child: _buildHeader(titleColor, subColor, compact: true),
                  );
                }

                // ── TIER 2: MINIMAL – w<270 ──────────────────────────────
                if (w < 270) {
                  return _cardShell(
                    cardColor: cardColor,
                    borderColor: borderColor,
                    padding: 14,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(titleColor, subColor, compact: false),
                        const SizedBox(height: 10),
                        _buildStatusBadge(),
                      ],
                    ),
                  );
                }

                // ── TIER 3: COMPACT – w<320 ──────────────────────────────
                if (w < 320) {
                  return _cardShell(
                    cardColor: cardColor,
                    borderColor: borderColor,
                    padding: 16,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(titleColor, subColor, compact: false),
                        _divider(isDark),
                        _buildStatusBadge(),
                        const SizedBox(height: 14),
                        _buildSectionLabel("Certifications", subColor),
                        const SizedBox(height: 8),
                        _MiniProgressCard(title: "ML Engineer",   progress: 0.80, isDark: isDark),
                        const SizedBox(height: 8),
                        _MiniProgressCard(title: "Data Scientist", progress: 0.45, isDark: isDark),
                      ],
                    ),
                  );
                }

                // ── TIER 4: FULL – w>=320 ─────────────────────────────────
                return _cardShell(
                  cardColor: cardColor,
                  borderColor: borderColor,
                  padding: w < 400 ? 18 : 22,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(titleColor, subColor, compact: false),
                      _divider(isDark),
                      _buildStatusBadge(),
                      const SizedBox(height: 18),
                      _buildSectionLabel("Certifications", subColor),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _MiniProgressCard(title: "ML Engineer",   progress: 0.80, isDark: isDark),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _MiniProgressCard(title: "Data Scientist", progress: 0.45, isDark: isDark),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      _buildSectionLabel("Skills & Badges", subColor),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: const [
                          _HexBadge(label: "PyTorch",    icon: Icons.bolt_rounded),
                          _HexBadge(label: "Python",     icon: Icons.terminal_rounded),
                          _HexBadge(label: "TensorFlow", icon: Icons.memory_rounded),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardShell({
    required Color cardColor,
    required Color borderColor,
    required double padding,
    required Widget child,
  }) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
          BoxShadow(
            color: AppTheme.primaryGreen.withOpacity(0.05),
            blurRadius: 60,
            offset: const Offset(0, 24),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildHeader(Color titleColor, Color subTextColor, {required bool compact}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppTheme.primaryGreen, width: 2),
          ),
          child: const CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(
              "https://randomuser.me/api/portraits/women/44.jpg",
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                compact ? "Ada L." : "Ada Lovelace",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  letterSpacing: -0.2,
                  color: titleColor,
                ),
              ),
              if (!compact) ...[
                const SizedBox(height: 1),
                Text(
                  "ML Engineer · AI Researcher",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 11, color: subTextColor),
                ),
              ],
            ],
          ),
        ),
        if (!compact)
          Icon(Icons.more_horiz_rounded, color: subTextColor, size: 18),
      ],
    );
  }

  Widget _buildStatusBadge() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color: AppTheme.primaryGreen,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryGreen.withOpacity(0.50),
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            "Available for opportunities",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryGreen,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionLabel(String text, Color color) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        color: color,
        fontSize: 9.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _divider(bool isDark) {
    return Divider(
      color: isDark
          ? Colors.white.withOpacity(0.07)
          : Colors.black.withOpacity(0.06),
      height: 22,
    );
  }
}

// ─── MINI PROGRESS CARD ───────────────────────────────────────────────────────
class _MiniProgressCard extends StatelessWidget {
  final String title;
  final double progress;
  final bool isDark;
  const _MiniProgressCard({required this.title, required this.progress, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final pct = (progress * 100).toInt();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceGrey : AppTheme.primaryGreen.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primaryGreen.withOpacity(0.10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isDark ? AppTheme.textSecondary : AppTheme.textGrey,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                "$pct%",
                style: TextStyle(
                  color: AppTheme.primaryGreen,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.black.withOpacity(0.06),
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
              minHeight: 4,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── HEX BADGE ────────────────────────────────────────────────────────────────
class _HexBadge extends StatefulWidget {
  final String label;
  final IconData icon;
  const _HexBadge({required this.label, required this.icon});

  @override
  State<_HexBadge> createState() => _HexBadgeState();
}

class _HexBadgeState extends State<_HexBadge> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 44,
            height: 50,
            decoration: ShapeDecoration(
              color: _hovered
                  ? AppTheme.primaryGreen.withOpacity(0.14)
                  : AppTheme.primaryGreen.withOpacity(0.07),
              shape: const _HexagonBorder(),
            ),
            child: Center(
              child: Icon(widget.icon, color: AppTheme.primaryGreen, size: 18),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            widget.label,
            style: TextStyle(
              color: AppTheme.textGrey,
              fontSize: 9.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── HEX SHAPE ────────────────────────────────────────────────────────────────
class _HexagonBorder extends ShapeBorder {
  const _HexagonBorder();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) => Path()
    ..moveTo(rect.width * 0.5, 0)
    ..lineTo(rect.width, rect.height * 0.25)
    ..lineTo(rect.width, rect.height * 0.75)
    ..lineTo(rect.width * 0.5, rect.height)
    ..lineTo(0, rect.height * 0.75)
    ..lineTo(0, rect.height * 0.25)
    ..close();

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getOuterPath(rect);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}