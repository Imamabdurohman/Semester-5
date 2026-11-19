import 'package:flutter/material.dart';
import 'ui/core/shell/app_shell.dart';

class KasirGudangApp extends StatelessWidget {
  const KasirGudangApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kasir & Gudang Grosir',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
      ),
      home: const AppShell(),
    );
  }
}