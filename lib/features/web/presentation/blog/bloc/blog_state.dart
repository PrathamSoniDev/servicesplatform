import 'package:equatable/equatable.dart';
import 'package:servicesplatform/models/category_model.dart';

import '../../../../../models/blog_model.dart';

enum BlogStatus { initial, loading, success, failure }

class BlogState extends Equatable {
  final BlogStatus listStatus;
  final BlogStatus detailStatus;
  final List<CategoryModel> categories;
  final List<BlogModel> blogs; // filtered list (UI)
  final List<BlogModel> allBlogs; // source list (bootstrap / API)

  final int page;
  final bool hasMore;

  final String? selectedCategory;
  final String searchQuery;

  final BlogModel? selectedBlog;
  final String? errorMessage;

  const BlogState({
    this.listStatus = BlogStatus.initial,
    this.detailStatus = BlogStatus.initial,
    this.blogs = const [],
    this.categories = const [],
    this.allBlogs = const [],
    this.page = 1,
    this.hasMore = true,
    this.selectedCategory,
    this.searchQuery = '',
    this.selectedBlog,
    this.errorMessage,
  });

  BlogState copyWith({
    BlogStatus? listStatus,
    BlogStatus? detailStatus,
    List<CategoryModel>? categories,
    List<BlogModel>? blogs,
    List<BlogModel>? allBlogs,
    int? page,
    bool? hasMore,
    String? selectedCategory,
    String? searchQuery,
    BlogModel? selectedBlog,
    String? errorMessage,
  }) {
    return BlogState(
      listStatus: listStatus ?? this.listStatus,
      detailStatus: detailStatus ?? this.detailStatus,
      blogs: blogs ?? this.blogs,
      allBlogs: allBlogs ?? this.allBlogs,
      categories: categories ?? this.categories,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedBlog: selectedBlog ?? this.selectedBlog,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    listStatus,
    detailStatus,
    blogs,
    allBlogs,
    page,
    hasMore,
    selectedCategory,
    searchQuery,
    selectedBlog,
    errorMessage,
    categories,
  ];
}
