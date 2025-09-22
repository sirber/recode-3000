import 'package:flutter/material.dart';
import 'package:recode3000/pages/main.dart';
import 'package:window_manager/window_manager.dart';

const title = "Recode 3000";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  windowManager.setTitle(title);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system, // Follows OS setting
      home: MainPage(title: title),
    );
  }
}
