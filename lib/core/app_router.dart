
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/features/web/models/blog_model.dart';
import 'package:servicesplatform/features/web/presentation/about_us/about_screen.dart';
import 'package:servicesplatform/features/web/presentation/blog/blog_detail_screen.dart';
import 'package:servicesplatform/features/web/presentation/blog/blog_screen.dart';
import 'package:servicesplatform/features/web/presentation/contact_us/contact_us.dart';
import 'package:servicesplatform/features/web/presentation/home/homescreen.dart';

class AppRouter {
  static const String root = '/';
  static const String home = '/home';
  static const String aboutUs = '/about';
  static const String blog = '/blog';
  static const String contact = '/contact';

  final GoRouter router = GoRouter(
    initialLocation: root,
    debugLogDiagnostics: true, // Helps you see routing errors in the console
    routes: [
      GoRoute(path: root, redirect: (_, __) => home),
      GoRoute(path: home, builder: (context, state) => const HomeScreen()),
      GoRoute(path: aboutUs, builder: (context, state) => const AboutScreen()),
      
      // BLOG PARENT ROUTE
      GoRoute(
        path: blog,
        builder: (context, state) => const BlogScreen(),
        routes: [
          // BLOG DETAIL CHILD ROUTE
          GoRoute(
            path: ':id', // This results in /blog/123
            builder: (context, state) {
              final id = state.pathParameters['id'];
              final blogModel = state.extra as BlogModel?;
              
              return BlogDetailScreen(
                id: id, 
                blog: blogModel,
              );
            },
          ),
        ],
      ),

      GoRoute(path: contact, builder: (context, state) => const ContactUs()),
    ],
  );
}