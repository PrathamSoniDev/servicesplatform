import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:servicesplatform/core/storage/cache_keys.dart';
import 'package:servicesplatform/core/storage/sqlite_cache.dart';
import 'package:servicesplatform/models/profile_model.dart';
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
      debugPrint("AccessToken found on login :$accessToken");
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

    try {
      final token = await SQLiteCache.load(
        CacheKeys.accessToken,
        maxAge: timeDuration,
      );

      return token ?? '';
    } catch (e) {
      debugPrint("⚠️ Token not found in cache: $e");
      return '';
    }
  }

  Future<ProfileModel> getUserProfile() async {
    try {
      final String accessToken = await getAccessToken();
      final Response response = await DioClient.dio.get(
        "/api/profiles/me",
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );
      final profile = ProfileModel.fromJson(response.data);
      debugPrint("Debugging the profile data :${response.data}");
      return profile;
    } catch (e) {
      debugPrint("Error while fetching the Profile :$e");
      throw Exception("Error while fetching the Profile :$e");
    }
  }
}
