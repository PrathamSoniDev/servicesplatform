import 'package:go_router/go_router.dart';
import 'package:servicesplatform/features/web/presentation/about_us/about_screen.dart';
import 'package:servicesplatform/features/web/presentation/blog/blog_detail_screen.dart';
import 'package:servicesplatform/features/web/presentation/blog/blog_screen.dart';
import 'package:servicesplatform/features/web/presentation/contact_us/contact_us.dart';
// Import your design screen here
import 'package:servicesplatform/features/web/presentation/designs/design_screen.dart';
import 'package:servicesplatform/features/web/presentation/home/homescreen.dart';
import 'package:servicesplatform/features/web/presentation/profile/profile_screen.dart';

import '../models/blog_model.dart';

class AppRouter {
  static const String home = '/';
  static const String aboutUs = '/about';
  static const String blog = '/blog';
  static const String contact = '/contact';
  static const String designs = '/designs'; // Added Design Path constant
  static const String profile = '/profile';

  final GoRouter router = GoRouter(
    initialLocation: home,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: home,
        name: home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: aboutUs,
        name: aboutUs,
        builder: (context, state) => const AboutScreen(),
      ),

      // BLOG PARENT ROUTE
      GoRoute(
        path: blog,
        name: blog,
        builder: (context, state) => const BlogScreen(),
        routes: [
          // BLOG DETAIL CHILD ROUTE
          GoRoute(
            path: ':id',
            name: ':id',
            builder: (context, state) {
              final id = state.pathParameters['id'];
              final blogModel = state.extra as BlogModel?;

              return BlogDetailScreen(id: id, blog: blogModel);
            },
          ),
        ],
      ),

      GoRoute(
        path: contact,
        name: contact,
        builder: (context, state) => const ContactUs(),
      ),

      GoRoute(
        path: profile,
        name: profile,
        builder: (context, state) => const ProfileScreen(),
      ),

      // DESIGN SCREEN ROUTE
      GoRoute(
        path: designs,
        name: designs,
        builder: (context, state) => const DesignScreen(),
      ),
    ],
  );
}
