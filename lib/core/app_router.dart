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

    routes: [
      GoRoute(path: root, redirect: (_, __) => home),

      GoRoute(path: home, builder: (context, state) => const HomeScreen()),

      GoRoute(path: aboutUs, builder: (context, state) => const AboutScreen()),

      GoRoute(
        path: blog,
        builder: (context, state) => const BlogScreen(),
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final blog = state.extra as BlogModel?;
              return BlogDetailScreen(blog: blog);
            },
          ),
        ],
      ),

      GoRoute(path: contact, builder: (context, state) => const ContactUs()),
    ],
  );
}
