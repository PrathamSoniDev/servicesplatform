import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/features/web/presentation/about_us/about_screen.dart';
import 'package:servicesplatform/features/web/presentation/blog/blog_detail_screen.dart';
import 'package:servicesplatform/features/web/presentation/blog/blog_screen.dart';
import 'package:servicesplatform/features/web/presentation/contact_us/contact_us.dart';
import 'package:servicesplatform/features/web/presentation/designs/design_screen.dart';
import 'package:servicesplatform/features/web/presentation/home/homescreen.dart';
import 'package:servicesplatform/features/web/presentation/profile/profile_screen.dart';

import '../features/web/presentation/designs/design_overlay_screen.dart';
import '../models/blog_model.dart';
import '../models/design_item_models.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static const String home = '/';
  static const String aboutUs = '/about';
  static const String blog = '/blog';
  static const String contact = '/contact';
  static const String designs = '/designs';
  static const String profile = '/profile';

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: home,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(path: home, builder: (_, __) => const HomeScreen()),

      GoRoute(path: aboutUs, builder: (_, __) => const AboutScreen()),

      GoRoute(
        path: blog,
        builder: (_, __) => const BlogScreen(),
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              final blog = state.extra as BlogModel?;
              return BlogDetailScreen(id: id, blog: blog);
            },
          ),
        ],
      ),

      GoRoute(path: contact, builder: (_, __) => const ContactUs()),

      GoRoute(path: profile, builder: (_, __) => const ProfileScreen()),

      GoRoute(path: designs, builder: (_, __) => const DesignScreen()),

      // ✅ DESIGN OVERLAY ROUTE
      // GoRoute(
      //   path: '/design/:slug',
      //   parentNavigatorKey: rootNavigatorKey,
      //   pageBuilder: (context, state) {
      //     final design = state.extra as DesignItem?;
      //
      //     return CustomTransitionPage(
      //       key: state.pageKey,
      //       opaque: false,
      //       barrierDismissible: true,
      //       barrierColor: Colors.black.withValues(alpha: .85),
      //       transitionDuration: const Duration(milliseconds: 450),
      //       child: DesignDetailOverlay(data: design!),
      //       transitionsBuilder: (_, animation, __, child) {
      //         return FadeTransition(
      //           opacity: animation,
      //           child: SlideTransition(
      //             position: Tween<Offset>(
      //               begin: const Offset(0, 0.08),
      //               end: Offset.zero,
      //             ).animate(
      //               CurvedAnimation(
      //                 parent: animation,
      //                 curve: Curves.easeOutCubic,
      //               ),
      //             ),
      //             child: child,
      //           ),
      //         );
      //       },
      //     );
      //   },
      // ),
      GoRoute(
        path: '/design/:slug',
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) {
          final design = state.extra as DesignItem?;

          if (design == null) {
            // 🔐 Hard safety fallback
            return const MaterialPage(
              child: Scaffold(
                backgroundColor: Colors.black,
                body: Center(
                  child: Text(
                    'Design not found',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          }

          return CustomTransitionPage(
            key: state.pageKey,
            opaque: false,
            barrierDismissible: true,
            barrierColor: Colors.black.withValues(alpha: .85),
            transitionDuration: const Duration(milliseconds: 450),
            child: DesignDetailOverlay(data: design),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.08),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  ),
                  child: child,
                ),
              );
            },
          );
        },
      ),
    ],
  );
}
