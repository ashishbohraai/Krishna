import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const KrishnaApp());
}

class KrishnaApp extends StatelessWidget {
  const KrishnaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shri Krishna',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const HomeScreen(),
    );
  }
}
