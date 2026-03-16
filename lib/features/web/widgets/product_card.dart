import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';

class ProductCard extends StatefulWidget {
  final bool isDeveloper;

  const ProductCard({
    super.key,
    required this.isDeveloper,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {

  bool isHover = false;

  @override
  Widget build(BuildContext context) {

    final isMobile = Responsive.isMobile(context);

    return MouseRegion(
      onEnter: (_) {
        if (!isMobile) setState(() => isHover = true);
      },
      onExit: (_) {
        if (!isMobile) setState(() => isHover = false);
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),

        width: isMobile ? double.infinity : 360,

        padding: const EdgeInsets.all(28),

        decoration: BoxDecoration(
          color: const Color(0xFF0E1B18),
          borderRadius: BorderRadius.circular(20),

          boxShadow: [
            if (isHover)
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 25,
                offset: const Offset(0, 14),
              )
          ],
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            /// TITLE
            Text(
              widget.isDeveloper
                  ? "For Developers"
                  : "For Businesses",

              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 12),

            /// DESCRIPTION
            Text(
              widget.isDeveloper
                  ? "Improve coding skills and prepare for modern tech interviews."
                  : "Hire and scale high-quality engineering teams.",

              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 24),

            /// BUTTON
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),

              decoration: BoxDecoration(
                color: widget.isDeveloper
                    ? AppTheme.primaryGreen
                    : Colors.white10,

                borderRadius: BorderRadius.circular(10),
              ),

              alignment: Alignment.center,

              child: Text(
                widget.isDeveloper
                    ? "Explore"
                    : "Contact Sales",

                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: widget.isDeveloper
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}