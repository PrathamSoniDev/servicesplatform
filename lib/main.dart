import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app_router.dart';
import 'core/bootstrap/app_bootstrap_repository.dart';
import 'core/bootstrap/bloc/app_bootstrap_bloc.dart';
import 'core/bootstrap/bloc/app_bootstrap_event.dart';
import 'core/bootstrap/bloc/app_bootstrap_state.dart';
import 'core/theme/app_theme_builder.dart';
import 'core/theme/app_theme_provider.dart';
import 'features/auth/auth_bloc.dart';
import 'features/web/presentation/designs/bloc/designs_bloc.dart';
import 'features/web/presentation/home/custom_shimmer.dart';
import 'services/auth_repository.dart';
import 'services/blog_repository.dart';
import 'services/design_repository.dart';
import 'services/hero_repository.dart';
import 'services/theme_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // ───────────────── SINGLETON REPOSITORIES ─────────────────
  final themeRepository = ThemeRepository();
  final heroRepository = HeroRepository();
  final authRepository = AuthRepository();
  final designRepository = DesignRepository();
  final blogRepository = BlogRepository();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: themeRepository),
        RepositoryProvider.value(value: heroRepository),
        RepositoryProvider.value(value: authRepository),
        RepositoryProvider.value(value: designRepository),
        RepositoryProvider.value(value: blogRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          // ───────────── APP BOOTSTRAP ─────────────
          BlocProvider(
            create:
                (_) => AppBootstrapBloc(
                  AppBootstrapRepository(
                    themeRepository: themeRepository,
                    heroRepository: heroRepository,
                    authRepository: authRepository,
                    designRepository: designRepository,
                    blogRepository: blogRepository,
                  ),
                )..add(LoadAppBootstrap()),
          ),

          // ───────────── AUTH ─────────────
          BlocProvider(create: (_) => AuthBloc(authRepository)),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBootstrapBloc, AppBootstrapState>(
      builder: (context, state) {
        // ───────────────── FALLBACK THEME ─────────────────
        final fallbackTokens = AppThemeTokens(
          colors: const {},
          fonts: const {},
        );

        // ───────────────── LOADING ─────────────────
        if (state.status == AppBootstrapStatus.initial ||
            state.status == AppBootstrapStatus.loading) {
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

        // ───────────────── FAILURE ─────────────────
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
        final bootstrapData = state.data!;
        final theme = bootstrapData.theme;

        return AppThemeProvider(
          tokens: AppThemeTokens(colors: theme.colors, fonts: theme.fonts),
          child: MultiBlocProvider(
            providers: [
              // ───────────── DESIGNS BLOC (HYDRATED) ─────────────
              BlocProvider(
                create:
                    (_) => DesignsBloc(
                      context.read<DesignRepository>(),
                      initialDesigns: bootstrapData.designs?.items,
                    ),
              ),
            ],
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Devnex Services',
              theme: AppThemeBuilder.build(theme),
              routerConfig: AppRouter().router,
            ),
          ),
        );
      },
    );
  }
}
