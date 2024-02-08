import 'package:dio/dio.dart';
import 'package:hiring_test/core/util/app_constants.dart';

class DioFactory {
  DioFactory._();

  static Dio? dio;

  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 10);

    if (dio == null) {
      dio = Dio();
      dio!
        ..options.baseUrl = AppConstants.baseUrl
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;
      return dio!;
    } else {
      return dio!;
    }
  }
}
