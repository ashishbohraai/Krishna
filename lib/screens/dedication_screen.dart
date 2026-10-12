import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/feather_motif.dart';

/// To show your father's name, put it between the quotes below,
/// for example: 'Shri Ramesh Kumar'. Leave it as '' to hide the name line.
const dedicatedToName = 'Late Shri Champalal Bohra';

class DedicationScreen extends StatelessWidget {
  const DedicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dedication')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const FeatherMotif(size: 150),
                const SizedBox(height: 28),
                Text(
                  'ॐ नमो भगवते वासुदेवाय',
                  textAlign: TextAlign.center,
                  style: headingStyle(20, color: AppColors.gold),
                ),
                const SizedBox(height: 22),
                Text(
                  'In loving memory of my father',
                  textAlign: TextAlign.center,
                  style: headingStyle(26),
                ),
                if (dedicatedToName.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Text(
                    dedicatedToName,
                    textAlign: TextAlign.center,
                    style: headingStyle(22, color: AppColors.gold),
                  ),
                ],
                const SizedBox(height: 22),
                const Text(
                  'He was a devoted follower of Shri Krishna. This app is '
                  'dedicated to him, with love and gratitude for the faith '
                  'he lived by and shared.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: Color(0xFFE4DDCE),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'May this offering carry his blessings to everyone '
                  'who opens it.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    fontStyle: FontStyle.italic,
                    color: AppColors.muted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
