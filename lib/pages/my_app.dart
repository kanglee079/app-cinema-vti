import 'package:app_cinema/pages/aboutPage/about_page.dart';
import 'package:flutter/material.dart';

import '../apps/config/config_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AboutPage(),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
    );
  }
}
