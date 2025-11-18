import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/detail_screen.dart';

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
        '/': (context) => HomeScreen(),
        '/details': (context) {
          final id = ModalRoute.of(context)!.settings.arguments as int;
          return DetailScreen(postId: id);
        },
      },
    );
  }
}
