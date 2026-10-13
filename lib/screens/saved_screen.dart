import 'package:flutter/material.dart';
import '../data/gita_chapters.dart';
import '../data/leelas.dart';
import '../services/saved_store.dart';
import '../theme/app_theme.dart';
import 'gita_chapter_screen.dart';
import 'story_screen.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = SavedStore.instance;
    return Scaffold(
      appBar: AppBar(title: const Text('Saved')),
      body: ListenableBuilder(
        listenable: store,
        builder: (context, _) {
          final stories = store
              .indexesOf('leela')
              .where((i) => i < leelas.length)
              .toList();
          final chapters = store
              .indexesOf('gita')
              .where((i) => i < gitaChapters.length)
              .toList();

          if (stories.isEmpty && chapters.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'Nothing saved yet.\n'
                  'Tap the heart on a story or a Gita chapter to keep it here.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: AppColors.muted,
                  ),
                ),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            children: [
              if (stories.isNotEmpty) ...[
                _heading('Stories'),
                for (final i in stories)
                  _card(
                    context,
                    label: 'LEELA · ${leelas[i].place.toUpperCase()}',
                    title: leelas[i].title,
                    subtitle: leelas[i].subtitle,
                    onOpen: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => StoryScreen(index: i)),
                    ),
                    onRemove: () => store.toggle('leela:$i'),
                  ),
              ],
              if (chapters.isNotEmpty) ...[
                _heading('Gita chapters'),
                for (final i in chapters)
                  _card(
                    context,
                    label: 'GITA · CHAPTER ${i + 1}',
                    title: gitaChapters[i].name,
                    subtitle: gitaChapters[i].keyIdea,
                    onOpen: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => GitaChapterScreen(index: i),
                      ),
                    ),
                    onRemove: () => store.toggle('gita:$i'),
                  ),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _heading(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 10),
      child: Text(text, style: headingStyle(18, color: AppColors.gold)),
    );
  }

  Widget _card(
    BuildContext context, {
    required String label,
    required String title,
    required String subtitle,
    required VoidCallback onOpen,
    required VoidCallback onRemove,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: AppColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onOpen,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 6, 12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          fontSize: 12,
                          letterSpacing: 1.2,
                          color: AppColors.gold,
                        ),
                      ),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.muted,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onRemove,
                  tooltip: 'Remove from Saved',
                  icon: const Icon(Icons.favorite, color: AppColors.gold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
