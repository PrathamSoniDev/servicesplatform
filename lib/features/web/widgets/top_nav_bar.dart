import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicesplatform/core/bootstrap/bloc/app_bootstrap_bloc.dart';
import 'package:servicesplatform/core/bootstrap/bloc/app_bootstrap_state.dart';
import 'package:servicesplatform/features/auth/auth_bloc.dart';
import 'package:servicesplatform/features/web/widgets/button.dart';

import '../../../core/bootstrap/bloc/app_bootstrap_event.dart';
import '../presentation/home/custom_shimmer.dart';
import '../utils/responsive.dart';
import 'animated_border.dart';
import 'auth_popup.dart'; // Ensure your AnimatedBorder file is in the same directory

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
  OverlayEntry? _overlayEntry;

  List<Map<String, dynamic>> get navLinks => [
    {'title': "Home", 'index': 0, 'onTap': widget.onHome},
    {'title': "Designs", 'index': 1, 'onTap': widget.onDesigns},
    {'title': "About", 'index': 2, 'onTap': widget.onAbout},
    {'title': "Reviews", 'index': 3, 'onTap': widget.onTestimonials},
    {'title': "Blog", 'index': 4, 'onTap': widget.onBlog},
    {'title': "Contact", 'index': 5, 'onTap': widget.onContact},
  ];

  void _toggleMenu() {
    if (_isMenuOpen) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    }
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen =
        Responsive.isMobile(context) || Responsive.isTablet(context);
    final theme = Theme.of(context);

    return ClipRect(
      child: BackdropFilter(
        // Optimized blur for performance
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: BlocBuilder<AppBootstrapBloc, AppBootstrapState>(
          builder: (context, state) {
            switch (state.status) {
              case AppBootstrapStatus.loading:
                return const AdaptiveShimmer(layout: ShimmerLayout.hero);

              case AppBootstrapStatus.failure:
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Failed to load app data'),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          context.read<AppBootstrapBloc>().add(
                            RetryAppBootstrap(),
                          );
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              case AppBootstrapStatus.initial:
                // TODO: Handle this case.
                throw UnimplementedError();
              case AppBootstrapStatus.success:
                final data = state.data!;
                final profile = data.profile;
                return Container(
                  height: 80,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: .4),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white.withValues(alpha: .05),
                      ),
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment:
                            isSmallScreen
                                ? Alignment.center
                                : Alignment.centerLeft,
                        child: _buildLogo(theme),
                      ),
                      if (!isSmallScreen)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children:
                              navLinks
                                  .map(
                                    (link) =>
                                        _buildNavItem(context, link, false),
                                  )
                                  .toList(),
                        ),
                      !isSmallScreen && profile == null
                          ? Align(
                            alignment: Alignment.centerRight,
                            child: AppButton(
                              text: "Get Started",
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (dialogContext) {
                                    return BlocProvider.value(
                                      value: context.read<AuthBloc>(),
                                      child: const AuthPopup(),
                                    );
                                  },
                                );
                              },
                            ),
                          )
                          : Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  radius: 26,
                                  backgroundColor: Colors.grey.shade800,
                                  backgroundImage:
                                      (profile?.profileImg != null &&
                                              profile!.profileImg!.isNotEmpty)
                                          ? CachedNetworkImageProvider(
                                            profile.profileImg!,
                                          )
                                          : null,
                                  child:
                                      (profile?.profileImg == null ||
                                              profile!.profileImg!.isEmpty)
                                          ? const Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          )
                                          : null,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  profile?.email ?? "",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                      if (isSmallScreen)
                        Align(
                          alignment: Alignment.centerRight,
                          child: _buildAdaptiveToggle(theme),
                        ),
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder:
          (context) => Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Material(
              color: Colors.transparent,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                builder:
                    (context, value, child) => Transform.scale(
                      scale: 0.95 + (0.05 * value),
                      child: Opacity(opacity: value, child: child),
                    ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    // Lower sigma for mobile overlay to prevent lag
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      height: 75,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .08),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: .1),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: .5),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Center(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children:
                                navLinks
                                    .map(
                                      (link) =>
                                          _buildNavItem(context, link, true),
                                    )
                                    .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
    );
  }

  Widget _buildLogo(ThemeData theme) {
    return ShaderMask(
      shaderCallback:
          (bounds) => LinearGradient(
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
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    Map<String, dynamic> item,
    bool isMobile,
  ) {
    final int index = item['index'];
    final bool isActive = widget.activeIndex == index;
    final bool isHovered = _hoveredIndex == index;

    // The base UI of the button
    Widget navContent = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 18 : 22,
        vertical: isMobile ? 12 : 10,
      ),
      decoration: BoxDecoration(
        color:
            isActive
                ? Colors.white.withValues(alpha: .05)
                : (isHovered
                    ? Colors.white.withValues(alpha: .1)
                    : Colors.transparent),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        item['title'],
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: isActive || isHovered ? Colors.white : Colors.white70,
          fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
          fontSize: isMobile ? 14 : 15,
        ),
      ),
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = null),
      child: GestureDetector(
        onTap: () {
          item['onTap']();
          if (_isMenuOpen) _toggleMenu();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          // ISOLATION: RepaintBoundary prevents the animation from lagging the whole screen
          child:
              isActive
                  ? RepaintBoundary(
                    child: AnimatedBorder(
                      radius: 12,
                      strokeWidth: 2.0, // Thinner for Navbar
                      child: navContent,
                    ),
                  )
                  : navContent,
        ),
      ),
    );
  }

  Widget _buildAdaptiveToggle(ThemeData theme) {
    return GestureDetector(
      onTap: _toggleMenu,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              _isMenuOpen
                  ? theme.colorScheme.primary.withValues(alpha: .1)
                  : Colors.white.withValues(alpha: .05),
          border: Border.all(
            color:
                _isMenuOpen
                    ? theme.colorScheme.primary
                    : Colors.white.withValues(alpha: .1),
          ),
        ),
        child: AnimatedRotation(
          duration: const Duration(milliseconds: 400),
          turns: _isMenuOpen ? 0.25 : 0,
          curve: Curves.easeOutBack,
          child: Icon(
            _isMenuOpen ? Icons.add_rounded : Icons.widgets_outlined,
            color: _isMenuOpen ? theme.colorScheme.primary : Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }
}
