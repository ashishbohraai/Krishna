import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/feather_motif.dart';
import 'placeholder_screen.dart';

const _chapters = [
  "Arjuna's Dilemma",
  "Sankhya Yoga",
  "Karma Yoga",
  "Wisdom & Action",
  "Renunciation",
  "Meditation",
  "Knowledge & Wisdom",
  "The Imperishable",
  "Royal Knowledge",
  "Divine Glories",
  "Universal Form",
  "Devotion",
  "Field & Knower",
  "Three Gunas",
  "Supreme Person",
  "Divine & Demonic",
  "Three Faiths",
  "Liberation",
];

class GitaScreen extends StatelessWidget {
  const GitaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bhagavad Gita')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              '18 chapters of timeless guidance',
              style: TextStyle(fontSize: 13, color: AppColors.muted),
            ),
          ),
          _verseCard(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Chapters', style: headingStyle(18, color: AppColors.gold)),
              const Text(
                'Tap to open',
                style: TextStyle(fontSize: 13, color: AppColors.muted),
              ),
            ],
          ),
          const SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.25,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              for (var i = 0; i < _chapters.length; i++) _tile(context, i),
            ],
          ),
        ],
      ),
    );
  }

  Widget _verseCard() {
    return Container(
      height: 120,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.teal, AppColors.navy],
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
            right: -26,
            top: -26,
            child: FeatherMotif(size: 120),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'VERSE OF THE DAY',
                  style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 1.4,
                    color: Color(0xFFD9F0EE),
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: 260,
                  child: Text(
                    'कर्मण्येवाधिकारस्ते मा फलेषु कदाचन',
                    style: headingStyle(17),
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Chapter 2 · Verse 47',
                  style: TextStyle(fontSize: 12, color: Color(0xFFD9F0EE)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile(BuildContext context, int i) {
    return Material(
      color: AppColors.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PlaceholderScreen(title: 'Chapter ${i + 1}'),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${i + 1}', style: headingStyle(22, color: AppColors.gold)),
              Text(
                _chapters[i],
                style: const TextStyle(fontSize: 13, height: 1.2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
