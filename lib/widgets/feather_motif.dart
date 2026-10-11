import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Simple peacock-feather "eye" made from concentric colour bands.
class FeatherMotif extends StatelessWidget {
  final double size;
  const FeatherMotif({super.key, this.size = 160});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppColors.background, AppColors.background,
            AppColors.tealLight, AppColors.tealLight,
            AppColors.gold, AppColors.gold,
            AppColors.navy, AppColors.navy,
            AppColors.teal, AppColors.teal,
          ],
          stops: [0, 0.14, 0.14, 0.30, 0.30, 0.38, 0.38, 0.56, 0.56, 1],
        ),
      ),
    );
  }
}
