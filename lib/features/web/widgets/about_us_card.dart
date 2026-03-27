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
    final size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardColor = isDark ? AppTheme.darkCard : AppTheme.cardLight;
    final borderColor = isDark ? AppTheme.borderColor : AppTheme.borderLight;
    final titleColor = isDark ? AppTheme.textPrimary : AppTheme.textBlack;
    final subTextColor = isDark ? AppTheme.textSecondary : AppTheme.textGrey;

    /// 🔥 DYNAMIC WIDTH (NO FIXED WIDTH)
    double cardWidth;
    if (size.width < 400) {
      cardWidth = size.width * 0.9;
    } else if (size.width < 900) {
      cardWidth = 320;
    } else {
      cardWidth = 360;
    }

    final Animation<Offset> slide = Tween<Offset>(
      begin: const Offset(0.2, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.5, 1.0, curve: Curves.easeOutCubic),
    ));

    return FadeTransition(
      opacity: CurvedAnimation(
        parent: controller,
        curve: const Interval(0.5, 0.9),
      ),
      child: SlideTransition(
        position: slide,
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: cardWidth,
              minWidth: 260,
            ),
            padding: EdgeInsets.all(size.width < 400 ? 16 : 24),

            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: borderColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.4 : 0.10),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.25 : 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(titleColor, subTextColor),
                const SizedBox(height: 20),

                _buildSectionTitle("Certifications", titleColor),

                /// 🔥 RESPONSIVE ROW (NO OVERFLOW)
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 280) {
                      return Column(
                        children: [
                          _MiniProgressCard(
                            title: "ML Engineer",
                            progress: 0.8,
                            isDark: isDark,
                          ),
                          const SizedBox(height: 10),
                          _MiniProgressCard(
                            title: "Data Scientist",
                            progress: 0.4,
                            isDark: isDark,
                          ),
                        ],
                      );
                    }

                    return Row(
                      children: [
                        Expanded(
                          child: _MiniProgressCard(
                            title: "ML Engineer",
                            progress: 0.8,
                            isDark: isDark,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _MiniProgressCard(
                            title: "Data Scientist",
                            progress: 0.4,
                            isDark: isDark,
                          ),
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 20),

                _buildSectionTitle("Badges", titleColor),

                /// 🔥 WRAP (AUTO BREAK LINE)
                Wrap(
                  spacing: 16,
                  runSpacing: 10,
                  children: const [
                    _HexBadge(label: "PyTorch", icon: Icons.bolt),
                    _HexBadge(label: "Python", icon: Icons.terminal),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Color titleColor, Color subTextColor) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundImage:
              NetworkImage("https://randomuser.me/api/portraits/women/44.jpg"),
        ),
        const SizedBox(width: 10),

        /// 🔥 TEXT SAFE (NO OVERFLOW)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ada",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: titleColor,
                ),
              ),
              Text(
                "ML Engineer",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: subTextColor,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildSectionTitle(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

/// MINI CARD
class _MiniProgressCard extends StatelessWidget {
  final String title;
  final double progress;
  final bool isDark;

  const _MiniProgressCard({
    required this.title,
    required this.progress,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceGrey : AppTheme.bgSoftGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.black12,
            color: AppTheme.primaryGreen,
            minHeight: 3,
          ),
        ],
      ),
    );
  }
}

/// BADGE
class _HexBadge extends StatelessWidget {
  final String label;
  final IconData icon;

  const _HexBadge({
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 45,
          decoration: ShapeDecoration(
            color: AppTheme.bgSoftGrey,
            shape: const _HexagonBorder(),
          ),
          child: Icon(
            icon,
            color: AppTheme.primaryGreen,
            size: 18,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textGrey,
            fontSize: 9,
          ),
        ),
      ],
    );
  }
}

/// HEX SHAPE
class _HexagonBorder extends ShapeBorder {
  const _HexagonBorder();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..moveTo(rect.width * 0.5, 0)
      ..lineTo(rect.width, rect.height * 0.25)
      ..lineTo(rect.width, rect.height * 0.75)
      ..lineTo(rect.width * 0.5, rect.height)
      ..lineTo(0, rect.height * 0.75)
      ..lineTo(0, rect.height * 0.25)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getOuterPath(rect);
}