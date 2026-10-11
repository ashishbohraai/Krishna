import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Temporary page shown for sections that are not built yet.
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: headingStyle(28)),
            const SizedBox(height: 8),
            const Text(
              'Coming soon',
              style: TextStyle(color: AppColors.muted, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
