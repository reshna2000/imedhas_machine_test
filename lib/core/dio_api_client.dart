import 'dart:developer';
import 'package:dio/dio.dart';
import 'api_support.dart';

class DioApiClient {
  static final DioApiClient _instance = DioApiClient._internal();
  factory DioApiClient() => _instance;

  final Dio _dio = Dio();

  DioApiClient._internal() {
    _dio.options.baseUrl = ApiSupport.baseUrl;
  }

  Future<Response> post(
      String path, {
        required Map<String, dynamic> data,
      }) async {
    try {
      log("POST: $path");
      return await _dio.post(path, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> get(
      String path, {
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      log("GET: $path");
      return await _dio.get(path, queryParameters: queryParameters);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(
      String path, {
        required Map<String, dynamic> data,
      }) async {
    try {
      log("PUT: $path");
      return await _dio.put(path, data: data);
    } catch (e) {
      rethrow;
    }
  }


  Future<Response> delete(
      String path, {
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? data,
      }) async {
    try {
      log("DELETE: $path");
      return await _dio.delete(
        path,
        queryParameters: queryParameters,
        data: data,
      );
    } catch (e) {
      rethrow;
    }
  }
}
