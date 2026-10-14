import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Remembers the reader's choices: text size and voice speed.
class SettingsStore extends ChangeNotifier {
  SettingsStore._();
  static final SettingsStore instance = SettingsStore._();

  static const textSizes = <String, double>{
    'Small': 0.9,
    'Medium': 1.0,
    'Large': 1.15,
  };

  static const voiceSpeeds = <String, double>{
    'Slow': 0.35,
    'Normal': 0.45,
    'Fast': 0.6,
  };

  String _textSize = 'Medium';
  String _voiceSpeed = 'Normal';

  String get textSize => _textSize;
  String get voiceSpeed => _voiceSpeed;
  double get textScale => textSizes[_textSize] ?? 1.0;
  double get voiceRate => voiceSpeeds[_voiceSpeed] ?? 0.45;

  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final t = prefs.getString('text_size');
      final v = prefs.getString('voice_speed');
      if (t != null && textSizes.containsKey(t)) _textSize = t;
      if (v != null && voiceSpeeds.containsKey(v)) _voiceSpeed = v;
      notifyListeners();
    } catch (_) {}
  }

  Future<void> setTextSize(String value) async {
    if (!textSizes.containsKey(value)) return;
    _textSize = value;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('text_size', value);
    } catch (_) {}
  }

  Future<void> setVoiceSpeed(String value) async {
    if (!voiceSpeeds.containsKey(value)) return;
    _voiceSpeed = value;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('voice_speed', value);
    } catch (_) {}
  }
}
