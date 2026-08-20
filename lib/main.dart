import 'package:flutter/material.dart';
import 'package:app_4/widgets/expanses.dart';
 var kcolorScheme = ColorScheme.fromSeed(
     seedColor: Color.fromARGB(255, 69, 59, 181), );
 var kDarkColorScheme = ColorScheme.fromSeed(seedColor: Color. fromARGB(255, 5, 99, 125));

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: kDarkColorScheme

        ),
        theme: ThemeData(
          useMaterial3: true,
         colorScheme: kcolorScheme
         // scaffoldBackgroundColor: const Color.fromARGB(255, 60, 8, 0),
        ),
        //Use Material 3 as the overall design system for this application.

      debugShowCheckedModeBanner: false,

      home: Expanses()
    );
  }
}

