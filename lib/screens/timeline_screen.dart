import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class _Stage {
  final String place;
  final String title;
  final String summary;
  final String detail;
  const _Stage(this.place, this.title, this.summary, this.detail);
}

const _stages = [
  _Stage(
    "Mathura",
    "Birth",
    "Born in Kansa's prison to Devaki and Vasudeva, then carried across the Yamuna to safety in Gokul.",
    "Krishna was born at midnight in Kansa's prison. That night Vasudeva carried the newborn across the Yamuna to Gokul, where he could grow up safely with Nanda and Yashoda.",
  ),
  _Stage(
    "Gokul",
    "Childhood",
    "Raised by Nanda and Yashoda. The tales of butter, mischief and the defeat of Putana begin here.",
    "Nanda and Yashoda raised him as their own child. His early years are full of stories: the butter thief, the defeat of the demoness Putana, and playful mischief that won every heart.",
  ),
  _Stage(
    "Vrindavan",
    "Youth",
    "Cowherd days with the flute, Kaliya, Govardhan and the Rasa Lila.",
    "As a young cowherd, Krishna played his flute, tamed the serpent Kaliya, lifted Govardhan hill to shelter the villagers, and danced the Rasa Lila with the gopis.",
  ),
  _Stage(
    "Mathura",
    "Return",
    "Ends Kansa's rule and restores Ugrasena as king.",
    "Krishna and Balarama returned to Mathura, ended Kansa's tyranny, freed Devaki and Vasudeva, and restored Ugrasena to the throne.",
  ),
  _Stage(
    "Dwarka",
    "Kingdom",
    "Founds the city by the sea and marries Rukmini.",
    "Krishna established the city of Dwarka by the western sea and became its king. He married Rukmini, and Dwarka grew into a prosperous kingdom.",
  ),
  _Stage(
    "Kurukshetra",
    "The great war",
    "Serves as Arjuna's charioteer and shares the teachings of the Gita.",
    "During the Mahabharata war, Krishna served as Arjuna's charioteer. On the battlefield he shared the Bhagavad Gita, guiding Arjuna on duty, devotion and wisdom.",
  ),
];

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  int? _open;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Life Timeline')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 14),
            child: Text(
              'Tap a stage to read more',
              style: TextStyle(fontSize: 13, color: AppColors.muted),
            ),
          ),
          for (var i = 0; i < _stages.length; i++) _row(i),
        ],
      ),
    );
  }

  Widget _row(int i) {
    final s = _stages[i];
    final isLast = i == _stages.length - 1;
    final isOpen = _open == i;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 16,
            child: Column(
              children: [
                const SizedBox(height: 18),
                Container(
                  width: 14,
                  height: 14,
                  decoration: const BoxDecoration(
                    color: AppColors.gold,
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.only(top: 4),
                      color: AppColors.border,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Material(
                color: AppColors.card,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: AppColors.border),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => setState(() => _open = isOpen ? null : i),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s.place.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 12,
                            letterSpacing: 1.2,
                            color: AppColors.gold,
                          ),
                        ),
                        Text(
                          s.title,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          s.summary,
                          style: const TextStyle(
                            fontSize: 13,
                            height: 1.4,
                            color: AppColors.muted,
                          ),
                        ),
                        if (isOpen) ...[
                          const SizedBox(height: 8),
                          Text(
                            s.detail,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              color: Color(0xFFE4DDCE),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
