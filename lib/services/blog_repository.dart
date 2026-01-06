import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/blog_interaction_result.dart';
import '../models/blog_model.dart';
import '../models/paginated_blogs.dart';
import '../network/dio_client.dart';

class BlogRepository {
  final Dio _dio = DioClient.dio;

  Future<PaginatedBlogs> listBlogs({
    int page = 1,
    int limit = 10,
    String? categoryId,
  }) async {
    try {
      final response = await _dio.get(
        '/api/blogs/',
        queryParameters: {
          'page': page,
          'limit': limit,
          if (categoryId != null) 'category': categoryId,
        },
      );

      debugPrint('✅ listBlogs response: ${response.data}');

      return PaginatedBlogs.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ listBlogs error: ${e.response?.data}');
      throw Exception(_extractError(e));
    }
  }

  Future<BlogModel> getBlogById(String blogId) async {
    try {
      final response = await _dio.get('/api/blogs/$blogId');

      debugPrint('✅ getBlogById response: ${response.data}');
      return BlogModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ getBlogById error: ${e.response?.data}');
      throw Exception(_extractError(e));
    }
  }

  // ───────────────────────────── TOGGLE LIKE ─────────────────────────────

  Future<BlogInteractionResult> toggleLike(String blogId) async {
    try {
      final response = await _dio.post('/api/blogs/$blogId/like');

      debugPrint('✅ toggleLike response: ${response.data}');
      return BlogInteractionResult.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ toggleLike error: ${e.response?.data}');
      throw Exception(_extractError(e));
    }
  }

  // ───────────────────────────── TOGGLE BOOKMARK ─────────────────────────────

  Future<BlogInteractionResult> toggleBookmark(String blogId) async {
    try {
      final response = await _dio.post('/api/blogs/$blogId/bookmark');

      debugPrint('✅ toggleBookmark response: ${response.data}');
      return BlogInteractionResult.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ toggleBookmark error: ${e.response?.data}');
      throw Exception(_extractError(e));
    }
  }

  // ───────────────────────────── ADD COMMENT ─────────────────────────────

  Future<BlogComment> addComment({
    required String blogId,
    required String comment,
    int? rating,
  }) async {
    try {
      debugPrint('📡 POST /api/blogs/$blogId/comments');

      final response = await _dio.post(
        '/api/blogs/$blogId/comments',
        data: {'comment': comment, if (rating != null) 'rating': rating},
      );

      debugPrint('✅ addComment response: ${response.data}');
      return BlogComment.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ addComment error: ${e.response?.data}');
      throw Exception(_extractError(e));
    }
  }

  String _extractError(DioException e) {
    final data = e.response?.data;
    if (data is Map<String, dynamic>) {
      return data['message'] ?? data['error'] ?? 'Unexpected server error';
    }
    return e.message ?? 'Network error';
  }
}
