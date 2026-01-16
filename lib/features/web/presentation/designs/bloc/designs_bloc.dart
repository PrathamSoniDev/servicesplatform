import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/category_model.dart';
import '../../../../../models/design_item_models.dart';
import '../../../../../models/design_list_response.dart';
import '../../../../../services/design_repository.dart';
import 'designs_event.dart';
import 'designs_state.dart';

class DesignsBloc extends Bloc<DesignsEvent, DesignsState> {
  final DesignRepository repository;

  Timer? _searchDebounce;

  DesignsBloc(
    this.repository, {
    List<DesignItem>? initialDesigns,
    List<CategoryModel>? categories,
  }) : super(
         DesignsState(
           designs: initialDesigns ?? const [],
           allDesigns: initialDesigns ?? const [],
           categories: categories ?? const [],
           listStatus:
               initialDesigns != null && initialDesigns.isNotEmpty
                   ? DesignsStatus.success
                   : DesignsStatus.initial,
         ),
       ) {
    on<FetchDesigns>(_onFetchDesigns);
    on<FetchDesignsByCategory>(_onFetchByCategory);
    on<SearchDesigns>(_onSearchDesigns);
    on<FetchDesignDetail>(_onFetchDesignDetail);
    on<ToggleDesignLike>(_onToggleLike);
    on<IncrementDesignView>(_onIncrementView);
  }
  // ───────────────── FETCH DESIGNS ─────────────────

  Future<void> _onFetchDesigns(
    FetchDesigns event,
    Emitter<DesignsState> emit,
  ) async {
    // 🔒 Prevent refetch if already bootstrapped and not loadMore
    final isInitialBootstrap =
        !event.loadMore &&
        state.designs.isNotEmpty &&
        state.listStatus == DesignsStatus.success &&
        state.selectedCategory == null &&
        state.searchQuery.isEmpty;

    if (isInitialBootstrap) {
      return;
    }

    emit(
      state.copyWith(
        listStatus: DesignsStatus.loading,
        page: 1,
        hasMore: true,
        errorMessage: null,
      ),
    );

    try {
      final response = await repository.listDesigns(
        page: event.page,
        categoryId: state.selectedCategory,
      );
      final Map<String, String> categoryMap = {
        for (final c in state.categories) c.id: c.name,
      };
      final DesignListResponse enrichedDesigns = DesignListResponse(
        items:
            response.items
                .map(
                  (design) => design.copyWith(
                    categoryName: categoryMap[design.categoryId],
                  ),
                )
                .toList(),
        total: response.total,
        page: response.page,
        limit: response.limit,
        totalPages: response.totalPages,
      );
      emit(
        state.copyWith(
          listStatus: DesignsStatus.success,
          designs: enrichedDesigns.items,
          allDesigns: response.items, // 🔑 source list
          page: response.page,
          hasMore: response.page < response.totalPages,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          listStatus: DesignsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  // ───────────────── CATEGORY FILTER ─────────────────

  Future<void> _onFetchByCategory(
    FetchDesignsByCategory event,
    Emitter<DesignsState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedCategory: event.categoryId,
        designs: const [],
        allDesigns: const [],
        page: 1,
        hasMore: true,
        listStatus: DesignsStatus.loading,
      ),
    );

    add(const FetchDesigns());
  }

  // ───────────────── SEARCH (DEBOUNCED) ─────────────────

  void _onSearchDesigns(SearchDesigns event, Emitter<DesignsState> emit) {
    _searchDebounce?.cancel();

    _searchDebounce = Timer(const Duration(milliseconds: 450), () {
      final query = event.query.trim().toLowerCase();

      // 🔹 Clear search → restore full list
      if (query.isEmpty) {
        emit(state.copyWith(searchQuery: '', designs: state.allDesigns));
        return;
      }

      // 🔹 Filter locally
      final filtered =
          state.allDesigns.where((design) {
            final title = design.title?.toLowerCase() ?? '';
            final subtitle = design.subtitle?.toLowerCase() ?? '';
            final category = design.categoryName?.toLowerCase() ?? '';

            return title.contains(query) ||
                subtitle.contains(query) ||
                category.contains(query);
          }).toList();

      emit(state.copyWith(searchQuery: query, designs: filtered));
    });
  }

  // ───────────────── FETCH DETAIL ─────────────────

  Future<void> _onFetchDesignDetail(
    FetchDesignDetail event,
    Emitter<DesignsState> emit,
  ) async {
    emit(
      state.copyWith(detailStatus: DesignsStatus.loading, errorMessage: null),
    );

    try {
      final design = await repository.getDesignById(event.designId);
      emit(
        state.copyWith(
          detailStatus: DesignsStatus.success,
          selectedDesign: design,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          detailStatus: DesignsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  // ───────────────── TOGGLE LIKE ─────────────────

  Future<void> _onToggleLike(
    ToggleDesignLike event,
    Emitter<DesignsState> emit,
  ) async {
    try {
      // 1️⃣ Find design (from list or detail)
      final DesignItem? current = state.designs.firstWhere(
        (d) => d.id == event.designId,
        orElse: () => state.selectedDesign!,
      );

      if (current == null) return;

      // 2️⃣ Decide action based on user behavior
      final bool? isAlreadyLiked = current.isLiked;

      final DesignItem updated =
          isAlreadyLiked!
              ? await repository.decrementLikes(current.id)
              : await repository.incrementLikes(current.id);

      // 3️⃣ Update list + detail atomically
      emit(
        state.copyWith(
          designs:
              state.designs
                  .map((d) => d.id == updated.id ? updated : d)
                  .toList(),
          allDesigns:
              state.allDesigns
                  .map((d) => d.id == updated.id ? updated : d)
                  .toList(),
          selectedDesign:
              state.selectedDesign?.id == updated.id
                  ? updated
                  : state.selectedDesign,
        ),
      );
    } catch (e) {
      debugPrint('❌ ToggleDesignLike error: $e');
    }
  }

  // ───────────────── INCREMENT VIEW ─────────────────

  Future<void> _onIncrementView(
    IncrementDesignView event,
    Emitter<DesignsState> emit,
  ) async {
    try {
      await repository.incrementViews(event.designId);
    } catch (e) {
      debugPrint('❌ IncrementDesignView error: $e');
    }
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }
}
