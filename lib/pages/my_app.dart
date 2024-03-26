import 'package:app_cinema/pages/homePage/home_page.dart';
import 'package:flutter/material.dart';

import '../apps/config/config_theme.dart';
import '../l10n/generated/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('vi'),
    );
  }
}
