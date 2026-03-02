import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../routes/routes_imports.dart';
import 'theme/app_colors.dart';

// Global scaffold messenger key for app-wide toasts/snackbars
final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter(navigatorKey: navigatorKey);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return ThemeProvider(
          initTheme: lightTheme(context),
          child: Builder(
            builder: (context) {
              final theme = ThemeModelInheritedNotifier.of(context).theme;
              final isLightTheme = theme.brightness == Brightness.light;

              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                  statusBarIconBrightness: isLightTheme
                      ? Brightness.dark
                      : Brightness.light,
                  statusBarBrightness: isLightTheme
                      ? Brightness.light
                      : Brightness.dark,
                  statusBarColor: Colors.transparent,
                ),
                child: GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: ThemeSwitcher(
                    builder: (context) => MaterialApp.router(
                      theme: theme,

                      // theme: ThemeData(

                      //   pageTransitionsTheme: PageTransitionsTheme(
                      //     builders: {
                      //       TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                      //       TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                      //     },
                      //   ),
                      // ),
                      title: 'Fennac App',
                      debugShowCheckedModeBanner: false,
                      scaffoldMessengerKey: snackbarKey,
                      routerConfig: _appRouter.config(),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
