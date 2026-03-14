import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:servicesplatform/features/web/presentation/home/blog_screen.dart';
import 'package:servicesplatform/features/web/presentation/home/homescreen.dart';
import 'package:servicesplatform/features/web/presentation/home/new_contact_screen.dart';
import 'package:servicesplatform/features/web/presentation/home/product_screem.dart';
import 'package:servicesplatform/features/web/presentation/home/about_us_screen.dart'; // ✅ NEW

class AppRouter {
  AppRouter._();

  /// Root navigator
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  /// Route Paths
  static const String home = '/';
  static const String about = '/about'; // ✅ NEW
  static const String product = '/product';
  static const String blog = '/blog';
  static const String contact = '/contact';

  /// GoRouter Instance
  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: home,
    debugLogDiagnostics: true,
    routes: [

      /// HOME PAGE
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const Homescreen(),
      ),

      /// ABOUT PAGE
      GoRoute(
        path: about,
        name: 'about',
        builder: (context, state) => const AboutUsScreen(),
      ),

      /// PRODUCT PAGE
      GoRoute(
        path: product,
        name: 'product',
        builder: (context, state) => const ProductScreen(),
      ),

      /// BLOG PAGE
      GoRoute(
        path: blog,
        name: 'blog',
        builder: (context, state) => const BlogScreen(),
      ),

      /// CONTACT PAGE
      GoRoute(
        path: contact,
        name: 'contact',
        builder: (context, state) => const ContactScreen(),
      ),
    ],
  );
}