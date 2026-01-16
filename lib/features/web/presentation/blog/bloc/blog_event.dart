import 'package:equatable/equatable.dart';

abstract class BlogEvent extends Equatable {
  const BlogEvent();

  @override
  List<Object?> get props => [];
}

/// Load paginated blogs (initial / load more)
class FetchBlogs extends BlogEvent {
  final int page;
  final String? categoryId;
  final bool loadMore;

  const FetchBlogs({this.page = 1, this.categoryId, this.loadMore = false});

  @override
  List<Object?> get props => [page, categoryId, loadMore];
}

/// Fetch a single blog by ID
class FetchBlogDetail extends BlogEvent {
  final String blogId;

  const FetchBlogDetail(this.blogId);

  @override
  List<Object?> get props => [blogId];
}

/// Toggle like on blog
class ToggleBlogLike extends BlogEvent {
  final String blogId;

  const ToggleBlogLike(this.blogId);

  @override
  List<Object?> get props => [blogId];
}

/// Toggle bookmark on blog
class ToggleBlogBookmark extends BlogEvent {
  final String blogId;

  const ToggleBlogBookmark(this.blogId);

  @override
  List<Object?> get props => [blogId];
}

/// Add a comment
class AddBlogComment extends BlogEvent {
  final String blogId;
  final String comment;
  final int? rating;

  const AddBlogComment({
    required this.blogId,
    required this.comment,
    this.rating,
  });

  @override
  List<Object?> get props => [blogId, comment, rating];
}

class FetchBlogsByCategory extends BlogEvent {
  final String? categoryId;
  const FetchBlogsByCategory(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class SearchBlogs extends BlogEvent {
  final String query;
  const SearchBlogs(this.query);

  @override
  List<Object?> get props => [query];
}
