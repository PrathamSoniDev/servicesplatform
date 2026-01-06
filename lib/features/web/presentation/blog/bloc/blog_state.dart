import 'package:equatable/equatable.dart';

import '../../../../../models/blog_model.dart';

enum BlogStatus { initial, loading, success, failure }

class BlogState extends Equatable {
  /// List
  final BlogStatus listStatus;
  final List<BlogModel> blogs;
  final int page;
  final bool hasMore;

  /// Detail
  final BlogStatus detailStatus;
  final BlogModel? selectedBlog;

  /// Error
  final String? errorMessage;

  const BlogState({
    this.listStatus = BlogStatus.initial,
    this.blogs = const [],
    this.page = 1,
    this.hasMore = true,
    this.detailStatus = BlogStatus.initial,
    this.selectedBlog,
    this.errorMessage,
  });

  BlogState copyWith({
    BlogStatus? listStatus,
    List<BlogModel>? blogs,
    int? page,
    bool? hasMore,
    BlogStatus? detailStatus,
    BlogModel? selectedBlog,
    String? errorMessage,
  }) {
    return BlogState(
      listStatus: listStatus ?? this.listStatus,
      blogs: blogs ?? this.blogs,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      detailStatus: detailStatus ?? this.detailStatus,
      selectedBlog: selectedBlog ?? this.selectedBlog,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    listStatus,
    blogs,
    page,
    hasMore,
    detailStatus,
    selectedBlog,
    errorMessage,
  ];
}
