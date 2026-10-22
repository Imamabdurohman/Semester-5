import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  // Default mengikuti tema sistem/HP
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  // Fungsi untuk mengubah opsi tema (System -> Light -> Dark -> System)
  void toggleTheme() {
    if (_themeMode == ThemeMode.system) {
      _themeMode = ThemeMode.light;
    } else if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.system;
    }
    notifyListeners(); // Memberitahu seluruh aplikasi untuk merender ulang warna
  }

  // Set tema spesifik jika dibutuhkan
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}