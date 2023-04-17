import 'package:camera_app/functions.dart';
import 'package:camera_app/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  Hive.openBox('imgstore');
  getimage();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue),
      home: HomeScreen(),
    );
  }
}
