import 'package:app_cinema/features/about/presentation/views/about_page.dart';
import 'package:app_cinema/features/home/presentation/views/home_page.dart';
import 'package:app_cinema/features/login/presentation/bloc/login_bloc.dart';
import 'package:app_cinema/features/login/presentation/views/login_page.dart';
import 'package:app_cinema/features/profile/presentation/views/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'apps/config/config_theme.dart';
import 'l10n/generated/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      initialRoute: '/login',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => const HomePage());
          case '/login':
            return MaterialPageRoute(
              builder: (context) {
                return BlocProvider(
                  create: (context) => LoginBloc(),
                  child: const LoginPage(),
                );
              },
            );
          case '/about':
            return MaterialPageRoute(builder: (context) => const AboutPage());
          case '/profile':
            return MaterialPageRoute(builder: (context) => const ProfilePage());
          default:
            return MaterialPageRoute(builder: (context) => const HomePage());
        }
      },
    );
  }
}
