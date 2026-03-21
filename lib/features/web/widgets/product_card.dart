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
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    /// ✅ Dynamic colors
    final cardColor =
        isDark ? AppTheme.darkCard : AppTheme.cardLight;

    final borderColor =
        isDark ? AppTheme.borderColor : AppTheme.borderLight;

    final titleColor =
        isDark ? AppTheme.textPrimary : AppTheme.textBlack;

    final descColor =
        isDark ? AppTheme.textSecondary : AppTheme.textGrey;

    return GestureDetector(
      onTap: widget.onTap,
      child: Hero(
        tag: widget.isDeveloper ? "dev_prod" : "biz_prod",
        child: MouseRegion(
          onEnter: (_) {
            if (!isMobile) setState(() => hover = true);
          },
          onExit: (_) {
            if (!isMobile) setState(() => hover = false);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),

            width: isMobile ? 260 : 320,
            padding: EdgeInsets.all(isMobile ? 20 : 28),

            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: hover
                    ? AppTheme.primaryGreen.withOpacity(0.4)
                    : borderColor,
              ),
              boxShadow: [
                if (hover && !isMobile)
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 25,
                    offset: const Offset(0, 12),
                  ),
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Icon(
                  widget.isDeveloper
                      ? Icons.terminal
                      : Icons.business_center,
                  color: AppTheme.primaryGreen,
                  size: isMobile ? 32 : 40,
                ),

                SizedBox(height: isMobile ? 16 : 24),

                Text(
                  widget.isDeveloper
                      ? "Developer Platform"
                      : "Business Platform",
                  style: TextStyle(
                    color: titleColor,
                    fontSize: isMobile ? 18 : 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Explore powerful tools designed to help engineers grow and companies hire better.",
                  style: TextStyle(
                    color: descColor,
                    height: 1.5,
                    fontSize: isMobile ? 13 : 14,
                  ),
                ),

                SizedBox(height: isMobile ? 18 : 24),

                Row(
                  children: [
                    Text(
                      "View Details",
                      style: TextStyle(
                        color: titleColor,
                        fontWeight: FontWeight.bold,
                        fontSize: isMobile ? 13 : 14,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(
                      Icons.arrow_forward,
                      size: isMobile ? 16 : 18,
                      color: titleColor,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}