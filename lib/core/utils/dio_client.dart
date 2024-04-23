import 'package:dio/dio.dart';

class DioClient {
  late Dio dio;

  final baseUrl = 'https://api.themoviedb.org/3';

  void initDio() {
    dio = Dio();
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      receiveTimeout: const Duration(seconds: 8),
    );
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      options.queryParameters['api_key'] = '8ad8f789a8d1b9172925530aa58ef743';
      return handler.next(options);
    }, onError: (DioError error, handler) {
      print("Error occurred: ${error.message}");
      return handler.next(error);
    }));
  }
}
