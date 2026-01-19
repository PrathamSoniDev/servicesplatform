import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_bootstrap_repository.dart';
import 'app_bootstrap_event.dart';
import 'app_bootstrap_state.dart';

class AppBootstrapBloc extends Bloc<AppBootstrapEvent, AppBootstrapState> {
  final AppBootstrapRepository repository;

  AppBootstrapBloc(this.repository) : super(const AppBootstrapState()) {
    on<LoadAppBootstrap>(_onLoad);
    on<RetryAppBootstrap>(_onLoad);
    on<LoadUserProfile>(_onLoadProfile);
  }

  Future<void> _onLoad(
    AppBootstrapEvent event,
    Emitter<AppBootstrapState> emit,
  ) async {
    emit(state.copyWith(status: AppBootstrapStatus.loading));

    try {
      final data = await repository.bootstrap();
      emit(state.copyWith(status: AppBootstrapStatus.success, data: data));
    } catch (e) {
      emit(
        state.copyWith(status: AppBootstrapStatus.failure, error: e.toString()),
      );
    }
  }

  Future<void> _onLoadProfile(
    LoadUserProfile event,
    Emitter<AppBootstrapState> emit,
  ) async {
    // Only update profile — do NOT touch other data
    if (state.data == null) return;

    try {
      final profile = await repository.fetchUserProfile(state.data!.category);

      emit(state.copyWith(data: state.data!.copyWith(profile: profile)));
    } catch (e) {
      debugPrint("❌ Profile refresh failed: $e");
    }
  }
}
