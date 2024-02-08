import 'package:dio/dio.dart';
import 'package:hiring_test/core/errors/cash_errors.dart';
import 'package:hiring_test/core/errors/error_model.dart';
import 'package:hiring_test/core/networking/api_errors.dart';

class ErrorHandler implements Exception {
  static late ErrorModel errorModel;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      // dio error so its an error from response of the API or from dio itself
      errorModel = _handleError(error);
    } else if(error is CashError){
      errorModel = DataSource.cacheError.getFailure();
    }else {
      // defaultError error
      errorModel = DataSource.defaultError.getFailure();
    }
  }
}

ErrorModel _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.connectTimeout.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.sendTimeout.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.receiveTimeout.getFailure();
    case DioExceptionType.badResponse:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return ErrorModel.fromJson(error.response!.data);
      } else {
        return DataSource.defaultError.getFailure();
      }
    case DioExceptionType.unknown:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return ErrorModel.fromJson(error.response!.data);
      } else {
        return DataSource.defaultError.getFailure();
      }
    case DioExceptionType.cancel:
      return DataSource.cancel.getFailure();
    case DioExceptionType.connectionError:
      return DataSource.defaultError.getFailure();
    case DioExceptionType.badCertificate:
      return DataSource.defaultError.getFailure();
    case DioExceptionType.badResponse:
      return DataSource.defaultError.getFailure();
  }
}