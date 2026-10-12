import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../data/gita_chapters.dart';
import '../theme/app_theme.dart';
import '../widgets/feather_motif.dart';

class GitaChapterScreen extends StatefulWidget {
  final int index;
  const GitaChapterScreen({super.key, required this.index});

  @override
  State<GitaChapterScreen> createState() => _GitaChapterScreenState();
}

class _GitaChapterScreenState extends State<GitaChapterScreen> {
  final FlutterTts _tts = FlutterTts();
  bool _speaking = false;

  @override
  void initState() {
    super.initState();
    _tts.setLanguage('en-IN');
    _tts.setSpeechRate(0.45);
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

  void _goTo(int index) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => GitaChapterScreen(index: index)),
    );
  }

  Future<void> _listen() async {
    if (_speaking) {
      await _tts.stop();
      if (mounted) setState(() => _speaking = false);
      return;
    }
    final c = gitaChapters[widget.index];
    final text = 'Chapter ${widget.index + 1}. ${c.name}. ${c.summary} '
        'Key idea. ${c.keyIdea}';
    setState(() => _speaking = true);
    await _tts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    final i = widget.index;
    final c = gitaChapters[i];
    final hasPrev = i > 0;
    final hasNext = i < gitaChapters.length - 1;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Chapter ${i + 1} of ${gitaChapters.length}',
          style: const TextStyle(fontSize: 14, color: AppColors.muted),
        ),
        actions: [
          IconButton(
            onPressed: hasPrev ? () => _goTo(i - 1) : null,
            tooltip: 'Previous chapter',
            icon: const Icon(Icons.chevron_left),
          ),
          IconButton(
            onPressed: hasNext ? () => _goTo(i + 1) : null,
            tooltip: 'Next chapter',
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
              height: 150,
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
                    right: -30,
                    top: -30,
                    child: FeatherMotif(size: 150),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CHAPTER ${i + 1}',
                          style: const TextStyle(
                            fontSize: 12,
                            letterSpacing: 1.4,
                            color: Color(0xFFD9F0EE),
                          ),
                        ),
                        const SizedBox(height: 2),
                        SizedBox(
                          width: 250,
                          child: Text(c.name, style: headingStyle(26)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Text(
              c.sanskrit,
              style: const TextStyle(fontSize: 17, color: AppColors.gold),
            ),
            const SizedBox(height: 12),
            Text(
              c.summary,
              style: const TextStyle(
                fontSize: 15,
                height: 1.55,
                color: Color(0xFFE4DDCE),
              ),
            ),
            const SizedBox(height: 16),
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
                    'KEY IDEA',
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 1.2,
                      color: AppColors.gold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    c.keyIdea,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.4,
                      color: Color(0xFFE4DDCE),
                    ),
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
        ),
      ),
    );
  }
}
