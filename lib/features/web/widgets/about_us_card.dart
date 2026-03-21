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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardColor =
        isDark ? AppTheme.darkCard : AppTheme.cardLight;

    final borderColor =
        isDark ? AppTheme.borderColor : AppTheme.borderLight;

    final titleColor =
        isDark ? AppTheme.textPrimary : AppTheme.textBlack;

    final subTextColor =
        isDark ? AppTheme.textSecondary : AppTheme.textGrey;

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
        child: Container(
          width: isMobile ? 280 : 360,
          padding: const EdgeInsets.all(24),

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
              const SizedBox(height: 25),

              _buildSectionTitle("Certifications", titleColor),

              Row(
                children: [
                  Expanded(
                    child: _MiniProgressCard(
                      title: "ML Engineer",
                      progress: 0.8,
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _MiniProgressCard(
                      title: "Data Scientist",
                      progress: 0.4,
                      isDark: isDark,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              _buildSectionTitle("Badges", titleColor),

              const Row(
                children: [
                  _HexBadge(label: "PyTorch", icon: Icons.bolt),
                  SizedBox(width: 20),
                  _HexBadge(label: "Python", icon: Icons.terminal),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Color titleColor, Color subTextColor) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 22,
          backgroundImage: NetworkImage(
              "https://randomuser.me/api/portraits/women/44.jpg"),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ada",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: titleColor,
              ),
            ),
            Text(
              "ML Engineer",
              style: TextStyle(
                fontSize: 12,
                color: subTextColor,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildSectionTitle(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
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
        color: isDark
            ? AppTheme.surfaceGrey
            : AppTheme.bgSoftGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 9,
            ),
            maxLines: 1,
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.black12,
            color: AppTheme.primaryGreen,
            minHeight: 2,
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
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getOuterPath(rect);

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
}