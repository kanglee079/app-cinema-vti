import 'package:app_cinema/pages/profilePage/profile_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ProfilePage(),
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 18, color: Colors.white),
          displayMedium: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
