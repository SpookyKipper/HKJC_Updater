// ignore_for_file: use_build_context_synchronously

import 'package:dynamik_theme/dynamik_theme.dart';
import 'package:flow_by_spooky_services/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:go_router/go_router.dart';
import 'package:go_transitions/go_transitions.dart';

import 'package:spookyservices/theme/colors.dart' as theme;

// Define the snackbarKey for ScaffoldMessenger
// final GlobalKey<ScaffoldMessengerState> snackbarKey =
//     GlobalKey<ScaffoldMessengerState>();

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
      pageBuilder: GoTransitions.cupertino.call,
    ),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Phoenix(child: MyApp()));
}

bool isDarkMode(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamikTheme(
      config: ThemeConfig(
        useMaterial3: true,
        // You can also generate color schemes from:
        // https://m3.material.io/theme-builder#/custom
        lightScheme: theme.MaterialTheme.lightScheme(),
        darkScheme: theme.MaterialTheme.darkScheme(),
        defaultThemeState: ThemeState(
          themeMode: ThemeMode.system,
          colorMode: ColorMode.custom,
        ),
        builder: (themeData) {
          // Add more customization on ThemeData.
          return themeData.copyWith(
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(),
            ),
          );
        },
      ),
      builder: (theme, darkTheme, themeMode) {
        return MaterialApp.router(
          themeMode: themeMode,
          theme: theme,
          darkTheme: darkTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        );
      },
    );
  }
}

