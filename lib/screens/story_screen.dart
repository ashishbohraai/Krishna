import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../data/leelas.dart';
import '../services/saved_store.dart';
import '../services/settings_store.dart';
import '../theme/app_theme.dart';
import '../widgets/feather_motif.dart';

class StoryScreen extends StatefulWidget {
  final int index;
  const StoryScreen({super.key, required this.index});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  final FlutterTts _tts = FlutterTts();
  final SavedStore _store = SavedStore.instance;
  bool _speaking = false;

  String get _key => 'leela:${widget.index}';

  @override
  void initState() {
    super.initState();
    _tts.setLanguage('en-IN');
    _tts.setSpeechRate(SettingsStore.instance.voiceRate);
    _tts.setCompletionHandler(() {
      if (mounted) setState(() => _speaking = false);
    });
    _tts.setErrorHandler((message) {
      if (!mounted) return;
      setState(() => _speaking = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not play audio. Check your phone voice settings.'),
        ),
      );
    });
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  void _goToNext() {
    final next = (widget.index + 1) % leelas.length;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => StoryScreen(index: next)),
    );
  }

  void _toggleSaved() {
    final nowSaved = !_store.isSaved(_key);
    _store.toggle(_key);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(nowSaved ? 'Saved' : 'Removed from Saved'),
      ),
    );
  }

  Future<void> _listen() async {
    if (_speaking) {
      await _tts.stop();
      if (mounted) setState(() => _speaking = false);
      return;
    }
    final leela = leelas[widget.index];
    final text = '${leela.title}. ${leela.paragraphs.join(' ')} '
        'The meaning. ${leela.meaning}';
    setState(() => _speaking = true);
    await _tts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    final leela = leelas[widget.index];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Leela ${widget.index + 1} of ${leelas.length}',
          style: const TextStyle(fontSize: 14, color: AppColors.muted),
        ),
        actions: [
          IconButton(
            onPressed: _goToNext,
            tooltip: 'Next story',
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
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
              child: const OverflowBox(
                maxWidth: 190,
                maxHeight: 190,
                child: FeatherMotif(size: 190),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              '${leela.place.toUpperCase()} · ${leela.duration.toUpperCase()} READ',
              style: const TextStyle(
                fontSize: 12,
                letterSpacing: 1.2,
                color: AppColors.gold,
              ),
            ),
            const SizedBox(height: 2),
            Text(leela.title, style: headingStyle(28)),
            const SizedBox(height: 2),
            Text(
              '${leela.hindi} · ${leela.subtitle}',
              style: const TextStyle(fontSize: 15, color: AppColors.muted),
            ),
            const SizedBox(height: 14),
            for (final p in leela.paragraphs)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  p,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: Color(0xFFE4DDCE),
                  ),
                ),
              ),
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'THE MEANING',
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 1.2,
                      color: AppColors.gold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    leela.meaning,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: Color(0xFFE4DDCE),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Source: ${leela.source}',
                    style: const TextStyle(fontSize: 12, color: AppColors.muted),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.navBar,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _listen,
                    icon: Icon(_speaking ? Icons.stop : Icons.play_arrow),
                    label: Text(_speaking ? 'Stop' : 'Listen'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.gold,
                      foregroundColor: AppColors.background,
                      minimumSize: const Size.fromHeight(48),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ListenableBuilder(
                  listenable: _store,
                  builder: (context, _) {
                    final saved = _store.isSaved(_key);
                    return IconButton.outlined(
                      onPressed: _toggleSaved,
                      tooltip: saved ? 'Remove from Saved' : 'Save story',
                      icon: Icon(
                        saved ? Icons.favorite : Icons.favorite_border,
                        color: saved ? AppColors.gold : AppColors.cream,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.card,
                        side: const BorderSide(color: AppColors.border),
                        fixedSize: const Size(48, 48),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
