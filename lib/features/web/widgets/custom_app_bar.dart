import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Breakpoints
// ─────────────────────────────────────────────────────────────────────────────
class _BP {
  static const double mobile = 600; // < 600 → hamburger only
  static const double tablet = 900; // 600–900 → logo + hamburger, no nav
  static const double smallDesk =
      1100; // 900–1100 → compact nav (no pricing/service)
  // ≥ 1100 → full nav
}

class CustomAppBar extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onAboutTap;
  final VoidCallback onProductTap;
  final VoidCallback onIndustriesTap;
  final VoidCallback onBlogTap;
  final VoidCallback onContactTap;

  const CustomAppBar({
    super.key,
    required this.onHomeTap,
    required this.onAboutTap,
    required this.onProductTap,
    required this.onIndustriesTap,
    required this.onBlogTap,
    required this.onContactTap,
  });

  void _showGlassMenu(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Menu',
      barrierColor: Colors.black.withValues(alpha: .2),
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder:
          (ctx, a1, a2) => Align(
            alignment: Alignment.centerRight,
            child: _GlassMenuOverlay(
              onHomeTap: onHomeTap,
              onAboutTap: onAboutTap,
              onProductTap: onProductTap,
              onIndustriesTap: onIndustriesTap,
              onBlogTap: onBlogTap,
              onContactTap: onContactTap,
            ),
          ),
      transitionBuilder:
          (ctx, a1, a2, child) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: a1, curve: Curves.easeOutCubic)),
            child: child,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < _BP.mobile;
    final isTablet = w >= _BP.mobile && w < _BP.tablet;
    final isSmallDesk = w >= _BP.tablet && w < _BP.smallDesk;
    final isFullDesk = w >= _BP.smallDesk;

    // Horizontal padding scales with width, clamped so it never overflows
    final double hPad = (w * 0.035).clamp(12.0, 60.0);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          height: 64,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: hPad),
          decoration: BoxDecoration(
            color: const Color(0x55060810),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: .07),
                width: 0.8,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ── LOGO (never shrinks below its intrinsic size) ──
              _Logo(),

              // ── CENTER NAV (only on desktop sizes) ────────────
              if (isSmallDesk || isFullDesk) ...[
                const Spacer(),
                _DesktopNav(
                  compact: isSmallDesk,
                  onHomeTap: onHomeTap,
                  onAboutTap: onAboutTap,
                  onProductTap: onProductTap,
                  onIndustriesTap: onIndustriesTap,
                  onBlogTap: onBlogTap,
                  onContactTap: onContactTap,
                ),
                const Spacer(),
              ] else
                const Spacer(),

              // ── RIGHT ACTIONS ─────────────────────────────────
              if (isMobile || isTablet)
                // Hamburger only
                _HamburgerButton(onTap: () => _showGlassMenu(context)),
              //    else
              // login + CTA — scaled for screen size
              //  _DesktopActions(compact: isSmallDesk),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Logo
