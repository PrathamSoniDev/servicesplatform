import 'package:go_router/go_router.dart';
import 'package:servicesplatform/features/web/presentation/about_us/about_screen.dart';
import 'package:servicesplatform/features/web/presentation/home/homescreen.dart';

class AppRouter {
  static const String home = '/home';
  static const String aboutUs = '/about';
  final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(path: home, builder: (context, state) => const HomeScreen()),
      GoRoute(path: aboutUs, builder: (context, state) => const AboutScreen()),
    ],
  );
}
