import 'package:flutter/material.dart';

import 'features/auth/presentation/pages/signup_page.dart';
import 'core/theme/theme.dart';

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
      home: const SignUpPage(),
    );
  }
}
