import 'package:flutter/material.dart';
import 'package:purena_lemo/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Purena',
      ),
      home: const MyHomeScreen(),
    );
  }
}
