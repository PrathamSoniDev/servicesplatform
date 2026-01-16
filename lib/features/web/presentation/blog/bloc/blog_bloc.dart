import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../../models/blog_model.dart';
import '../../../../../services/blog_repository.dart';
import 'blog_event.dart';
import 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogRepository repository;
  Timer? _searchDebounce;

  BlogBloc(this.repository, {List<BlogModel>? initialBlogs})
    : super(
        BlogState(
          blogs: initialBlogs ?? const [],
          allBlogs: initialBlogs ?? const [],
          listStatus:
              initialBlogs != null && initialBlogs.isNotEmpty
                  ? BlogStatus.success
                  : BlogStatus.initial,
        ),
      ) {
    on<FetchBlogs>(_onFetchBlogs);
    on<FetchBlogsByCategory>(_onFetchByCategory);
    on<SearchBlogs>(_onSearchBlogs);
    on<FetchBlogDetail>(_onFetchBlogDetail);
    on<ToggleBlogLike>(_onToggleLike);
    on<ToggleBlogBookmark>(_onToggleBookmark);
    on<AddBlogComment>(_onAddComment);
  }

  // ───────────────── FETCH BLOGS ─────────────────

  Future<void> _onFetchBlogs(FetchBlogs event, Emitter<BlogState> emit) async {
    final isInitialBootstrap =
        !event.loadMore &&
        state.allBlogs.isNotEmpty &&
        state.selectedCategory == null &&
        state.searchQuery.isEmpty;

    if (isInitialBootstrap) return;

    emit(state.copyWith(listStatus: BlogStatus.loading));

    try {
      final response = await repository.listBlogs(
        page: event.page,
        categoryId: state.selectedCategory,
      );

      emit(
        state.copyWith(
          listStatus: BlogStatus.success,
          blogs: response.items,
          allBlogs: response.items,
          page: response.page,
          hasMore: response.page < response.totalPages,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          listStatus: BlogStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  // ───────────────── CATEGORY FILTER ─────────────────

  void _onFetchByCategory(FetchBlogsByCategory event, Emitter<BlogState> emit) {
    final filtered =
        event.categoryId == null
            ? state.allBlogs
            : state.allBlogs
                .where((b) => b.categoryId == event.categoryId)
                .toList();

    emit(state.copyWith(selectedCategory: event.categoryId, blogs: filtered));
  }

  // ───────────────── SEARCH (LOCAL) ─────────────────

  void _onSearchBlogs(SearchBlogs event, Emitter<BlogState> emit) {
    _searchDebounce?.cancel();

    _searchDebounce = Timer(const Duration(milliseconds: 400), () {
      final query = event.query.trim().toLowerCase();

      if (query.isEmpty) {
        emit(state.copyWith(searchQuery: '', blogs: state.allBlogs));
        return;
      }

      final filtered =
          state.allBlogs.where((blog) {
            final title = blog.title.toLowerCase();
            final desc = blog.shortDescription.toLowerCase();
            final category = blog.categoryName.toLowerCase();

            return title.contains(query) ||
                desc.contains(query) ||
                category.contains(query);
          }).toList();

      emit(state.copyWith(searchQuery: query, blogs: filtered));
    });
  }

  // ───────────────── BLOG DETAIL ─────────────────

  Future<void> _onFetchBlogDetail(
    FetchBlogDetail event,
    Emitter<BlogState> emit,
  ) async {
    emit(state.copyWith(detailStatus: BlogStatus.loading));

    try {
      final blog = await repository.getBlogById(event.blogId);
      emit(
        state.copyWith(detailStatus: BlogStatus.success, selectedBlog: blog),
      );
    } catch (e) {
      emit(
        state.copyWith(
          detailStatus: BlogStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  // ───────────────── LIKE / BOOKMARK / COMMENT ─────────────────

  Future<void> _onToggleLike(
    ToggleBlogLike event,
    Emitter<BlogState> emit,
  ) async {
    final result = await repository.toggleLike(event.blogId);
    if (state.selectedBlog?.id == event.blogId) {
      emit(
        state.copyWith(
          selectedBlog: state.selectedBlog!.copyWith(isLiked: result.isLiked),
        ),
      );
    }
  }

  Future<void> _onToggleBookmark(
    ToggleBlogBookmark event,
    Emitter<BlogState> emit,
  ) async {
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
  }

  Future<void> _onAddComment(
    AddBlogComment event,
    Emitter<BlogState> emit,
  ) async {
    final comment = await repository.addComment(
      blogId: event.blogId,
      comment: event.comment,
      rating: event.rating,
    );

    emit(
      state.copyWith(
        selectedBlog: state.selectedBlog?.copyWith(
          comments: [...state.selectedBlog!.comments, comment],
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }
}
