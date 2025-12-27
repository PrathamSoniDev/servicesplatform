import 'package:go_router/go_router.dart';
import 'package:servicesplatform/features/web/presentation/about_us/about_screen.dart';
import 'package:servicesplatform/features/web/presentation/blog/blog_screen.dart';
import 'package:servicesplatform/features/web/presentation/contact_us/contact_us.dart';
import 'package:servicesplatform/features/web/presentation/home/homescreen.dart';

class AppRouter {
  static const String home = '/home';
  static const String aboutUs = '/about';
  static const String blog = '/blog';
  static const String contact = '/contact';
  final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(path: home, builder: (context, state) => const HomeScreen()),
      GoRoute(path: aboutUs, builder: (context, state) => const AboutScreen()),
      GoRoute(path: blog, builder: (context, state) => const BlogScreen()),
      GoRoute(path: contact, builder: (context, state) => const ContactUs()),
    ],
  );
}
