import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/features/web/presentation/home/all_product_screen.dart';

/// SCREENS
import 'package:servicesplatform/features/web/presentation/home/homescreen.dart';
import 'package:servicesplatform/features/web/presentation/home/about_us_screen.dart';
import 'package:servicesplatform/features/web/presentation/home/new_contact_screen.dart';

/// PRODUCT
import 'package:servicesplatform/features/web/presentation/home/product_screem.dart';
import 'package:servicesplatform/features/web/presentation/home/product_detail_screen.dart';
// 👉 (create if not present)

/// BLOG
import 'package:servicesplatform/features/web/presentation/home/blog_screen.dart';
import 'package:servicesplatform/features/web/presentation/home/blog_detail_screen.dart';
import 'package:servicesplatform/features/web/presentation/home/all_blog_screen.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  /// ================= ROUTE PATHS =================

  static const String home = '/';
  static const String about = '/about';

  /// PRODUCT
  static const String product = '/product';
  static const String productAll = '/product/all';
  static const String productDetail = '/product/detail/:type';

  /// BLOG
  static const String blog = '/blog';
  static const String blogAll = '/blog/all';
  static const String blogDetail = '/blog/detail/:title';

  static const String contact = '/contact';

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: home,
    debugLogDiagnostics: true,

    routes: [

      /// ================= HOME =================
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const Homescreen(),
      ),

      /// ================= ABOUT =================
      GoRoute(
        path: about,
        name: 'about',
        builder: (context, state) => const AboutUsScreen(),
      ),

      // ============================================================
      // ======================= PRODUCT ============================
      // ============================================================

      /// PRODUCT LIST
      GoRoute(
        path: product,
        name: 'product',
        builder: (context, state) => const ProductScreen(),
      ),

      /// ALL PRODUCTS
      GoRoute(
        path: productAll,
        name: 'allProducts',
        builder: (context, state) => const AllProductScreen(),
      ),

      /// PRODUCT DETAIL
      GoRoute(
        path: productDetail,
        name: 'productDetail',
        pageBuilder: (context, state) {
          final type = state.pathParameters['type'];

          return CustomTransitionPage(
            key: state.pageKey,
            child: ProductDetailScreen(
              isDeveloper: type == 'developer',
            ),
            transitionsBuilder: (context, animation, _, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      // ============================================================
      // ======================== BLOG ==============================
      // ============================================================

      /// BLOG PREVIEW (HOME SECTION)
      GoRoute(
        path: blog,
        name: 'blog',
        builder: (context, state) => const BlogScreen(),
      ),

      /// ALL BLOGS
      GoRoute(
        path: blogAll,
        name: 'allBlogs',
        builder: (context, state) => const AllBlogsScreen(),
      ),

      /// BLOG DETAIL
      GoRoute(
        path: blogDetail,
        name: 'blogDetail',
        pageBuilder: (context, state) {
          final rawTitle = state.pathParameters['title'] ?? '';
          final title = Uri.decodeComponent(rawTitle).replaceAll('-', ' ');

          final category = Uri.decodeComponent(
            state.uri.queryParameters['category'] ?? '',
          );

          return CustomTransitionPage(
            key: state.pageKey,
            child: BlogDetailScreen(
              title: title,
              category: category,
            ),
            transitionsBuilder: (context, animation, _, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
      ),

      /// ================= CONTACT =================
      GoRoute(
        path: contact,
        name: 'contact',
        builder: (context, state) => const ContactScreen(),
      ),
    ],
  );
}