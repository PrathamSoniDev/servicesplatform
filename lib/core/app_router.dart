import 'package:go_router/go_router.dart';
import 'package:servicesplatform/features/web/models/blog_model.dart';
import 'package:servicesplatform/features/web/presentation/about_us/about_screen.dart';
import 'package:servicesplatform/features/web/presentation/blog/blog_detail_screen.dart';
import 'package:servicesplatform/features/web/presentation/blog/blog_screen.dart';
import 'package:servicesplatform/features/web/presentation/contact_us/contact_us.dart';
import 'package:servicesplatform/features/web/presentation/home/homescreen.dart';
// Import your design screen here
import 'package:servicesplatform/features/web/presentation/designs/design_screen.dart'; 

class AppRouter {
  static const String root = '/';
  static const String home = '/home';
  static const String aboutUs = '/about';
  static const String blog = '/blog';
  static const String contact = '/contact';
  static const String designs = '/designs'; // Added Design Path constant

  final GoRouter router = GoRouter(
    initialLocation: root,
    debugLogDiagnostics: true, 
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
            path: ':id', 
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

      // DESIGN SCREEN ROUTE
      GoRoute(
        path: designs, 
        builder: (context, state) => const DesignScreen(),
      ),
    ],
  );
}