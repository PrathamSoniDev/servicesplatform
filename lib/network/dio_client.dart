// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';

// import '../core/storage/cache_keys.dart';
// import '../core/storage/sqlite_cache.dart';

// /// Centralized Dio client
// class DioClient {
//   DioClient._internal();

//   static final Dio dio = _createDio();

//   static Dio _createDio() {
//     final options = BaseOptions(
//       baseUrl: 'https://serviceplatform-backend.onrender.com/',
//       connectTimeout: const Duration(seconds: 50),
//       receiveTimeout: const Duration(seconds: 50),
//       sendTimeout: const Duration(seconds: 50),
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//       },
//       responseType: ResponseType.json,
//     );

//     final dio = Dio(options);

//     // ───────────────── INTERCEPTORS ─────────────────
//     dio.interceptors.addAll([
//       InterceptorsWrapper(
//         onRequest: (options, handler) async {
//           final token = await SQLiteCache.load(
//             CacheKeys.accessToken,
//             maxAge: Duration(days: 365),
//           );

//           if (token != null && token.isNotEmpty) {
//             options.headers['Authorization'] = 'Bearer $token';
//           }

//           return handler.next(options);
//         },
//       ),
//       _RetryInterceptor(dio: dio),
//       if (kDebugMode) _LoggingInterceptor(),
//     ]);

//     return dio;
//   }
// }

// class _RetryInterceptor extends Interceptor {
//   final Dio dio;
//   static const int maxRetries = 2;

//   _RetryInterceptor({required this.dio});

//   @override
//   Future<void> onError(
//     DioException err,
//     ErrorInterceptorHandler handler,
//   ) async {
//     final requestOptions = err.requestOptions;
//     final retries = requestOptions.extra['retries'] ?? 0;

//     final shouldRetry =
//         err.type == DioExceptionType.connectionTimeout ||
//         err.type == DioExceptionType.receiveTimeout ||
//         err.type == DioExceptionType.connectionError;

//     if (shouldRetry && retries < maxRetries) {
//       requestOptions.extra['retries'] = retries + 1;

//       await Future.delayed(Duration(milliseconds: 500));

//       try {
//         final response = await dio.fetch(requestOptions);
//         return handler.resolve(response);
//       } catch (e) {
//         return handler.next(err);
//       }
//     }

//     handler.next(err);
//   }
// }

// class _LoggingInterceptor extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     debugPrint('➡️ ${options.method} ${options.uri}');
//     debugPrint('Headers: ${options.headers}');
//     debugPrint('Body: ${options.data}');
//     handler.next(options);
//   }

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     debugPrint('✅ ${response.statusCode} ${response.requestOptions.uri}');
//     handler.next(response);
//   }

//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     debugPrint('❌ ${err.requestOptions.uri}');
//     debugPrint('Error: ${err.message}');
//     handler.next(err);
//   }
// }

// String mapDioError(DioException e) {
//   switch (e.type) {
//     case DioExceptionType.connectionTimeout:
//       return 'Connection timed out. Please try again.';
//     case DioExceptionType.receiveTimeout:
//       return 'Server took too long to respond.';
//     case DioExceptionType.sendTimeout:
//       return 'Request timeout. Please retry.';
//     case DioExceptionType.badResponse:
//       return 'Server error (${e.response?.statusCode}).';
//     case DioExceptionType.connectionError:
//       return 'No internet connection.';
//     default:
//       return 'Something went wrong. Please try again.';
//   }
// }
