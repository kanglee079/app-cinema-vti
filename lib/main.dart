import 'package:app_cinema/core/utils/dio_client.dart';
import 'package:app_cinema/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'core/common/userPreferences/user_preferences.dart';
import 'features/auths/presentation/auth_route.dart';
import 'features/home/presentation/home_route.dart';
import 'firebase_options.dart';

DioClient dioClient = DioClient();

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // name: 'demoapp',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  dioClient.initDio();
  await UserPreferences.initialize();
  String? token = UserPreferences.getToken();
  runApp(
    MyApp(
      initialRoute:
          token == null ? AuthRoute.loginRouteName : HomeRoute.routeName,
    ),
  );
  EasyLoading.instance
    ..userInteractions = false
    ..dismissOnTap = false
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom;
}
