import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_bootstrap_repository.dart';
import 'app_bootstrap_event.dart';
import 'app_bootstrap_state.dart';

class AppBootstrapBloc extends Bloc<AppBootstrapEvent, AppBootstrapState> {
  final AppBootstrapRepository repository;

  AppBootstrapBloc(this.repository) : super(const AppBootstrapState()) {
    on<LoadAppBootstrap>(_onLoad);
    on<RetryAppBootstrap>(_onLoad);
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
}
