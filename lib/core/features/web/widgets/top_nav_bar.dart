import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:servicesplatform/core/features/web/utils/responsive.dart';
import 'package:servicesplatform/core/features/web/widgets/animated_border.dart';

class TopNavBar extends StatefulWidget {
  final int activeIndex;

  final VoidCallback onHome;
  final VoidCallback onDesigns;
  final VoidCallback onAbout;
  final VoidCallback onTestimonials;
  final VoidCallback onBlog;
  final VoidCallback onContact;

  const TopNavBar({
    super.key,
    required this.activeIndex,
    required this.onHome,
    required this.onDesigns,
    required this.onAbout,
    required this.onTestimonials,
    required this.onBlog,
    required this.onContact,
  });

  @override
  State<TopNavBar> createState() => _TopNavBarState();
}

class _TopNavBarState extends State<TopNavBar> {
  int? _hoveredIndex;

  Widget _navItem({
    required BuildContext context,
    required String title,
    required VoidCallback onTap,
    required int index,
  }) {
    final bool isActive = widget.activeIndex == index;
    final bool isHovered = _hoveredIndex == index;

    Widget content = AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isHovered && !isActive
            ? Colors.white.withValues(alpha: 0.08)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
      ),
      child: AnimatedScale(
        scale: isHovered ? 1.04 : 1.0,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isActive
                    ? Colors.white
                    : isHovered
                        ? Colors.white
                        : Colors.white70,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
        ),
      ),
    );

    // 🔥 Only ACTIVE item gets AnimatedBorder
    if (isActive) {
      content = AnimatedBorder(
        radius: 16,
        strokeWidth: 1.4,
        child: content,
      );
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = null),
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: content,
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
          filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
          child: Container(
            height: 72,
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 32),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: .25),
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withValues(alpha: .12),
                ),
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
                          _navItem(
                            context: context,
                            title: "Home",
                            index: 0,
                            onTap: widget.onHome,
                          ),
                          if (!isTablet)
                            _navItem(
                              context: context,
                              title: "Designs",
                              index: 1,
                              onTap: widget.onDesigns,
                            ),
                          _navItem(
                            context: context,
                            title: "About Us",
                            index: 2,
                            onTap: widget.onAbout,
                          ),
                          _navItem(
                            context: context,
                            title: "Testimonials",
                            index: 3,
                            onTap: widget.onTestimonials,
                          ),
                          _navItem(
                            context: context,
                            title: "Blog",
                            index: 4,
                            onTap: widget.onBlog,
                          ),
                          _navItem(
                            context: context,
                            title: "Contact Us",
                            index: 5,
                            onTap: widget.onContact,
                          ),
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
              _mobileItem(context, "Home", widget.onHome),
              _mobileItem(context, "Designs", widget.onDesigns),
              _mobileItem(context, "About Us", widget.onAbout),
              _mobileItem(context, "Testimonials", widget.onTestimonials),
              _mobileItem(context, "Blog", widget.onBlog),
              _mobileItem(context, "Contact Us", widget.onContact),
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
        style:
            Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 18),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}
