import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class InfoSection {
  final String? heading;
  final String body;
  const InfoSection(this.body, {this.heading});
}

class InfoScreen extends StatelessWidget {
  final String title;
  final List<InfoSection> sections;
  const InfoScreen({super.key, required this.title, required this.sections});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
        children: [
          for (final s in sections)
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (s.heading != null) ...[
                    Text(
                      s.heading!,
                      style: headingStyle(18, color: AppColors.gold),
                    ),
                    const SizedBox(height: 6),
                  ],
                  Text(
                    s.body,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.55,
                      color: Color(0xFFE4DDCE),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
