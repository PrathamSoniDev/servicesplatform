import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:servicesplatform/services/auth_repository.dart';

import '../models/design_feedback_response.dart';
import '../models/design_item_models.dart';
import '../models/design_list_response.dart';
import '../network/dio_client.dart';

class DesignRepository {
  final Dio _dio = DioClient.dio;

  Future<DesignListResponse> listDesigns({
    int page = 1,
    int limit = 10,
    String? categoryId,
  }) async {
    try {
      final response = await _dio.get(
        '/api/designs',
        queryParameters: {
          'page': page,
          'limit': limit,
          if (categoryId != null) 'categoryId': categoryId,
        },
      );

      debugPrint('📦 Raw designs response: ${response.data}');

      /// 🔥 FIX: Decode if backend sent JSON as String
      final dynamic data =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (data is! Map<String, dynamic>) {
        throw Exception('Invalid designs response format');
      }

      return DesignListResponse.fromJson(data);
    } on DioException catch (e) {
      debugPrint('❌ listDesigns error: ${e.response?.data}');
      throw Exception(_extractError(e));
    }
  }

  Future<DesignItem> getDesignById(String id) async {
    try {
      debugPrint('📡 GET /api/designs/$id');

      final response = await _dio.get('/api/designs/$id');
      return DesignItem.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(_extractError(e));
    }
  }

  Future<DesignItem> incrementLikes(String id, {int delta = 1}) async {
    try {
      debugPrint('📡 PATCH /api/designs/$id/likes');

      final response = await _dio.patch(
        '/api/designs/$id/likes',
        data: {'delta': delta},
      );
      return DesignItem.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(_extractError(e));
    }
  }

  Future<DesignItem> incrementViews(String id) async {
    try {
      debugPrint('📡 PATCH /api/designs/$id/views');

      final response = await _dio.patch('/api/designs/$id/views');
      return DesignItem.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(_extractError(e));
    }
  }

  Future<DesignFeedback> submitFeedback({
    required String designId,
    required int rating,
    required String feedbackText,
  }) async {
    try {
      debugPrint('📡 POST /api/designs/$designId/feedback');
      final String accessToken = await AuthRepository().getAccessToken();
      final response = await _dio.post(
        '/api/designs/$designId/feedback',
        data: {'rating': rating, 'feedbackText': feedbackText},
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );

      debugPrint('✅ submitFeedback response: ${response.data}');
      return DesignFeedback.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ submitFeedback error: ${e.response?.data}');
      throw Exception(_extractError(e));
    }
  }

  Future<DesignFeedbackListResponse> listFeedbacksByDesign(
    String designId, {
    int page = 1,
    int limit = 10,
  }) async {
    try {
      debugPrint('📡 GET /api/designs/$designId/feedback');

      final response = await _dio.get(
        '/api/designs/$designId/feedback',
        queryParameters: {'page': page, 'limit': limit},
      );

      debugPrint('✅ listFeedbacks response: ${response.data}');
      return DesignFeedbackListResponse.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ listFeedbacks error: ${e.response?.data}');
      throw Exception(_extractError(e));
    }
  }

  String _extractError(DioException e) {
    if (e.response?.data is Map<String, dynamic>) {
      return e.response?.data['message'] ??
          e.response?.data['error'] ??
          'Server error';
    }
    return e.message ?? 'Network error';
  }
}
