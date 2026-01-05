import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicesplatform/features/auth/auth_bloc.dart';
import 'package:servicesplatform/services/auth_repository.dart';

import 'core/app_router.dart';
import 'core/bootstrap/app_bootstrap_repository.dart';
import 'core/bootstrap/bloc/app_bootstrap_bloc.dart';
import 'core/bootstrap/bloc/app_bootstrap_event.dart';
import 'core/bootstrap/bloc/app_bootstrap_state.dart';
import 'core/theme/app_theme_builder.dart';
import 'core/theme/app_theme_provider.dart';
import 'features/web/presentation/home/custom_shimmer.dart';
import 'services/hero_repository.dart';
import 'services/theme_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(AuthRepository())),
        BlocProvider(
          create:
              (_) => AppBootstrapBloc(
                AppBootstrapRepository(
                  themeRepository: ThemeRepository(),
                  heroRepository: HeroRepository(),
                  authRepository: AuthRepository(),
                ),
              )..add(LoadAppBootstrap()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBootstrapBloc, AppBootstrapState>(
      builder: (context, state) {
        // ───────────────── FALLBACK TOKENS ─────────────────
        final fallbackTokens = AppThemeTokens(
          colors: const {},
          fonts: const {},
        );

        // ───────────────── LOADING ─────────────────
        if (state.status == AppBootstrapStatus.loading ||
            state.status == AppBootstrapStatus.initial) {
          return AppThemeProvider(
            tokens: fallbackTokens,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: const Scaffold(
                backgroundColor: Colors.black,
                body: Center(
                  child: AdaptiveShimmer(layout: ShimmerLayout.hero),
                ),
              ),
            ),
          );
        }

        // ───────────────── ERROR ─────────────────
        if (state.status == AppBootstrapStatus.failure || state.data == null) {
          return AppThemeProvider(
            tokens: fallbackTokens,
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: ThemeData.dark(useMaterial3: true),
              routerConfig: AppRouter().router,
            ),
          );
        }

        // ───────────────── SUCCESS ─────────────────
        final theme = state.data!.theme;

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
