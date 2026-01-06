import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../../../../services/blog_repository.dart';
import 'blog_event.dart';
import 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogRepository repository;

  BlogBloc(this.repository) : super(const BlogState()) {
    on<FetchBlogs>(_onFetchBlogs);
    on<FetchBlogDetail>(_onFetchBlogDetail);
    on<ToggleBlogLike>(_onToggleLike);
    on<ToggleBlogBookmark>(_onToggleBookmark);
    on<AddBlogComment>(_onAddComment);
  }

  // ───────────────────────── FETCH BLOGS ─────────────────────────

  Future<void> _onFetchBlogs(FetchBlogs event, Emitter<BlogState> emit) async {
    if (!event.loadMore) {
      emit(
        state.copyWith(
          listStatus: BlogStatus.loading,
          page: 1,
          hasMore: true,
          errorMessage: null,
        ),
      );
    }

    try {
      final response = await repository.listBlogs(
        page: event.page,
        categoryId: event.categoryId,
      );

      final newBlogs =
          event.loadMore ? [...state.blogs, ...response.items] : response.items;

      emit(
        state.copyWith(
          listStatus: BlogStatus.success,
          blogs: newBlogs,
          page: response.page,
          hasMore: response.page < response.totalPages,
        ),
      );
    } catch (e) {
      debugPrint('❌ FetchBlogs error: $e');
      emit(
        state.copyWith(
          listStatus: BlogStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  // ───────────────────────── BLOG DETAIL ─────────────────────────

  Future<void> _onFetchBlogDetail(
    FetchBlogDetail event,
    Emitter<BlogState> emit,
  ) async {
    emit(state.copyWith(detailStatus: BlogStatus.loading, errorMessage: null));

    try {
      final blog = await repository.getBlogById(event.blogId);

      emit(
        state.copyWith(detailStatus: BlogStatus.success, selectedBlog: blog),
      );
    } catch (e) {
      debugPrint('❌ FetchBlogDetail error: $e');
      emit(
        state.copyWith(
          detailStatus: BlogStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  // ───────────────────────── TOGGLE LIKE ─────────────────────────

  Future<void> _onToggleLike(
    ToggleBlogLike event,
    Emitter<BlogState> emit,
  ) async {
    try {
      final result = await repository.toggleLike(event.blogId);

      if (state.selectedBlog?.id == event.blogId) {
        emit(
          state.copyWith(
            selectedBlog: state.selectedBlog!.copyWith(isLiked: result.isLiked),
          ),
        );
      }
    } catch (e) {
      debugPrint('❌ ToggleLike error: $e');
    }
  }

  // ───────────────────────── TOGGLE BOOKMARK ─────────────────────────

  Future<void> _onToggleBookmark(
    ToggleBlogBookmark event,
    Emitter<BlogState> emit,
  ) async {
    try {
      final result = await repository.toggleBookmark(event.blogId);

      if (state.selectedBlog?.id == event.blogId) {
        emit(
          state.copyWith(
            selectedBlog: state.selectedBlog!.copyWith(
              isBookmarked: result.isBookmarked,
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint('❌ ToggleBookmark error: $e');
    }
  }

  // ───────────────────────── ADD COMMENT ─────────────────────────

  Future<void> _onAddComment(
    AddBlogComment event,
    Emitter<BlogState> emit,
  ) async {
    try {
      final comment = await repository.addComment(
        blogId: event.blogId,
        comment: event.comment,
        rating: event.rating,
      );

      if (state.selectedBlog?.id == event.blogId) {
        final updatedComments = [...state.selectedBlog!.comments, comment];

        emit(
          state.copyWith(
            selectedBlog: state.selectedBlog!.copyWith(
              comments: updatedComments,
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint('❌ AddComment error: $e');
    }
  }
}
