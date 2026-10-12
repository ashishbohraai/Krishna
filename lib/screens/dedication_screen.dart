import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/feather_motif.dart';

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
                _photo(),
                const SizedBox(height: 26),
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

  Widget _photo() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.gold, width: 3),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(17),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 340),
          child: Image.asset(
            'father_photo.jpg',
            width: 240,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                const FeatherMotif(size: 170),
          ),
        ),
      ),
    );
  }
}
