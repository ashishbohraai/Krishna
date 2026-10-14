import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import 'dedication_screen.dart';
import 'info_screen.dart';

/// Put your email address between the quotes to show "Send feedback",
/// for example: 'yourname@gmail.com'. Leave it empty to hide that item.
const feedbackEmail = '';

const appVersion = '1.0.0';

const _aboutSections = [
  InfoSection(
    'Shri Krishna is a free app to learn about the life, stories and '
    'teachings of Shri Krishna. You can read the Leelas, explore the Bhagavad '
    'Gita chapter by chapter, find sacred places and festivals, and listen '
    'to mantras.\n\n'
    'It is made with devotion, for devotees and for anyone who wants to '
    'learn.',
    heading: 'About this app',
  ),
  InfoSection(
    'This app is dedicated to the loving memory of my father, a devoted '
    'follower of Shri Krishna.',
    heading: 'Dedication',
  ),
  InfoSection('Version $appVersion'),
];

const _sourcesSections = [
  InfoSection(
    'The stories are retold in simple words from traditional texts: the '
    'Bhagavata Purana (Canto 10) and the Mahabharata. The Gita chapter pages '
    'are short summaries of the Bhagavad Gita, written in plain language.',
    heading: 'Where the content comes from',
  ),
  InfoSection(
    'These are simplified retellings, not translations. Traditions and '
    'regions sometimes tell the same story with different details. For deeper '
    'study, please read the original texts or learn from a teacher.',
    heading: 'A gentle note',
  ),
  InfoSection(
    'The Listen button uses your phone\'s own voice to read the text aloud. '
    'It reads the words; it does not sing or chant them.',
    heading: 'About the voice',
  ),
];

const _privacySections = [
  InfoSection('Last updated: October 2026'),
  InfoSection(
    'Nothing. The app has no accounts, no ads and no analytics. It does not '
    'ask for your name, email, location, photos or contacts.',
    heading: 'What the app collects',
  ),
  InfoSection(
    'The stories and chapters you save with the heart are kept only on your '
    'device. Uninstalling the app removes them.',
    heading: 'What stays on your phone',
  ),
  InfoSection(
    'The Listen button uses the text-to-speech voice built into your phone. '
    'The app does not record anything.',
    heading: 'Listening',
  ),
  InfoSection(
    'The app downloads its fonts from Google Fonts the first time they are '
    'needed, so Google may receive your device\'s internet address, as with '
    'any website you visit. The place links open Google Maps or your browser, '
    'which follow their own privacy policies.',
    heading: 'Internet use',
  ),
  InfoSection(
    'The app has no ads and no purchases.',
    heading: 'Ads and purchases',
  ),
  InfoSection(
    'For any question about this policy, please contact the developer '
    'through the details on the app\'s Play Store page. If this policy '
    'changes, the new version will appear here.',
    heading: 'Questions and changes',
  ),
];

class _MoreItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _MoreItem(this.icon, this.title, this.subtitle, this.onTap);
}

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  void _push(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  Future<void> _sendFeedback(BuildContext context) async {
    final subject = Uri.encodeComponent('Shri Krishna app feedback');
    final uri = Uri.parse('mailto:$feedbackEmail?subject=$subject');
    var opened = false;
    try {
      opened = await launchUrl(uri);
    } catch (_) {}
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open an email app.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = <_MoreItem>[
      _MoreItem(
        Icons.info_outline,
        'About this app',
        'What it is and who made it',
        () => _push(
          context,
          const InfoScreen(title: 'About', sections: _aboutSections),
        ),
      ),
      _MoreItem(
        Icons.menu_book_outlined,
        'Sources and note',
        'Where the stories come from',
        () => _push(
          context,
          const InfoScreen(title: 'Sources', sections: _sourcesSections),
        ),
      ),
      _MoreItem(
        Icons.local_florist,
        'In loving memory',
        'A dedication to my father',
        () => _push(context, const DedicationScreen()),
      ),
      _MoreItem(
        Icons.privacy_tip_outlined,
        'Privacy policy',
        'How your information is handled',
        () => _push(
          context,
          const InfoScreen(title: 'Privacy policy', sections: _privacySections),
        ),
      ),
      if (feedbackEmail.isNotEmpty)
        _MoreItem(
          Icons.mail_outline,
          'Send feedback',
          'Tell us what you think',
          () => _sendFeedback(context),
        ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('More')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        children: [
          for (final item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _card(item),
            ),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              'Version $appVersion',
              style: TextStyle(fontSize: 12, color: AppColors.muted),
            ),
          ),
        ],
      ),
    );
  }

  Widget _card(_MoreItem item) {
    return Material(
      color: AppColors.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: item.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              Icon(item.icon, size: 26, color: AppColors.gold),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      item.subtitle,
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
