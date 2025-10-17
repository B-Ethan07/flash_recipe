import 'package:flutter/material.dart';

class AppTheme {
  static const _blue = Color(0xFF0D47A1);
  static const _lightBlue = Color(0xFF03A9F4);
  static const _amber = Color(0xFFFFD54F);

  static final light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: _blue,
      secondary: _lightBlue,
      tertiary: _amber,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _blue,
      foregroundColor: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      hoverColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _blue, width: 2),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _blue,
        foregroundColor: Colors.white,
      ),
    ),
    cardTheme: const CardThemeData(
      color: _amber,
      elevation: 4,
    ),
    switchTheme: SwitchThemeData(
      thumbIcon: WidgetStateProperty.all(
        Icon(Icons.dark_mode, size: 16, color: Colors.amber),
      ),
      thumbColor: WidgetStateProperty.resolveWith((states) {
        return Colors.black;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        return Colors.white;
      }),
    ),
  );

  static final dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: _lightBlue,
      secondary: _blue,
      tertiary: _amber,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF1E1E1E),
      hoverColor: Color(0xFF2A2A2A),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade700),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _lightBlue, width: 2),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _blue,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _lightBlue,
        foregroundColor: Colors.black,
      ),
    ),
    cardTheme: const CardThemeData(
      color: Color(0xFF2A2A2A), // gris anthracite
      elevation: 4,
    ),
    switchTheme: SwitchThemeData(
      thumbIcon: WidgetStateProperty.all(
        Icon(Icons.dark_mode, size: 16, color: Colors.black),
      ),
      thumbColor: WidgetStateProperty.resolveWith((states) {
        return Colors.white;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        return Colors.black;
      }),
    ),
  );
}

class ThemeProvider extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;
  ThemeData get theme => _isDark ? AppTheme.dark : AppTheme.light;

  void toggle() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
