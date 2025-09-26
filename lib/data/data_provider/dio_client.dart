import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hipster_prac/core/constants/api_constants.dart';
import 'package:hipster_prac/core/errors/dio_exception.dart';

class DioClient {
  // dio instance
  final Dio _dio;

  DioClient(this._dio) {
    _dio
      ..options.baseUrl = ApiConstants.baseUrl
      ..options.connectTimeout = const Duration(
        seconds: ApiConstants.connectionTimeout,
      )
      ..options.receiveTimeout = const Duration(
        seconds: ApiConstants.receiveTimeout,
      );
  }

  // Get:-----------------------------------------------------------------------
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      if (e.error is SocketException) {
        throw NetworkException();
      }
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    } catch (e) {
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<Response> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      if (e.error is SocketException) {
        throw NetworkException();
      }
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    } catch (e) {
      rethrow;
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<Response> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      if (e.error is SocketException) {
        throw NetworkException();
      }
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    } catch (e) {
      rethrow;
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on DioException catch (e) {
      if (e.error is SocketException) {
        throw NetworkException();
      }
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> checkConnectivity() async {
  //   final List<ConnectivityResult> connectivityResult = await (Connectivity()
  //       .checkConnectivity());
  //   if (connectivityResult.contains(ConnectivityResult.mobile) ||
  //       connectivityResult.contains(ConnectivityResult.wifi) ||
  //       connectivityResult.contains(ConnectivityResult.ethernet) ||
  //       connectivityResult.contains(ConnectivityResult.vpn)) {
  //     //pass
  //   } else {
  //     throw NetworkException();
  //   }
  // }
}
