import 'package:flutter/material.dart';
import 'package:servicesplatform/core/app_router.dart';
import 'package:servicesplatform/core/theme/app_theme_builder.dart';
import 'package:servicesplatform/core/theme/app_theme_provider.dart';
import 'package:servicesplatform/services/theme_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ThemeRepository.getTheme(),
      builder: (context, snapshot) {
        // 🔹 FALLBACK TOKENS (SAFE DEFAULTS)
        final fallbackTokens = AppThemeTokens(
          colors: const {},
          fonts: const {},
        );

        // 🔄 LOADING
        if (snapshot.connectionState == ConnectionState.waiting) {
          return AppThemeProvider(
            tokens: fallbackTokens,
            child: const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                backgroundColor: Colors.black,
                body: Center(child: CircularProgressIndicator()),
              ),
            ),
          );
        }

        // ❌ ERROR
        if (snapshot.hasError || !snapshot.hasData) {
          return AppThemeProvider(
            tokens: fallbackTokens,
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: ThemeData.dark(useMaterial3: true),
              routerConfig: AppRouter().router,
            ),
          );
        }

        // ✅ SUCCESS
        final theme = snapshot.data!;

        return AppThemeProvider(
          tokens: AppThemeTokens(colors: theme.colors, fonts: theme.fonts),
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Devnex Services',
            theme: AppThemeBuilder.build(theme),
            routerConfig: AppRouter().router,
          ),
        );
      },
    );
  }
}
