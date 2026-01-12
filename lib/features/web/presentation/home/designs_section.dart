// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:servicesplatform/core/app_router.dart';
// import 'package:servicesplatform/features/web/presentation/designs/design_overlay_screen.dart';
//
// import '../../../../models/design_item_models.dart';
// import '../../widgets/button.dart';
// import '../../widgets/design_lux_card.dart';
//
// class DesignsSection extends StatefulWidget {
//   const DesignsSection({super.key});
//
//   @override
//   State<DesignsSection> createState() => _DesignsSectionState();
// }
//
// class _DesignsSectionState extends State<DesignsSection> {
//   int? _hoveredIndex;
//
//   /// Logic to trigger the high-end Detail Overlay
//   void _showDesignDetail(BuildContext context, DesignItem item) {
//     showGeneralDialog(
//       context: context,
//       barrierDismissible: true,
//       barrierLabel: 'Design Detail',
//       barrierColor: Colors.black.withOpacity(0.85), // Premium dimming
//       transitionDuration: const Duration(milliseconds: 500),
//       pageBuilder: (context, anim1, anim2) {
//         // Note: You can pass the 'item' to the overlay if it accepts it
//         return const DesignDetailOverlay();
//       },
//       transitionBuilder: (context, anim1, anim2, child) {
//         return FadeTransition(
//           opacity: anim1,
//           child: SlideTransition(
//             position: Tween<Offset>(
//               begin: const Offset(0, 0.08), // Subtle slide up effect
//               end: Offset.zero,
//             ).animate(
//               CurvedAnimation(parent: anim1, curve: Curves.easeOutCubic),
//             ),
//             child: child,
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isDesktop = MediaQuery.of(context).size.width > 1024;
//     final double sidePadding = isDesktop ? 88 : 24;
//
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(vertical: 100),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [Colors.black, Color(0xFF0A0A0A)],
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // 1. CENTERED HEADER
//           _Header(),
//
//           const SizedBox(height: 80),
//
//           // 2. GRID
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: sidePadding),
//             child: GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: designsData.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: isDesktop ? 3 : 1,
//                 mainAxisSpacing: 40,
//                 crossAxisSpacing: 40,
//                 childAspectRatio: 1.45,
//               ),
//               itemBuilder: (context, index) {
//                 final bool isHovered = _hoveredIndex == index;
//                 final item = designsData[index];
//
//                 return MouseRegion(
//                   cursor: SystemMouseCursors.click,
//                   onEnter: (_) => setState(() => _hoveredIndex = index),
//                   onExit: (_) => setState(() => _hoveredIndex = null),
//                   child: Stack(
//                     alignment: Alignment.center,
//                     clipBehavior: Clip.none,
//                     children: [
//                       // AMBIENT GLOW EFFECT
//                       AnimatedOpacity(
//                         duration: const Duration(milliseconds: 500),
//                         opacity: isHovered ? 0.4 : 0,
//                         child: Container(
//                           width: 200,
//                           height: 200,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: const Color(0xFF8E2DE2).withOpacity(0.3),
//                                 blurRadius: 100,
//                                 spreadRadius: 20,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//
//                       // THE LUXURY CARD
//                       AnimatedScale(
//                         scale: isHovered ? 1.02 : 1.0,
//                         duration: const Duration(milliseconds: 400),
//                         curve: Curves.easeOutCubic,
//                         child: RepaintBoundary(
//                           child: LuxuryCard(
//                             item: item,
//                             // Pass the tap function to open overlay
//                             onTap: () => _showDesignDetail(context, item),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//
//           const SizedBox(height: 80),
//
//           // 3. CENTERED BUTTON
//           AppButton(
//             text: "Explore more Designs",
//             enableGlow: true,
//             onPressed: () {
//               context.go(AppRouter.designs);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _Header extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const Text(
//           "Featured Designs",
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 48,
//             fontWeight: FontWeight.w700,
//             letterSpacing: -0.5,
//           ),
//         ),
//         const SizedBox(height: 16),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Text(
//             "Explore our most popular designs crafted with precision and creativity to meet diverse business needs.",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.white.withOpacity(0.6),
//               fontSize: 16,
//               height: 1.5,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/core/bootstrap/bloc/app_bootstrap_bloc.dart';
import 'package:servicesplatform/features/web/presentation/designs/design_overlay_screen.dart';

import '../../../../models/design_item_models.dart';
import '../../widgets/button.dart';
import '../../widgets/design_lux_card.dart';
import '../designs/bloc/designs_bloc.dart';
import '../designs/bloc/designs_event.dart';
import '../designs/bloc/designs_state.dart';