// ─────────────────────────────────────────────────────────────────────────────

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final bool small = w < _BP.tablet;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Circle mark
        Container(
          width: small ? 24 : 28,
          height: small ? 24 : 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: .55),
              width: 1.5,
            ),
          ),
          child: Center(
            child: Container(
              width: small ? 23 : 27,
              height: small ? 23 : 27,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/gif/Sell tech.gif'),
                  fit: BoxFit.cover,
                  repeat: ImageRepeat.repeat,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: small ? 7 : 10),
        Text(
          'SellTech IND. Productions',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: small ? 13 : 15,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Desktop Nav
// ─────────────────────────────────────────────────────────────────────────────

class _DesktopNav extends StatelessWidget {
  final bool compact;
  final VoidCallback onHomeTap;
  final VoidCallback onAboutTap;
  final VoidCallback onProductTap;
  final VoidCallback onIndustriesTap;
  final VoidCallback onBlogTap;
  final VoidCallback onContactTap;

  const _DesktopNav({
    required this.compact,
    required this.onHomeTap,
    required this.onAboutTap,
    required this.onProductTap,
    required this.onIndustriesTap,
    required this.onBlogTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    // compact mode shows fewer items to avoid overflow on small desktops
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _NavItem(title: 'Our Services', onTap: onProductTap, compact: compact),
        if (!compact)
          _NavItem(
            title: 'About US',
            onTap: onAboutTap,
            compact: compact,
            accent: true,
          ),
        _NavItem(title: 'Industries', onTap: onIndustriesTap, compact: compact),
        //_NavItem(title: 'Blog', onTap: onBlogTap, compact: compact),
        if (!compact)
          _NavItem(title: 'Contact US', onTap: onContactTap, compact: false),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Desktop Actions (login + CTA)
// ─────────────────────────────────────────────────────────────────────────────

// class _DesktopActions extends StatelessWidget {
//   final bool compact;
//
//   const _DesktopActions({required this.compact});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         if (!compact)
//           GestureDetector(
//             onTap: () {},
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 14),
//               child: Text(
//                 'login',
//                 style: TextStyle(
//                   color: Colors.white.withValues(alpha: .65),
//                   fontWeight: FontWeight.w400,
//                   fontSize: 14,
//                 ),
//               ),
//             ),
//           ),
//         _AstroCtaButton(
//           label: compact ? 'Demo' : 'Request demo',
//           onTap: () {
//             // This navigates to the screen I created for you
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const RequestDemoScreen(),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }

// ─────────────────────────────────────────────────────────────────────────────
// Hamburger Button
// ─────────────────────────────────────────────────────────────────────────────

class _HamburgerButton extends StatelessWidget {
  final VoidCallback onTap;

  const _HamburgerButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.menu,
        color: Colors.white.withValues(alpha: .85),
        size: 24,
      ),
      onPressed: onTap,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Nav Item
// ─────────────────────────────────────────────────────────────────────────────

class _NavItem extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final bool accent;
  final bool compact;

  const _NavItem({
    required this.title,
    required this.onTap,
    this.accent = false,
    this.compact = false,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final Color color =
        widget.accent
            ? AppTheme.primaryGreen
            : (_hover ? Colors.white : Colors.white.withValues(alpha: .65));

    final double hPad = widget.compact ? 10.0 : 16.0;
    final double fontSize = widget.compact ? 13.0 : 14.0;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: hPad),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 160),
            style: TextStyle(
              color: color,
              fontWeight: widget.accent ? FontWeight.w600 : FontWeight.w400,
              fontSize: fontSize,
            ),
            child: Text(widget.title),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Astro CTA Button
// ─────────────────────────────────────────────────────────────────────────────

class _AstroCtaButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _AstroCtaButton({required this.label, required this.onTap});

  @override
  State<_AstroCtaButton> createState() => _AstroCtaButtonState();
}

class _AstroCtaButtonState extends State<_AstroCtaButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color:
                  _hover
                      ? Colors.white.withValues(alpha: .55)
                      : Colors.white.withValues(alpha: .25),
              width: 0.8,
            ),
            color:
                _hover
                    ? Colors.white.withValues(alpha: .08)
                    : Colors.transparent,
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: _hover ? 1.0 : 0.85),
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Glass Menu Overlay (mobile / tablet hamburger)
// ─────────────────────────────────────────────────────────────────────────────

class _GlassMenuOverlay extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onAboutTap;
  final VoidCallback onProductTap;
  final VoidCallback onIndustriesTap;
  final VoidCallback onBlogTap;
  final VoidCallback onContactTap;

  const _GlassMenuOverlay({
    required this.onHomeTap,
    required this.onAboutTap,
    required this.onProductTap,
    required this.onIndustriesTap,
    required this.onBlogTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final sw = mq.size.width;

    // Drawer width: 65% on mobile, capped at 320px on tablet
    final drawerW = (sw * 0.65).clamp(0.0, 320.0);

    return Material(
      color: Colors.transparent,
      child: Row(
        children: [
          // Dismiss area
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(color: Colors.transparent),
            ),
          ),
          // Drawer
          SizedBox(
            width: drawerW,
            height: double.infinity,
            child: ClipRRect(
              child: Stack(
                children: [
                  // Blur layer
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                    child: Container(color: const Color(0xCC060810)),
                  ),
                  // Gradient sheen
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withValues(alpha: .06),
                          Colors.white.withValues(alpha: .01),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border(
                        left: BorderSide(
                          color: Colors.white.withValues(alpha: .10),
                          width: 0.8,
                        ),
                      ),
                    ),
                  ),
                  // Content
                  SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Close button
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.white.withValues(alpha: .8),
                                size: 22,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),
                        // Nav items — centred vertically in remaining space
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _MenuTile(
                                title: 'HOME',
                                onTap: () {
                                  Navigator.pop(context);
                                  onHomeTap();
                                },
                              ),
                              _MenuTile(
                                title: 'ABOUT US',
                                onTap: () {
                                  Navigator.pop(context);
                                  onAboutTap();
                                },
                              ),
                              _MenuTile(
                                title: 'OUR SERVICES',
                                onTap: () {
                                  Navigator.pop(context);
                                  onProductTap();
                                },
                              ),
                              _MenuTile(
                                title: 'INDUSTRIES',
                                onTap: () {
                                  Navigator.pop(context);
                                  onIndustriesTap();
                                },
                              ),
                              // _MenuTile(
                              //   title: 'BLOG',
                              //   onTap: () {
                              //     Navigator.pop(context);
                              //     onBlogTap();
                              //   },
                              // ),
                              _MenuTile(
                                title: 'CONTACT US',
                                onTap: () {
                                  Navigator.pop(context);
                                  onContactTap();
                                },
                              ),
                              // const SizedBox(height: 32),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(
                              //     horizontal: 24,
                              //   ),
                              //   child: _AstroCtaButton(
                              //     label: 'Start free trial',
                              //     onTap: () {},
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Menu Tile
// ─────────────────────────────────────────────────────────────────────────────

class _MenuTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _MenuTile({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w500,
            letterSpacing: 2.5,
          ),
        ),
      ),
    );
  }
}
