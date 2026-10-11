import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/feather_motif.dart';

class _Festival {
  final String title;
  final String subtitle;
  const _Festival(this.title, this.subtitle);
}

const _festivals = [
  _Festival('Radhashtami', 'Birth of Radha, about two weeks after Janmashtami'),
  _Festival('Govardhan Puja', 'The day after Diwali, honouring the Govardhan lila'),
  _Festival('Holi', 'Spring full moon, colours and the story of Radha and Krishna'),
  _Festival('Gita Jayanti', 'Marks the day the Gita was spoken at Kurukshetra'),
  _Festival('Ekadashi', 'The 11th lunar day, observed twice a month with fasting and prayer'),
];

class FestivalsScreen extends StatefulWidget {
  const FestivalsScreen({super.key});

  @override
  State<FestivalsScreen> createState() => _FestivalsScreenState();
}

class _FestivalsScreenState extends State<FestivalsScreen> {
  final Set<int> _reminders = {};

  void _showSoon() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Reminders will be switched on in a later update'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          _featured(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'More festivals',
                style: headingStyle(18, color: AppColors.gold),
              ),
              const Text(
                'Tap the bell for reminders',
                style: TextStyle(fontSize: 13, color: AppColors.muted),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (var i = 0; i < _festivals.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _row(i),
            ),
        ],
      ),
    );
  }

  Widget _featured() {
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
                Text('Janmashtami', style: headingStyle(26)),
                const SizedBox(height: 4),
                const SizedBox(
                  width: 260,
                  child: Text(
                    'Celebrating the midnight birth of Shri Krishna. The date updates every year.',
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.3,
                      color: Color(0xFFD9F0EE),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: _showSoon,
                  icon: const Icon(Icons.notifications_none),
                  label: const Text('Set reminder'),
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

  Widget _row(int i) {
    final f = _festivals[i];
    final on = _reminders.contains(i);
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
                  f.title,
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
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                if (on) {
                  _reminders.remove(i);
                } else {
                  _reminders.add(i);
                }
              });
              if (!on) _showSoon();
            },
            tooltip: 'Toggle reminder for ${f.title}',
            icon: Icon(
              on ? Icons.notifications_active : Icons.notifications_none,
              color: on ? AppColors.gold : AppColors.muted,
            ),
          ),
        ],
      ),
    );
  }
}
