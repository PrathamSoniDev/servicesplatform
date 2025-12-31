import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils/responsive.dart';
import 'animated_border.dart';

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
  bool _isMenuOpen = false;

  Widget _navItem({
    required BuildContext context,
    required String title,
    required VoidCallback onTap,
    required int index,
  }) {
    final bool isActive = widget.activeIndex == index;
    final bool isHovered = _hoveredIndex == index;

    Widget content = AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive 
            ? Colors.white.withValues(alpha: 0.08)
            : (isHovered ? Colors.white.withValues(alpha: 0.12) : Colors.transparent),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isActive || isHovered ? Colors.white : Colors.white70,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              letterSpacing: 0.3,
            ),
      ),
    );

    if (isActive) {
      content = AnimatedBorder(radius: 12, strokeWidth: 1.2, child: content);
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = null),
      child: GestureDetector(
        onTap: () {
          onTap();
          if (_isMenuOpen) setState(() => _isMenuOpen = false);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: content,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final bool isTablet = Responsive.isTablet(context);
    final theme = Theme.of(context);

    return Stack(
      children: [
        // --- Main Top Bar ---
        Positioned(
          top: 0, left: 0, right: 0,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                height: 72,
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.4),
                  border: Border(
                    bottom: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
                  ),
                ),
                child: Row(
                  // Center the logo on mobile/tablet, space-between on desktop
                  mainAxisAlignment: isMobile || isTablet 
                      ? MainAxisAlignment.center 
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    // --- Gradient Text Logo Pulling from AppTheme ---
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.secondary,
                          theme.colorScheme.tertiary,
                        ],
                      ).createShader(bounds),
                      child: Text(
                        "Devnex Services",
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                          color: Colors.white, // Mask base
                        ),
                      ),
                    ),

                    if (!isMobile && !isTablet) _buildDesktopMenu(context),
                  ],
                ),
              ),
            ),
          ),
        ),

        // --- Futuristic Menu Toggle (Positioned Right) ---
        if (isMobile || isTablet)
          Positioned(
            top: 14,
            right: 20,
            child: _buildFuturisticToggle(theme),
          ),

        // --- Mobile Glass Menu ---
        if (_isMenuOpen) _buildPremiumMobileMenu(context),
      ],
    );
  }

  Widget _buildFuturisticToggle(ThemeData theme) {
    return GestureDetector(
      onTap: () => setState(() => _isMenuOpen = !_isMenuOpen),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer Halo Ring
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _isMenuOpen 
                    ? theme.colorScheme.primary.withValues(alpha: 0.1) 
                    : Colors.transparent,
                border: Border.all(
                  color: _isMenuOpen 
                      ? theme.colorScheme.primary 
                      : Colors.white.withValues(alpha: 0.2),
                  width: 1.2,
                ),
                boxShadow: _isMenuOpen ? [
                  BoxShadow(
                    color: theme.colorScheme.primary.withValues(alpha: 0.3),
                    blurRadius: 12,
                  )
                ] : [],
              ),
            ),
            // Tech-style Icon (Widgets to Cross)
            AnimatedRotation(
              duration: const Duration(milliseconds: 500),
              turns: _isMenuOpen ? 0.25 : 0,
              curve: Curves.elasticOut,
              child: Icon(
                _isMenuOpen ? Icons.add_rounded : Icons.widgets_outlined,
                color: _isMenuOpen ? theme.colorScheme.primary : Colors.white,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopMenu(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _navItem(context: context, title: "Home", index: 0, onTap: widget.onHome),
        _navItem(context: context, title: "Designs", index: 1, onTap: widget.onDesigns),
        _navItem(context: context, title: "About Us", index: 2, onTap: widget.onAbout),
        _navItem(context: context, title: "Testimonials", index: 3, onTap: widget.onTestimonials),
        _navItem(context: context, title: "Blog", index: 4, onTap: widget.onBlog),
        _navItem(context: context, title: "Contact Us", index: 5, onTap: widget.onContact),
      ],
    );
  }

  Widget _buildPremiumMobileMenu(BuildContext context) {
    return Positioned(
      bottom: 24,
      left: 15,
      right: 15,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 500),
        curve: Curves.elasticOut,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, 40 * (1 - value)),
            child: Opacity(opacity: value.clamp(0.0, 1.0), child: child),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.15),
                  width: 1,
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _navItem(context: context, title: "Home", index: 0, onTap: widget.onHome),
                      _navItem(context: context, title: "Designs", index: 1, onTap: widget.onDesigns),
                      _navItem(context: context, title: "About", index: 2, onTap: widget.onAbout),
                      _navItem(context: context, title: "Reviews", index: 3, onTap: widget.onTestimonials),
                      _navItem(context: context, title: "Blog", index: 4, onTap: widget.onBlog),
                      _navItem(context: context, title: "Contact", index: 5, onTap: widget.onContact),
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