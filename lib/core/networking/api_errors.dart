
import 'package:hiring_test/core/errors/error_model.dart';


enum DataSource {
  noContent,
  badRequest,
  forbidden,
  unauthorised,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  defaultError
}

class ResponseCode {
  static const int success = 200;
  static const int noContent = 201;
  static const int badRequest = 400;
  static const int unauthorised = 401;
  static const int forbidden = 403;
  static const int internalServerError = 500;
  static const int notFound = 404;

  // local status code
  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3;
  static const int sendTimeout = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int defaultError = -7;
}

class ResponseMessage {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}

extension DataSourceExtension on DataSource {
  ErrorModel getFailure() {
    switch (this) {
      case DataSource.noContent:
        return ErrorModel(
            code: ResponseCode.noContent, message: ResponseMessage.noContent);
      case DataSource.badRequest:
        return ErrorModel(
            code: ResponseCode.badRequest,
            message: ResponseMessage.badRequestError);
      case DataSource.forbidden:
        return ErrorModel(
            code: ResponseCode.forbidden, message: ResponseMessage.forbiddenError);
      case DataSource.unauthorised:
        return ErrorModel(
            code: ResponseCode.unauthorised,
            message: ResponseMessage.unauthorizedError);
      case DataSource.notFound:
        return ErrorModel(
            code: ResponseCode.notFound, message: ResponseMessage.notFoundError);
      case DataSource.internalServerError:
        return ErrorModel(
            code: ResponseCode.internalServerError,
            message: ResponseMessage.internalServerError);
      case DataSource.connectTimeout:
        return ErrorModel(
            code: ResponseCode.connectTimeout,
            message: ResponseMessage.timeoutError);
      case DataSource.cancel:
        return ErrorModel(
            code: ResponseCode.cancel, message: ResponseMessage.defaultError);
      case DataSource.receiveTimeout:
        return ErrorModel(
            code: ResponseCode.receiveTimeout,
            message: ResponseMessage.timeoutError);
      case DataSource.sendTimeout:
        return ErrorModel(
            code: ResponseCode.sendTimeout,
            message: ResponseMessage.timeoutError);
      case DataSource.cacheError:
        return ErrorModel(
            code: ResponseCode.cacheError,
            message: ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return ErrorModel(
            code: ResponseCode.noInternetConnection,
            message: ResponseMessage.noInternetError);
      case DataSource.defaultError:
        return ErrorModel(
            code: ResponseCode.defaultError, message: ResponseMessage.defaultError);
    }
  }
}




