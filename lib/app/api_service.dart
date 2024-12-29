import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiData {
  final Map<String, dynamic> data;
  final int code;
  final String errorMessage;
  final bool success;

  const ApiData(
      {required this.data,
      required this.code,
      required this.errorMessage,
      required this.success});

  ApiData copyWith({
    Map<String, dynamic>? data,
    int? code,
    String? message,
    String? errorMessage,
    bool? success,
  }) {
    return ApiData(
      data: data ?? this.data,
      code: code ?? this.code,
      errorMessage: errorMessage ?? this.errorMessage,
      success: success ?? this.success,
    );
  }
}

class ApiService {
  final Dio _dio;
  late Response response;
  String baseUrl = "https://rickandmortyapi.com/api/";

  ApiService(this._dio) {
    _dio.interceptors.addAll([
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    ]);
  }

  Future<ApiData> _handleRequest(Future<Response> request) async {
     try {
      final response = await request;
      final jsonData = response.data;

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return ApiData(
          data: jsonData,
          code: response.statusCode ?? 0,
          errorMessage: "",
          success: true,
        );
      } else {
        return ApiData(
          data: jsonData,
          code: response.statusCode ?? 0,
          errorMessage: getError(response),
          success: false,
        );
      }
    } catch (e) {
      return ApiData(
        data: {},
        code: 0,
        errorMessage: e.toString(),
        success: false,
      );
    }
  }

  Future<ApiData> get(
      {required String endPoint,
      Map<String, dynamic>? queryParameters}) async {
    try {
      response = await _dio.get(
        '$baseUrl$endPoint',
        queryParameters: queryParameters,
      );
      return await _handleRequest(Future.value(response));
    } catch (e) {
      return ApiData(
        data: {},
        code: 0,
        errorMessage: e.toString(),
        success: false,
      );
    }
  }

  String getError(Response json) {
    final jsonString = jsonEncode(json.data);

    if (jsonString.contains("errors")) {
      String error = "";

      try {
        Map<String, dynamic> jsonData = jsonDecode(jsonString);
        Map<String, dynamic> errors = jsonData['errors'];
        // Get the first error message
        error = errors.values.first.first;
        error = error.replaceAll('"', '');
      } catch (e) {
        error = "something went wrong";
      }

      return error;
    } else {
      String error = "";
      try {
        error = jsonEncode(json.data['message']);
        error = error.replaceAll('"', '');
      } catch (e) {
        error = "something went wrong";
      }
      return error;
    }
  }
}