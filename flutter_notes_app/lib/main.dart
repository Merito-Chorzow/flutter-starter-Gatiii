import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/add_entry_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Notes",
      theme: ThemeData(useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/details': (context) {
          final post = ModalRoute.of(context)!.settings.arguments as Map;
          return DetailScreen(post: post);
        },
        '/add': (context) => const AddEntryScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
