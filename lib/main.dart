// ignore_for_file: use_build_context_synchronously

import 'package:dynamik_theme/dynamik_theme.dart';
import 'package:hkjc_updater/pages/apk_install.dart';
import 'package:hkjc_updater/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hkjc_updater/pages/settings.dart';
import 'package:hkjc_updater/pages/update.dart';
import 'package:hkjc_updater/pages/update_complete.dart';
import 'package:spookyservices/theme/colors.dart' as theme;
import 'package:spookyservices/theme/RouteDesign.dart';

// Define the snackbarKey for ScaffoldMessenger
// final GlobalKey<ScaffoldMessengerState> snackbarKey =
//     GlobalKey<ScaffoldMessengerState>();

final Map<String, ShellConfig> routeConfig = {
  '/': ShellConfig(
    title: "馬會App更新助手",
    icon: Icons.home,
    actions: [
      ShellAction(icon: Icons.settings, onPressed: (context) => context.push('/settings')),
    ],
  ),
  '/updateComplete': ShellConfig(
    title: "下載/更新應用程式",
    icon: Icons.system_update,
    isLocked: true, // Specific Webview Logic
  ),
  '/update': ShellConfig(
    title: "下載/更新應用程式",
    icon: Icons.system_update,
    isLocked: true, // Specific Webview Logic
  ),
  '/apkInstall': ShellConfig(
    title: "下載/更新應用程式",
    icon: Icons.system_update,
    isLocked: true, // Specific Webview Logic
  ),
  '/settings': ShellConfig(
    title: "設定",
    icon: Icons.settings,
  ),
};

final router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return AppShell(
          state: state,
          routeConfig: routeConfig, // <--- Injecting the config
          child: child, 
        );
      },
      routes: [
        GoRoute(path: '/', builder: (context, state) => HomePage()),
        GoRoute(
          path: '/update',
          pageBuilder: (context, state) => buildPageWithTransition(
            context: context, 
            state: state, 
            routeConfig: routeConfig,
            child: UpdatePage(),
          ),
          
          // pageBuilder: GoTransitions.cupertino.call,
        ),
        GoRoute(
          path: '/updateComplete',
          pageBuilder: (context, state) => buildPageWithTransition(
            context: context, 
            state: state, 
            routeConfig: routeConfig,
            child: UpdateCompletePage(),
          ),
          // pageBuilder: GoTransitions.cupertino.call,
        ),
        GoRoute(
          path: '/settings',
          pageBuilder: (context, state) => buildPageWithTransition(
            context: context, 
            state: state, 
            routeConfig: routeConfig,
            child: SettingsPage(),
          ),
          // pageBuilder: GoTransitions.cupertino.call,
        ),
        GoRoute(
          path: '/apkInstall',
          pageBuilder: (context, state) => buildPageWithTransition(
            context: context, 
            state: state, 
            routeConfig: routeConfig,
            child: ApkInstallPage(),
          ),
          // pageBuilder: GoTransitions.cupertino.call,
        ),
      ],
    ),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
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
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: <TargetPlatform, PageTransitionsBuilder>{
                // Set the predictive back transitions for Android.
                TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
                TargetPlatform.linux: ZoomPageTransitionsBuilder(),
                TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
                TargetPlatform.macOS: ZoomPageTransitionsBuilder(),
              },
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
