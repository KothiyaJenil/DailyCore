  import 'package:dailycore/core/constants/App_Colors.dart';
import 'package:dailycore/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primary,
          secondary: AppColors.accent,
          error: AppColors.error,
          surface: AppColors.surface,
          onPrimary: AppColors.onPrimary,
          onSecondary: AppColors.accentLight,
          onError: AppColors.onError,
          onSurface: AppColors.onSurface,
        ),
      ),
      home: SplashScreen(),
    );
  }
}
