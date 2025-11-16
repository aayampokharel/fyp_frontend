// import 'package:dio/dio.dart';
// import 'package:flutter_dashboard/core/constants/api_endpoints.dart';

// class DioClient {
//   final Dio dio;

//   DioClient({required this.dio}) {
//     dio.options = BaseOptions(
//       baseUrl: ApiEndpoints.baseUrl,
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//       },
//       validateStatus: (status) {
//         return status! < 600;
//       },
//     );
//   }
// }

import 'package:dio/dio.dart';
import 'package:flutter_dashboard/core/constants/api_endpoints.dart';

class DioClient {
  final Dio dio;

  DioClient({required this.dio}) {
    dio.options = BaseOptions(
      baseUrl: ApiEndpoints
          .baseUrl, // Make sure this is https://your-subdomain.a.free.pinggy.link
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      validateStatus: (status) {
        return status != null && status < 600;
      },
      // Increase timeout for network requests
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    );

    // For Flutter Web: Allow sending requests with credentials if needed
    // dio.options.withCredentials = true; // uncomment if your backend requires cookies

    // Interceptor to debug errors
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (e, handler) {
          print("Dio Error: ${e.message}");
          handler.next(e);
        },
        onRequest: (options, handler) {
          print("Dio Request: ${options.uri}");
          handler.next(options);
        },
        onResponse: (response, handler) {
          print("Dio Response: ${response.statusCode} ${response.data}");
          handler.next(response);
        },
      ),
    );
  }
}
