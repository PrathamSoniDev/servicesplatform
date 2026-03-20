import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onAboutTap;
  final VoidCallback onProductTap;
  final VoidCallback onBlogTap;
  final VoidCallback onContactTap;

  const CustomAppBar({
    super.key,
    required this.onHomeTap,
    required this.onAboutTap,
    required this.onProductTap,
    required this.onBlogTap,
    required this.onContactTap,
  });

  void _showGlassMenu(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Menu",
      barrierColor: Colors.black.withOpacity(0.2),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.centerRight,
          child: _GlassMenuOverlay(
            onHomeTap: onHomeTap,
            onAboutTap: onAboutTap,
            onProductTap: onProductTap,
            onBlogTap: onBlogTap,
            onContactTap: onContactTap,
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(anim1),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    final bool isMobile = Responsive.isMobile(context);

    return Material(
      color: Colors.black,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: padding, vertical: 18),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white.withOpacity(.08),
            ),
          ),
        ),
        child: Row(
          children: [
            Row(
              children: [
                Text(
                  "YourCompany",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 8,
                  height: 8,
                  color: AppTheme.primaryGreen,
                ),
              ],
            ),

            if (!isMobile) ...[
              const SizedBox(width: 40),
              Row(
                children: [
                  _NavItem(title: "Home", onTap: onHomeTap),
                  _NavItem(title: "About", onTap: onAboutTap),
                  _NavItem(title: "Products", onTap: onProductTap),
                  _NavItem(title: "Blog", onTap: onBlogTap),
                  _NavItem(title: "Contact", onTap: onContactTap),
                ],
              ),
            ],

            const Spacer(),

            if (isMobile)
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white, size: 28),
                onPressed: () => _showGlassMenu(context),
              )
            else
              Row(
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(color: Colors.white.withOpacity(.2)),
                    ),
                    onPressed: () {},
                    child: const Text("Request Demo"),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGreen,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {},
                    child: const Text("Sign Up"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

/// 🔥 GLASS DRAWER (IMPROVED)
class _GlassMenuOverlay extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onAboutTap;
  final VoidCallback onProductTap;
  final VoidCallback onBlogTap;
  final VoidCallback onContactTap;

  const _GlassMenuOverlay({
    required this.onHomeTap,
    required this.onAboutTap,
    required this.onProductTap,
    required this.onBlogTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Material(
      color: Colors.transparent,
      child: Row(
        children: [
          /// LEFT CLICK AREA
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(color: Colors.transparent),
            ),
          ),

          /// RIGHT GLASS DRAWER
          ClipRRect(
            child: Container(
              width: width * 0.6,
              height: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Colors.white.withOpacity(0.15),
                  ),
                ),
              ),
              child: Stack(
                children: [
                  /// BLUR BACKGROUND
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                    child: Container(
                      color: Colors.white.withOpacity(0.05), // 👈 REAL GLASS
                    ),
                  ),

                  /// GRADIENT OVERLAY (PREMIUM LOOK)
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.08),
                          Colors.white.withOpacity(0.02),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),

                  SafeArea(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: IconButton(
                              icon: const Icon(Icons.close, color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),

                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _MenuTile(title: "HOME", onTap: () { Navigator.pop(context); onHomeTap(); }),
                              _MenuTile(title: "ABOUT", onTap: () { Navigator.pop(context); onAboutTap(); }),
                              _MenuTile(title: "PRODUCTS", onTap: () { Navigator.pop(context); onProductTap(); }),
                              _MenuTile(title: "BLOG", onTap: () { Navigator.pop(context); onBlogTap(); }),
                              _MenuTile(title: "CONTACT", onTap: () { Navigator.pop(context); onContactTap(); }),

                              const SizedBox(height: 30),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.primaryGreen,
                                    foregroundColor: Colors.black,
                                    minimumSize: const Size(double.infinity, 50),
                                  ),
                                  onPressed: () {},
                                  child: const Text("SIGN UP"),
                                ),
                              ),
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

/// MENU TILE
class _MenuTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _MenuTile({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: InkWell(
        onTap: onTap,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}

/// NAV ITEM
class _NavItem extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const _NavItem({required this.title, required this.onTap});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isHover
                      ? AppTheme.primaryGreen
                      : Colors.white.withOpacity(.8),
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ),
    );
  }
}