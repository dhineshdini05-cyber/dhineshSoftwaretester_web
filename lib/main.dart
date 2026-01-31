import 'package:flutter/material.dart';
import 'package:portfolio/constants/constants.dart';
import 'package:portfolio/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dhinesh Kumar - QA Engineer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        elevatedButtonTheme: elevatedButtonThemeData,
      ),
      home: const HomeScreen(),
    );
  }
}