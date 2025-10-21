import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/color_constants.dart';
import 'package:flutter_dashboard/features/presentation/view/pages/dashboard_page.dart';
import 'package:flutter_dashboard/features/presentation/view/pages/sign_in_page.dart';

void main() {
  runApp(const MyApp());
}

// ==================== MAIN APP ====================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modern Admin Dashboard (Static UI)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: ColorConstants.primaryPurple,
        scaffoldBackgroundColor: ColorConstants.lightGray,
        fontFamily: 'Exo',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
        ),
      ),
      home: SignInPage(),
    );
  }
}
