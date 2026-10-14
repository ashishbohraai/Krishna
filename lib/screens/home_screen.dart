import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/feather_motif.dart';
import 'dedication_screen.dart';
import 'festivals_screen.dart';
import 'gita_screen.dart';
import 'leelas_screen.dart';
import 'mantras_screen.dart';
import 'more_screen.dart';
import 'placeholder_screen.dart';
import 'places_screen.dart';
import 'saved_screen.dart';
import 'search_screen.dart';
import 'timeline_screen.dart';

class _HomeTile {
  final String title;
  final String subtitle;
  final IconData icon;
  const _HomeTile(this.title, this.subtitle, this.icon);
}

const _tiles = [
  _HomeTile('Life Timeline', 'Birth to Dwarka', Icons.timeline),
  _HomeTile('Leelas', 'Stories of Krishna', Icons.auto_stories),
  _HomeTile('Bhagavad Gita', '18 chapters', Icons.menu_book),
  _HomeTile('Festivals', 'Janmashtami & more', Icons.celebration),
  _HomeTile('Sacred Places', 'Mathura to Dwarka', Icons.place),
  _HomeTile('Mantras', 'Listen & chant', Icons.music_note),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _open(BuildContext context, String title) {
    Widget page;
    if (title == 'Leelas') {
      page = const LeelasScreen();
    } else if (title == 'Life Timeline') {
      page = const TimelineScreen();
    } else if (title == 'Bhagavad Gita') {
      page = const GitaScreen();
    } else if (title == 'Festivals') {
      page = const FestivalsScreen();
    } else if (title == 'Sacred Places') {
      page = const PlacesScreen();
    } else if (title == 'Mantras') {
      page = const MantrasScreen();
    } else {
      page = PlaceholderScreen(title: title);
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  void _openDedication(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const DedicationScreen()),
    );
  }

  void _onTab(BuildContext context, int index) {
    if (index == 1) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const SavedScreen()),
      );
    } else if (index == 2) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const SearchScreen()),
      );
    } else if (index == 3) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const MoreScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          children: [
            _header(),
            const SizedBox(height: 16),
            _verseCard(context),
            const SizedBox(height: 20),
            Text('Explore', style: headingStyle(18, color: AppColors.gold)),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 1.35,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                for (final t in _tiles) _tile(context, t),
              ],
            ),
            const SizedBox(height: 18),
            _dedicationCard(context),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (i) => _onTab(context, i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.favorite_border), label: 'Saved'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.menu), label: 'More'),
        ],
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'जय श्री कृष्ण',
              style: TextStyle(color: AppColors.gold, fontSize: 14),
            ),
            Text('Shri Krishna', style: headingStyle(28)),
          ],
        ),
        IconButton.outlined(
          onPressed: () {},
          tooltip: 'Settings',
          icon: const Icon(Icons.settings_outlined),
          style: IconButton.styleFrom(
            backgroundColor: AppColors.card,
            side: const BorderSide(color: AppColors.border),
            fixedSize: const Size(44, 44),
          ),
        ),
      ],
    );
  }

  Widget _verseCard(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () => _open(context, 'Bhagavad Gita'),
      child: Container(
        height: 176,
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
              child: FeatherMotif(size: 170),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
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
                  const SizedBox(height: 6),
                  SizedBox(
                    width: 250,
                    child: Text(
                      'कर्मण्येवाधिकारस्ते मा फलेषु कदाचन',
                      style: headingStyle(20),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Bhagavad Gita 2.47 · Tap to read',
                    style: TextStyle(fontSize: 13, color: Color(0xFFD9F0EE)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tile(BuildContext context, _HomeTile t) {
    return Material(
      color: AppColors.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => _open(context, t.title),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(t.icon, size: 30, color: AppColors.gold),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    t.subtitle,
                    style: const TextStyle(fontSize: 13, color: AppColors.muted),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dedicationCard(BuildContext context) {
    return Material(
      color: AppColors.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _openDedication(context),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              Icon(Icons.local_florist, size: 26, color: AppColors.gold),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'In loving memory',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'A dedication to my father',
                      style: TextStyle(fontSize: 13, color: AppColors.muted),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: AppColors.muted),
            ],
          ),
        ),
      ),
    );
  }
}
