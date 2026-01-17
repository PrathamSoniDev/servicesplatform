import 'package:equatable/equatable.dart';

import '../../../../../models/category_model.dart';
import '../../../../../models/design_item_models.dart';

enum DesignsStatus { initial, loading, success, failure }

// ignore: must_be_immutable
class DesignsState extends Equatable {
  final DesignsStatus listStatus;
  final List<DesignItem> designs;
  final List<DesignItem> allDesigns;
  final List<CategoryModel> categories;
  final int page;
  final bool hasMore;

  final String? selectedCategory;
  final String searchQuery;

  final DesignsStatus detailStatus;
  late DesignItem? selectedDesign;

  final String? errorMessage;

  DesignsState({
    this.listStatus = DesignsStatus.initial,
    this.allDesigns = const [],
    this.categories = const [],
    this.designs = const [],
    this.page = 1,
    this.hasMore = true,
    this.selectedCategory,
    this.searchQuery = '',
    this.detailStatus = DesignsStatus.initial,
    this.selectedDesign,
    this.errorMessage,
  });

  DesignsState copyWith({
    DesignsStatus? listStatus,
    List<DesignItem>? designs,
    List<DesignItem>? allDesigns,
    List<CategoryModel>? categories,
    int? page,
    bool? hasMore,
    String? selectedCategory,
    String? searchQuery,
    DesignsStatus? detailStatus,
    DesignItem? selectedDesign,
    String? errorMessage,
  }) {
    return DesignsState(
      listStatus: listStatus ?? this.listStatus,
      designs: designs ?? this.designs,
      categories: categories ?? this.categories,
      page: page ?? this.page,
      allDesigns: allDesigns ?? this.allDesigns,
      hasMore: hasMore ?? this.hasMore,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      detailStatus: detailStatus ?? this.detailStatus,
      selectedDesign: selectedDesign ?? this.selectedDesign,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    listStatus,
    designs,
    page,
    hasMore,
    selectedCategory,
    searchQuery,
    detailStatus,
    selectedDesign,
    errorMessage,
  ];
}
