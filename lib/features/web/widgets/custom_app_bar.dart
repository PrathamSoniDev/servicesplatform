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

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Material( // ✅ Needed for InkWell taps
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

              /// LOGO
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

              const SizedBox(width: 40),

              /// NAV ITEMS
              if (!Responsive.isMobile(context))
                Row(
                  children: [
                    _NavItem(title: "Home", onTap: onHomeTap),
                    _NavItem(title: "About", onTap: onAboutTap),
                    _NavItem(title: "Products", onTap: onProductTap),
                    _NavItem(title: "Blog", onTap: onBlogTap),
                    _NavItem(title: "Contact", onTap: onContactTap),
                  ],
                ),

              const Spacer(),

              /// RIGHT SIDE BUTTONS
              if (!Responsive.isMobile(context))
                Row(
                  children: [

                    /// REQUEST DEMO
                    Container(
                      margin: const EdgeInsets.only(right: 16),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: BorderSide(
                            color: Colors.white.withOpacity(.2),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 12,
                          ),
                        ),
                        onPressed: () {},
                        child: const Text("Request Demo"),
                      ),
                    ),

                    /// SIGN UP
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryGreen,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 12,
                        ),
                      ),
                      onPressed: () {},
                      child: const Text("Sign Up"),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const _NavItem({
    required this.title,
    required this.onTap,
  });

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
        child: InkWell(
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