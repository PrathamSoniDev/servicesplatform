import 'package:go_router/go_router.dart';
import 'package:servicesplatform/features/web/models/blog_model.dart';
import 'package:servicesplatform/features/web/presentation/about_us/about_screen.dart';
import 'package:servicesplatform/features/web/presentation/blog/blog_screen.dart';
import 'package:servicesplatform/features/web/presentation/blog/blog_detail_screen.dart';
import 'package:servicesplatform/features/web/presentation/home/homescreen.dart';

class AppRouter {
  static const String home = '/home';
  static const String aboutUs = '/about';
  static const String blog = '/blog';
  static const String blogDetail = '/blog/:id';

  final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(path: home, builder: (context, state) => const HomeScreen()),
      GoRoute(path: aboutUs, builder: (context, state) => const AboutScreen()),
      GoRoute(
        path: blog,
        builder: (context, state) => const BlogScreen(),
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) {
              // Extract the blog object passed through 'extra'
              final blog = state.extra as BlogModel?;
              return BlogDetailScreen(blog: blog);
            },
          ),
        ],
      ),
    ],
  );
}