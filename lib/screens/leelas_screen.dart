import 'package:flutter/material.dart';
import '../data/leelas.dart';
import '../theme/app_theme.dart';
import 'story_screen.dart';

const _numerals = ['१', '२', '३', '४', '५', '६', '७'];
const _filters = ['All', 'Gokul', 'Vrindavan', 'Mathura', 'Dwarka'];

class LeelasScreen extends StatefulWidget {
  const LeelasScreen({super.key});

  @override
  State<LeelasScreen> createState() => _LeelasScreenState();
}

class _LeelasScreenState extends State<LeelasScreen> {
  String _selected = 'All';

  @override
  Widget build(BuildContext context) {
    final indexes = [
      for (var i = 0; i < leelas.length; i++)
        if (_selected == 'All' || leelas[i].place == _selected) i,
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Leelas')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Divine stories of Shri Krishna',
                style: TextStyle(fontSize: 13, color: AppColors.muted),
              ),
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, i) {
                final f = _filters[i];
                final selected = f == _selected;
                return ChoiceChip(
                  label: Text(f),
                  selected: selected,
                  showCheckmark: false,
                  onSelected: (_) => setState(() => _selected = f),
                  selectedColor: AppColors.gold,
                  backgroundColor: AppColors.card,
                  side: const BorderSide(color: AppColors.border),
                  labelStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    color: selected ? AppColors.background : AppColors.cream,
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
              itemCount: indexes.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, n) => _LeelaCard(index: indexes[n]),
            ),
          ),
        ],
      ),
    );
  }
}

class _LeelaCard extends StatelessWidget {
  final int index;
  const _LeelaCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final leela = leelas[index];
    return Material(
      color: AppColors.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => StoryScreen(index: index)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.background,
                  border: Border.all(color: AppColors.gold, width: 2),
                ),
                child: Text(
                  _numerals[index],
                  style: headingStyle(18, color: AppColors.gold),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      leela.title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      leela.subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.muted,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${leela.place} · ${leela.readTime} read',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.gold,
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
