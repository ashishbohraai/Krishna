import 'package:flutter/material.dart';
import '../data/gita_chapters.dart';
import '../data/leelas.dart';
import '../theme/app_theme.dart';
import 'gita_chapter_screen.dart';
import 'story_screen.dart';

class _Result {
  final String label;
  final String title;
  final String subtitle;
  final Widget Function() page;
  _Result(this.label, this.title, this.subtitle, this.page);
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<_Result> _search(String q) {
    final needle = q.trim().toLowerCase();
    if (needle.isEmpty) return [];
    final results = <_Result>[];

    for (var i = 0; i < leelas.length; i++) {
      final l = leelas[i];
      final hay =
          '${l.title} ${l.hindi} ${l.subtitle} ${l.place} ${l.meaning} '
                  '${l.paragraphs.join(' ')}'
              .toLowerCase();
      if (hay.contains(needle)) {
        results.add(_Result(
          'LEELA · ${l.place.toUpperCase()}',
          l.title,
          l.subtitle,
          () => StoryScreen(index: i),
        ));
      }
    }

    for (var i = 0; i < gitaChapters.length; i++) {
      final c = gitaChapters[i];
      final hay = '${c.name} ${c.sanskrit} ${c.summary} ${c.keyIdea}'
          .toLowerCase();
      if (hay.contains(needle)) {
        results.add(_Result(
          'GITA · CHAPTER ${i + 1}',
          c.name,
          c.keyIdea,
          () => GitaChapterScreen(index: i),
        ));
      }
    }
    return results;
  }

  @override
  Widget build(BuildContext context) {
    final results = _search(_query);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          onChanged: (v) => setState(() => _query = v),
          style: const TextStyle(fontSize: 18, color: AppColors.cream),
          cursorColor: AppColors.gold,
          decoration: const InputDecoration(
            hintText: 'Search stories and chapters',
            hintStyle: TextStyle(fontSize: 16, color: AppColors.muted),
            border: InputBorder.none,
          ),
        ),
        actions: [
          if (_query.isNotEmpty)
            IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.close),
              onPressed: () {
                _controller.clear();
                setState(() => _query = '');
              },
            ),
        ],
      ),
      body: _body(results),
    );
  }

  Widget _body(List<_Result> results) {
    if (_query.trim().isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            'Try a name, a place or an idea.\n'
            'For example: Govardhan, Dwarka, devotion or karma.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, height: 1.5, color: AppColors.muted),
          ),
        ),
      );
    }
    if (results.isEmpty) {
      return const Center(
        child: Text(
          'No results found',
          style: TextStyle(fontSize: 16, color: AppColors.muted),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      itemCount: results.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, n) => _card(context, results[n]),
    );
  }

  Widget _card(BuildContext context, _Result r) {
    return Material(
      color: AppColors.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => r.page()),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      r.label,
                      style: const TextStyle(
                        fontSize: 12,
                        letterSpacing: 1.2,
                        color: AppColors.gold,
                      ),
                    ),
                    Text(
                      r.title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      r.subtitle,
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
              const Icon(Icons.chevron_right, color: AppColors.muted),
            ],
          ),
        ),
      ),
    );
  }
}
