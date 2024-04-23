import 'package:app_cinema/core/utils/dio_client.dart';
import 'package:app_cinema/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'firebase_options.dart';

DioClient dioClient = DioClient();

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // name: 'demoapp',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  dioClient.initDio();
  runApp(const MyApp());
  EasyLoading.instance
    ..userInteractions = false
    ..dismissOnTap = false;
}
