// import 'package:flutter/material.dart';
// import 'package:servicesplatform/core/app_router.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       debugShowCheckedModeBanner: false,
//       title: 'Devnex Services',
//       theme: ThemeData(
//         brightness: Brightness.dark,
//         scaffoldBackgroundColor: Colors.black,
//         useMaterial3: true,
//         textTheme: const TextTheme(
//           headlineLarge: TextStyle(
//             fontSize: 48,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//           bodyLarge: TextStyle(color: Colors.white70),
//         ),
//       ),
//       routerConfig: AppRouter().router,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:servicesplatform/core/app_router.dart';
import 'package:servicesplatform/core/theme/app_theme_builder.dart';
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
        // 🔄 Loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: Colors.black,
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Devnex Services',
            theme: ThemeData.dark(useMaterial3: true),
            routerConfig: AppRouter().router,
          );
        }
        final themeResponse = snapshot.data!;

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Devnex Services',
          theme: AppThemeBuilder.build(themeResponse),
          routerConfig: AppRouter().router,
        );
      },
    );
  }
}
