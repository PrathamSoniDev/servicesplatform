import 'package:equatable/equatable.dart';

abstract class DesignsEvent extends Equatable {
  const DesignsEvent();

  @override
  List<Object?> get props => [];
}

/// Fetch designs (initial / pagination)
class FetchDesigns extends DesignsEvent {
  final int page;
  final bool loadMore;

  const FetchDesigns({this.page = 1, this.loadMore = false});

  @override
  List<Object?> get props => [page, loadMore];
}

/// Filter designs by category
class FetchDesignsByCategory extends DesignsEvent {
  final String? categoryId;

  const FetchDesignsByCategory(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

/// Search designs (debounce-ready)
class SearchDesigns extends DesignsEvent {
  final String query;

  const SearchDesigns(this.query);

  @override
  List<Object?> get props => [query];
}

/// Fetch single design
class FetchDesignDetail extends DesignsEvent {
  final String designId;

  const FetchDesignDetail(this.designId);

  @override
  List<Object?> get props => [designId];
}

/// Like / Unlike design
class ToggleDesignLike extends DesignsEvent {
  final String designId;
  final int delta;

  const ToggleDesignLike(this.designId, {this.delta = 1});

  @override
  List<Object?> get props => [designId, delta];
}

/// Increment views (fire & forget)
class IncrementDesignView extends DesignsEvent {
  final String designId;

  const IncrementDesignView(this.designId);

  @override
  List<Object?> get props => [designId];
}
