import 'package:flutter/material.dart';
import 'package:app_4/widgets/expanses.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(useMaterial3: true), //Use Material 3 as the overall design system for this application.
      debugShowCheckedModeBanner: false,
      home: Expanses()
    );
  }
}