class DesignsSection extends StatefulWidget {
  const DesignsSection({super.key});

  @override
  State<DesignsSection> createState() => _DesignsSectionState();
}

class _DesignsSectionState extends State<DesignsSection> {
  int? _hoveredIndex;

  @override
  void initState() {
    super.initState();
  }

  /// High-end Detail Overlay
  void _showDesignDetail(BuildContext context, DesignItem item) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Design Detail',
      barrierColor: Colors.black.withValues(alpha: .85),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => DesignDetailOverlay(data: item),
      transitionBuilder: (_, anim, __, child) {
        return FadeTransition(
          opacity: anim,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.08),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: anim, curve: Curves.easeOutCubic),
            ),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 1024;
    final double sidePadding = isDesktop ? 88 : 24;
    final designsList = context.watch<AppBootstrapBloc>().state.data?.designs;
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            "assets/images/background_lines.png",
            fit: BoxFit.fill,
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 100),
          decoration: const BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   colors: [Colors.black, Color(0xFF0A0A0A)],
            // ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const _Header(),
              const SizedBox(height: 80),

              /// 🔹 DESIGNS GRID
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sidePadding),
                child: BlocBuilder<DesignsBloc, DesignsState>(
                  builder: (context, state) {
                    // ⏳ Loading
                    if (state.listStatus == DesignsStatus.loading) {
                      return _buildLoadingGrid(isDesktop);
                    }

                    // ❌ Error
                    if (state.listStatus == DesignsStatus.failure) {
                      return _buildErrorState(state.errorMessage);
                    }

                    final designs = designsList?.items.take(6).toList();

                    // 📭 Empty
                    if (designs!.isEmpty) {
                      return _buildEmptyState();
                    }

                    // ✅ Success Grid
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: designs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isDesktop ? 3 : 1,
                        mainAxisSpacing: 40,
                        crossAxisSpacing: 40,
                        childAspectRatio: 1.45,
                      ),
                      itemBuilder: (context, index) {
                        final item = designsList?.items[index];
                        final isHovered = _hoveredIndex == index;

                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onEnter: (_) => setState(() => _hoveredIndex = index),
                          onExit: (_) => setState(() => _hoveredIndex = null),
                          child: Stack(
                            alignment: Alignment.center,
                            clipBehavior: Clip.none,
                            children: [
                              AnimatedOpacity(
                                duration: const Duration(milliseconds: 500),
                                opacity: isHovered ? 0.4 : 0,
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF8E2DE2,
                                        ).withValues(alpha: .3),
                                        blurRadius: 100,
                                        spreadRadius: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              AnimatedScale(
                                scale: isHovered ? 1.02 : 1.0,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeOutCubic,
                                child: RepaintBoundary(
                                  child: DesignLuxuryCard(
                                    item: item!,
                                    onTap: () {
                                      _showDesignDetail(context, item);
                                      context.read<DesignsBloc>().add(
                                        IncrementDesignView(item.id),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 80),

              /// 🔹 CTA
              AppButton(
                text: "Explore more Designs",
                enableGlow: true,
                onPressed: () => context.go('/designs'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ───────────────── UI STATES ─────────────────

  Widget _buildLoadingGrid(bool isDesktop) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: isDesktop ? 3 : 1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isDesktop ? 3 : 1,
        mainAxisSpacing: 40,
        crossAxisSpacing: 40,
        childAspectRatio: 1.45,
      ),
      itemBuilder:
          (_, __) => Container(
            height: 220,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .04),
              borderRadius: BorderRadius.circular(24),
            ),
          ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      children: [
        const Icon(Icons.auto_awesome, color: Colors.white24, size: 60),
        const SizedBox(height: 16),
        const Text(
          "No designs available yet",
          style: TextStyle(
            color: Colors.white70,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "New premium designs are coming soon.",
          style: TextStyle(color: Colors.white.withValues(alpha: .5)),
        ),
      ],
    );
  }

  Widget _buildErrorState(String? message) {
    return Column(
      children: [
        const Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
        const SizedBox(height: 12),
        Text(
          message ?? 'Failed to load designs',
          style: const TextStyle(color: Colors.white70),
        ),
      ],
    );
  }
}

// ───────────────── HEADER ─────────────────

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Featured Designs",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 48,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "Explore our most popular designs crafted with precision and creativity to meet diverse business needs.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: .6),
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
