import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Keeps track of the stories and chapters the user has saved.
/// Keys look like 'leela:2' or 'gita:5'.
class SavedStore extends ChangeNotifier {
  SavedStore._();
  static final SavedStore instance = SavedStore._();

  static const _prefsKey = 'saved_items';
  final Set<String> _keys = {};

  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _keys
        ..clear()
        ..addAll(prefs.getStringList(_prefsKey) ?? const []);
      notifyListeners();
    } catch (_) {}
  }

  bool isSaved(String key) => _keys.contains(key);

  List<int> indexesOf(String kind) {
    final out = <int>[];
    for (final k in _keys) {
      final parts = k.split(':');
      if (parts.length == 2 && parts[0] == kind) {
        final n = int.tryParse(parts[1]);
        if (n != null) out.add(n);
      }
    }
    out.sort();
    return out;
  }

  Future<void> toggle(String key) async {
    if (!_keys.remove(key)) _keys.add(key);
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_prefsKey, _keys.toList());
    } catch (_) {}
  }

  Future<void> clearAll() async {
    _keys.clear();
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_prefsKey);
    } catch (_) {}
  }
}
