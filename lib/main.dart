import 'package:facebook_replication/constants.dart';
import 'package:facebook_replication/providers/theme_provider.dart';
import 'package:facebook_replication/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(const CCITBookApp());

class CCITBookApp extends StatefulWidget {
  const CCITBookApp({super.key});

  @override
  State<CCITBookApp> createState() => _CCITBookAppState();
}

class _CCITBookAppState extends State<CCITBookApp> {
  final _themeProvider = ThemeProvider.instance;

  @override
  void initState() {
    super.initState();
    _themeProvider.load();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _themeProvider,
      builder: (context, _) => ScreenUtilInit(
        designSize: const Size(412, 715),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: APP_NAME,
            theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: APP_PRIMARY,
              scaffoldBackgroundColor: const Color(0xFFF5F7FA),
              cardColor: Colors.white,
              colorScheme: ColorScheme.fromSeed(
                seedColor: APP_PRIMARY,
                brightness: Brightness.light,
              ),
              useMaterial3: false,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: APP_SECONDARY,
              scaffoldBackgroundColor: const Color(0xFF121820),
              cardColor: const Color(0xFF1E2732),
              colorScheme: ColorScheme.fromSeed(
                seedColor: APP_SECONDARY,
                brightness: Brightness.dark,
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF1E2732),
                foregroundColor: Colors.white,
              ),
              useMaterial3: false,
            ),
            themeMode: _themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
            home: const SplashScreen(),
          ); // MaterialApp
        },
      ),
    ); // ScreenUtilInit
  }
}
