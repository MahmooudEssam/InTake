import 'package:flutter/material.dart';
import 'package:intake/features/onboardingOne/presentation/onboardingOne.dart';
import 'features/auth/presentation/pages/signup_page.dart';
import 'features/splash_screen/splash_screen.dart';
import 'core/theme/theme.dart';
import 'features/onboardingTwo/presentation/onboardingTwo.dart';
import 'features/onboardingOne/presentation/onboardingOne.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InTake App',
      theme: AppTheme.darkThemeMode,
      home: const OnboardingScreen(),
    );
  }
}
