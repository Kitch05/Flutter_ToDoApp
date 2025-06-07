import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/pages/todo_page.dart';

void main() async {
  await Hive.initFlutter();

  var box = await Hive.openBox('mybox');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: Colors.brown.shade300,
            onPrimary: Colors.white60,
            secondary: Colors.brown.shade700,
            onSecondary: Colors.white60,
            error: Colors.red.shade400,
            onError: Colors.black87,
            surface: Colors.brown.shade50,
            onSurface: Colors.black87),
        scaffoldBackgroundColor: Colors.brown[300],
        appBarTheme: AppBarTheme(
            color: Colors.brown[700],
            titleTextStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary, fontSize: 24),
            iconTheme: IconThemeData(
                size: 30, color: Theme.of(context).colorScheme.onSecondary)),
      ),
      home: const TodoPage(),
    );
  }
}
