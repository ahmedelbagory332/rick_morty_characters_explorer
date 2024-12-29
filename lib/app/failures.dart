import 'package:dio/dio.dart';

class Failure {
  final String errMessage;
  final String errorCode;

  const Failure(this.errMessage, this.errorCode);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage, super.errorCode);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.sendTimeout:
        return ServerFailure(
            "Send timeout with ApiServer",dioError.response?.statusCode.toString()??'');

      case DioExceptionType.receiveTimeout:
        return ServerFailure(
            "Receive timeout with ApiServer",dioError.response?.statusCode.toString()??'');

      case DioExceptionType.cancel:
        return ServerFailure(
            "Request to ApiServer was canceled",dioError.response?.statusCode.toString()??'');

      case DioExceptionType.connectionTimeout:
        return ServerFailure(
            "connection timeout with ApiServer",dioError.response?.statusCode.toString()??'');

      default:
        return ServerFailure(
            "Oops There was an Error, Please try again",dioError.response?.statusCode.toString()??'');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(
          "Oops There was an Error, Please try again",statusCode.toString());
    } else if (statusCode == 404) {
      return ServerFailure(
          "Your request not found, Please try later!",statusCode.toString());
    } else if (statusCode == 500) {
      return ServerFailure(
          "Internal Server error, Please try later",statusCode.toString());
    } else {
      return ServerFailure(
          "Oops There was an Error, Please try again",statusCode.toString());
    }
  }
}
