import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:servicesplatform/core/features/web/utils/responsive.dart';
import 'package:servicesplatform/core/features/web/widgets/animated_border.dart';

class TopNavBar extends StatelessWidget {
  final VoidCallback onHome;
  final VoidCallback onDesigns;
  final VoidCallback onAbout;
  final VoidCallback onTestimonials;
  final VoidCallback onBlog;
  final VoidCallback onContact;

  const TopNavBar({
    super.key,
    required this.onHome,
    required this.onDesigns,
    required this.onAbout,
    required this.onTestimonials,
    required this.onBlog,
    required this.onContact,
  });

 Widget _navItem(BuildContext context, String title, VoidCallback onTap) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8), // 👈 spacing here
    child: AnimatedBorder(
      radius: 16,
      strokeWidth: 1.4,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: Colors.white70,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          textStyle: Theme.of(context).textTheme.bodyMedium,
        ),
        child: Text(title),
      ),
    ),
  );
}



  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final bool isTablet = Responsive.isTablet(context);

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 22, // stronger blur
            sigmaY: 22,
          ),
          child: Container(
            height: 72,
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 32),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: .25), //  more transparent
              border: Border(
                bottom: BorderSide(color: Colors.white.withValues(alpha: .12)),
              ),
            ),
            child: Row(
              children: [
                Text(
                  "PKPS-services",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),

                if (isMobile) ...[
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () => _openMobileMenu(context),
                  ),
                ] else ...[
                  Expanded(
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _navItem(context, "Home", onHome),
                          if (!isTablet)
                            _navItem(context, "Designs", onDesigns),
                          _navItem(context, "About Us", onAbout),
                          _navItem(context, "Testimonials", onTestimonials),
                          _navItem(context, "Blog", onBlog),
                          _navItem(context, "Contact Us", onContact),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 80),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black.withValues(alpha: .92),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _mobileItem(context, "Home", onHome),
              _mobileItem(context, "Designs", onDesigns),
              _mobileItem(context, "About Us", onAbout),
              _mobileItem(context, "Testimonials", onTestimonials),
              _mobileItem(context, "Blog", onBlog),
              _mobileItem(context, "Contact Us", onContact),
            ],
          ),
        );
      },
    );
  }

  Widget _mobileItem(BuildContext context, String title, VoidCallback onTap) {
    return ListTile(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(
          context,
        ).textTheme.headlineMedium?.copyWith(fontSize: 18),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}
