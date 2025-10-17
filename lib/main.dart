import 'package:flash_recipe/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flash_recipe/screens/main_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => ThemeProvider(),
    child: const MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flash Recipe',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
        home: const MainScreen()
    );
  }
}
