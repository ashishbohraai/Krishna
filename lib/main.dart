import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'services/saved_store.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SavedStore.instance.load();
  runApp(const KrishnaApp());
}

class KrishnaApp extends StatelessWidget {
  const KrishnaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shri Krishna',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const HomeScreen(),
    );
  }
}
