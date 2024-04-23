import 'package:app_cinema/features/home/presentation/bloc/home_bloc.dart';
import 'package:app_cinema/features/home/presentation/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'core/routes/route.dart';
import 'core/themes/config_theme.dart';
// import 'l10n/generated/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,
      // locale: const Locale('en'),
      onGenerateRoute: RouteGenerator.generate,
      builder: EasyLoading.init(),
      home: BlocProvider(
        create: (context) => HomeBloc(),
        child: const HomePage(),
      ),
    );
  }
}
