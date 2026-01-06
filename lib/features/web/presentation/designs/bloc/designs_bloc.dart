import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../../../../services/design_repository.dart';
import 'designs_event.dart';
import 'designs_state.dart';

class DesignsBloc extends Bloc<DesignsEvent, DesignsState> {
  final DesignRepository repository;

  Timer? _searchDebounce;

  DesignsBloc(this.repository) : super(const DesignsState()) {
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
    if (!event.loadMore) {
      emit(
        state.copyWith(
          listStatus: DesignsStatus.loading,
          page: 1,
          hasMore: true,
          errorMessage: null,
        ),
      );
    }

    try {
      final response = await repository.listDesigns(
        page: event.page,
        categoryId: state.selectedCategory,
      );

      final designs =
          event.loadMore
              ? [...state.designs, ...response.items]
              : response.items;

      emit(
        state.copyWith(
          listStatus: DesignsStatus.success,
          designs: designs,
          page: response.page,
          hasMore: response.page < response.totalPages,
        ),
      );
    } catch (e) {
      debugPrint('❌ FetchDesigns error: $e');
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
        page: 1,
        hasMore: true,
      ),
    );

    add(const FetchDesigns());
  }

  // ───────────────── SEARCH (DEBOUNCED) ─────────────────

  void _onSearchDesigns(SearchDesigns event, Emitter<DesignsState> emit) {
    _searchDebounce?.cancel();

    _searchDebounce = Timer(const Duration(milliseconds: 450), () {
      emit(state.copyWith(searchQuery: event.query, page: 1, hasMore: true));
      add(const FetchDesigns());
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
      final updated = await repository.incrementLikes(
        event.designId,
        delta: event.delta,
      );

      emit(
        state.copyWith(
          designs:
              state.designs
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
