import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../theme/app_theme.dart';

class _Mantra {
  final String name;
  final String sanskrit;
  final String roman;
  final String meaning;
  const _Mantra(this.name, this.sanskrit, this.roman, this.meaning);
}

const _mantras = [
  _Mantra(
    'Hare Krishna Maha Mantra',
    'हरे कृष्ण हरे कृष्ण कृष्ण कृष्ण हरे हरे । हरे राम हरे राम राम राम हरे हरे ॥',
    'Hare Krishna Hare Krishna, Krishna Krishna Hare Hare. Hare Rama Hare Rama, Rama Rama Hare Hare.',
    'A call to the divine names of the Lord, asking for divine love and peace of mind.',
  ),
  _Mantra(
    'Om Namo Bhagavate Vasudevaya',
    'ॐ नमो भगवते वासुदेवाय ॥',
    'Om Namo Bhagavate Vasudevaya.',
    'I bow to Lord Vasudeva, the divine presence that fills everything.',
  ),
  _Mantra(
    'Krishna Gayatri',
    'ॐ देवकीनन्दनाय विद्महे वासुदेवाय धीमहि । तन्नः कृष्णः प्रचोदयात् ॥',
    'Om Devakinandanaya Vidmahe, Vasudevaya Dhimahi, Tanno Krishnah Prachodayat.',
    'We know the son of Devaki and meditate on Vasudeva. May Krishna inspire and guide our minds.',
  ),
  _Mantra(
    'Achyutam Keshavam',
    'अच्युतं केशवं रामनारायणं कृष्णदामोदरं वासुदेवं हरिम् । श्रीधरं माधवं गोपिकावल्लभं जानकीनायकं रामचन्द्रं भजे ॥',
    'Achyutam Keshavam Rama-Narayanam, Krishna-Damodaram Vasudevam Harim. Shridharam Madhavam Gopika-vallabham, Janaki-nayakam Ramachandram Bhaje.',
    'I worship the Lord who is known by many beautiful names, the beloved of the gopis and the lord of Janaki.',
  ),
  _Mantra(
    'Madhurashtakam (first verse)',
    'अधरं मधुरं वदनं मधुरं नयनं मधुरं हसितं मधुरम् । हृदयं मधुरं गमनं मधुरं मधुराधिपतेरखिलं मधुरम् ॥',
    'Adharam madhuram vadanam madhuram, nayanam madhuram hasitam madhuram. Hridayam madhuram gamanam madhuram, madhuradhipater akhilam madhuram.',
    'Sweet are his lips, his face, his eyes and his smile. Sweet are his heart and his walk. Everything about the Lord of sweetness is sweet.',
  ),
];

class MantrasScreen extends StatefulWidget {
  const MantrasScreen({super.key});

  @override
  State<MantrasScreen> createState() => _MantrasScreenState();
}

class _MantrasScreenState extends State<MantrasScreen> {
  final FlutterTts _tts = FlutterTts();
  int? _playing;

  @override
  void initState() {
    super.initState();
    _tts.setLanguage('hi-IN');
    _tts.setSpeechRate(0.4);
    _tts.setCompletionHandler(() {
      if (mounted) setState(() => _playing = null);
    });
    _tts.setErrorHandler((message) {
      if (!mounted) return;
      setState(() => _playing = null);
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

  Future<void> _toggle(int i) async {
    if (_playing == i) {
      await _tts.stop();
      if (mounted) setState(() => _playing = null);
      return;
    }
    await _tts.stop();
    if (!mounted) return;
    setState(() => _playing = i);
    final text = _mantras[i].sanskrit.replaceAll('।', ',').replaceAll('॥', '');
    await _tts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mantras')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              'Sacred chants of Shri Krishna',
              style: TextStyle(fontSize: 13, color: AppColors.muted),
            ),
          ),
          for (var i = 0; i < _mantras.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _card(i),
            ),
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(
              'Audio is read aloud by your phone\'s voice, not sung.',
              style: TextStyle(fontSize: 12, color: AppColors.muted),
            ),
          ),
        ],
      ),
    );
  }

  Widget _card(int i) {
    final m = _mantras[i];
    final playing = _playing == i;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            m.name.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              letterSpacing: 1.2,
              color: AppColors.gold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            m.sanskrit,
            style: const TextStyle(fontSize: 19, height: 1.5),
          ),
          const SizedBox(height: 8),
          Text(
            m.roman,
            style: const TextStyle(
              fontSize: 14,
              height: 1.4,
              fontStyle: FontStyle.italic,
              color: AppColors.muted,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            m.meaning,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Color(0xFFE4DDCE),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () => _toggle(i),
            icon: Icon(playing ? Icons.stop : Icons.play_arrow),
            label: Text(playing ? 'Stop' : 'Listen'),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.gold,
              foregroundColor: AppColors.background,
              minimumSize: const Size(0, 48),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
