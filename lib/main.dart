import 'package:flutter/material.dart';
import 'package:seo_renderer/seo_renderer.dart';
import 'core/app_router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  runApp(
    const SeoRoot( // ✅ move here
      child: MyApp(),
    ),
  );
}

/// ===============================
/// SEO ROOT WRAPPER (GLOBAL)
/// ===============================
class SeoRoot extends StatelessWidget {
  final Widget child;

  const SeoRoot({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return RobotDetector(
      child: child,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      /// 🔥 IMPORTANT FOR SEO
      title: 'Sell Tech IND. Productions | Best Flutter Developer in India',

      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
      ),

      routerConfig: AppRouter.router,
    );
  }
}