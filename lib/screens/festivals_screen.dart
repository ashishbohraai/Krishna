import 'package:flutter/material.dart';
import '../data/festival_dates.dart';
import '../services/calendar_helper.dart';
import '../theme/app_theme.dart';
import '../widgets/feather_motif.dart';

class FestivalsScreen extends StatelessWidget {
  const FestivalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final featured = festivals.first;
    final others = festivals.skip(1).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Festivals')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              'Sacred days of Shri Krishna',
              style: TextStyle(fontSize: 13, color: AppColors.muted),
            ),
          ),
          _featured(context, featured),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'More festivals',
                style: headingStyle(18, color: AppColors.gold),
              ),
              const Text(
                'Tap the calendar to add',
                style: TextStyle(fontSize: 13, color: AppColors.muted),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final f in others)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _row(context, f),
            ),
          const SizedBox(height: 6),
          const Text(
            'Dates follow the North Indian (Delhi) calendar. Some temples and '
            'regions observe a festival a day earlier or later.',
            style: TextStyle(fontSize: 12, height: 1.4, color: AppColors.muted),
          ),
        ],
      ),
    );
  }

  Widget _featured(BuildContext context, Festival f) {
    final next = f.nextDate();
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.teal, AppColors.navy],
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
            right: -34,
            top: -34,
            child: FeatherMotif(size: 150),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'FEATURED',
                  style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 1.4,
                    color: Color(0xFFD9F0EE),
                  ),
                ),
                Text(f.name, style: headingStyle(26)),
                const SizedBox(height: 4),
                SizedBox(
                  width: 260,
                  child: Text(
                    f.subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.3,
                      color: Color(0xFFD9F0EE),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  next != null
                      ? 'Next: ${formatDate(next)}'
                      : 'More dates will be added in an update',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gold,
                  ),
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: next == null
                      ? null
                      : () => addFestivalToCalendar(context, f, next),
                  icon: const Icon(Icons.event_available),
                  label: const Text('Add to calendar'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    foregroundColor: AppColors.background,
                    minimumSize: const Size(0, 44),
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(BuildContext context, Festival f) {
    final next = f.nextDate();
    final hasDates = f.dates.isNotEmpty;
    final dateLine = hasDates
        ? (next != null
            ? 'Next: ${formatDate(next)}'
            : 'More dates will be added in an update')
        : f.frequencyNote;

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 6, 10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.background,
              border: Border.all(color: AppColors.gold),
            ),
            child: const Icon(
              Icons.celebration,
              size: 22,
              color: AppColors.gold,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  f.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  f.subtitle,
                  style: const TextStyle(
                    fontSize: 12.5,
                    height: 1.3,
                    color: AppColors.muted,
                  ),
                ),
                if (dateLine.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      dateLine,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.gold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (hasDates && next != null)
            IconButton(
              onPressed: () => addFestivalToCalendar(context, f, next),
              tooltip: 'Add ${f.name} to calendar',
              icon: const Icon(Icons.event_available, color: AppColors.gold),
            ),
        ],
      ),
    );
  }
}
