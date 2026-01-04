import 'package:dio/dio.dart';
import 'package:servicesplatform/core/storage/cache_keys.dart';
import 'package:servicesplatform/core/storage/sqlite_cache.dart';
import 'package:servicesplatform/models/user_model.dart';
import 'package:servicesplatform/network/dio_client.dart';

class AuthRepository {
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final Response response = await DioClient.dio.post(
        "/api/auth/login/",
        data: {"email": email, "password": password},
      );

      final user = UserModel.fromJson(response.data['user']);

      final accessToken = response.data['accessToken'];
      await SQLiteCache.save(CacheKeys.accessToken, accessToken);

      return user;
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final Response response = await DioClient.dio.post(
        "/api/auth/register/",
        data: {"name": name, "email": email, "password": password},
      );
      final user = UserModel.fromJson(response.data['user']);

      final accessToken = response.data['accessToken'];
      await SQLiteCache.save(CacheKeys.accessToken, accessToken);

      return user;
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  String _handleDioError(DioException e) {
    if (e.response != null) {
      return e.response?.data['message'] ?? "Authentication failed";
    } else {
      return "Network error. Please try again.";
    }
  }

  Future<String> getAccessToken() async {
    const timeDuration = Duration(days: 365);
    return await SQLiteCache.load(CacheKeys.accessToken, maxAge: timeDuration);
  }
}
