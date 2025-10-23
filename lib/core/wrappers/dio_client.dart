import 'package:dio/dio.dart';
import 'package:flutter_dashboard/core/constants/api_endpoints.dart';

class DioClient {
  final Dio dio;

  DioClient({required this.dio}) {
    dio.options.baseUrl = ApiEndpoints.baseUrl;
    dio.options = BaseOptions(
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }
}
