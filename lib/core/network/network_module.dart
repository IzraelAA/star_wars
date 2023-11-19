import 'dart:async';


import 'package:dio/dio.dart';
import 'package:star_wars/core/network/api_exception.dart';
import 'package:star_wars/core/network/dio_module.dart';
import 'package:star_wars/core/network/result.dart';

abstract class NetworkModule {
  Dio get _dio => DioModule.getInstance();

  BaseOptions? options;
  final Map<String, String> header = {};
  final String authorization = 'Authorization';

  Future<Result<T>> _safeCallApi<T>(Future<Response<T>> call) async {
    try {
      var response = await call;
      return Result.success(
        response.data as T,
        response.statusMessage,
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return Result.error(
          e.response!.statusCode ?? 400,
          e.response!.data,
        );
      } else {
        return Result.timeout(
          '' as dynamic,
          'Network Failure',
        );
      }
    } catch (ex) {
      return Result.timeout(
        '' as dynamic,
        'Network Failure',
      );
    }
  }

  Future<Result<dynamic>> getMethod(
    String endpoint, {
    Map<String, dynamic>? param,
    Map<String, String>? headers,
  }) async {
    var options = Options(headers: headers);

    var response = await _safeCallApi(
      _dio.get(
        endpoint,
        queryParameters: param,
        options: options,
      ),
    );

    return response;
  }

  Future<Result<dynamic>> postMethod(
    String endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  }) async {
    var options = Options(headers: headers);

    var response = await _safeCallApi(
      _dio.post(
        endpoint,
        data: body,
        options: options,
      ),
    );

    return response;
  }

  Future<Result<dynamic>> putMethod(
    String endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  }) async {
    var options = Options(headers: headers);

    var response = await _safeCallApi(
      _dio.put(
        endpoint,
        data: body,
        options: options,
      ),
    );

    return response;
  }

  Future<Result> postUploadDocument(
    String endpoint,
    String url, {
    Map<String, String>? headers,
    FormData? body,
  }) async {
    var options = Options(headers: headers);
    var dio = DioModule.getInstance(
      BaseOptions(
        baseUrl: url,
        connectTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    var response = await _safeCallApi(
      dio.post(
        endpoint,
        data: body,
        options: options,
      ),
    );

    return response;
  }

  Future<Result<dynamic>?> deleteMethod(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    var options = Options(headers: headers);

    var response = await _safeCallApi(
      _dio.delete(
        endpoint,
        data: body,
        options: options,
      ),
    );

    return response;
  }

  /// [dynamic] this method is return response from [Result<dynamic>]
  dynamic responseHandler(Result<dynamic> result) {
    switch (result.status) {
      case Status.success:
        return result.body;
      case Status.error:
        if (result.code == 401) {
          throw UnAuthorizedExceptions(result.body);
        } else {
          throw ErrorRequestException(result.code, result.body);
        }
      case Status.unreachable:
        throw NetworkException(result.message);
      default:
        throw ArgumentError();
    }
  }
}