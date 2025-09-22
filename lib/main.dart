import 'package:flutter/material.dart';
import 'package:recode3000/pages/my_home_page.dart';
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
      theme: ThemeData(),
      home: MainPage(title: title),
    );
  }
}
