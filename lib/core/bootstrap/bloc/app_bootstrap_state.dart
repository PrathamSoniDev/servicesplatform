import 'package:equatable/equatable.dart';

import '../app_bootstrap_model.dart';

enum AppBootstrapStatus { initial, loading, success, failure }

class AppBootstrapState extends Equatable {
  final AppBootstrapStatus status;
  final AppBootstrapModel? data;
  final String? error;

  const AppBootstrapState({
    this.status = AppBootstrapStatus.initial,
    this.data,
    this.error,
  });

  AppBootstrapState copyWith({
    AppBootstrapStatus? status,
    AppBootstrapModel? data,
    String? error,
  }) {
    return AppBootstrapState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, data, error];
}
