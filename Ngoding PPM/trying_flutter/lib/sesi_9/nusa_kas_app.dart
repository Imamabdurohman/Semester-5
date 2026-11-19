import 'package:flutter/material.dart';
import 'ui/kas/home_screen.dart';

class NusaKasApp extends StatelessWidget {
  const NusaKasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NusaKas',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const HomeScreen(),
    );
  }
}