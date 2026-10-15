import 'package:flutter/material.dart';
import '../services/saved_store.dart';
import '../services/settings_store.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _confirmClear(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.card,
        title: const Text('Clear saved items?'),
        content: const Text(
          'This removes every story and chapter from your Saved list.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
    if (ok == true) {
      await SavedStore.instance.clearAll();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Saved items cleared')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = SettingsStore.instance;
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListenableBuilder(
        listenable: store,
        builder: (context, _) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
            children: [
              _heading('Text size'),
              _note('Makes the stories, chapters and mantras easier to read.'),
              const SizedBox(height: 10),
              _chips(
                options: SettingsStore.textSizes.keys.toList(),
                selected: store.textSize,
                onSelected: store.setTextSize,
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Text(
                  'In Gokul, little Krishna could not resist the fresh butter '
                  'that Yashoda and the village gopis churned each morning.',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: Color(0xFFE4DDCE),
                  ),
                ),
              ),
              const SizedBox(height: 26),
              _heading('Voice speed'),
              _note(
                'How fast the Listen button reads aloud. It applies the next '
                'time you open a page.',
              ),
              const SizedBox(height: 10),
              _chips(
                options: SettingsStore.voiceSpeeds.keys.toList(),
                selected: store.voiceSpeed,
                onSelected: store.setVoiceSpeed,
              ),
              const SizedBox(height: 26),
              _heading('Saved items'),
              _note('Remove everything from your Saved list.'),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: OutlinedButton.icon(
                  onPressed: () => _confirmClear(context),
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Clear saved items'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.cream,
                    side: const BorderSide(color: AppColors.border),
                    minimumSize: const Size(0, 48),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _heading(String text) {
    return Text(text, style: headingStyle(18, color: AppColors.gold));
  }

  Widget _note(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13, height: 1.4, color: AppColors.muted),
      ),
    );
  }

  Widget _chips({
    required List<String> options,
    required String selected,
    required ValueChanged<String> onSelected,
  }) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final o in options)
          ChoiceChip(
            label: Text(o),
            selected: o == selected,
            showCheckmark: false,
            onSelected: (_) => onSelected(o),
            selectedColor: AppColors.gold,
            backgroundColor: AppColors.card,
            side: const BorderSide(color: AppColors.border),
            labelStyle: TextStyle(
              fontSize: 15,
              fontWeight: o == selected ? FontWeight.w600 : FontWeight.w400,
              color: o == selected ? AppColors.background : AppColors.cream,
            ),
          ),
      ],
    );
  }
}
