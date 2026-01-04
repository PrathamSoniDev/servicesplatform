import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:servicesplatform/core/storage/cache_keys.dart';
import 'package:servicesplatform/core/storage/sqlite_cache.dart';
import 'package:servicesplatform/models/user_model.dart';

import '../../services/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthState.initial()) {
    on<AuthLoginRequested>(_onLogin);
    on<AuthRegisterRequested>(_onRegister);
    on<AuthCheckRequested>(_onCheckAuth);
    on<AuthLogoutRequested>(_onLogout);
  }

  /// 🔐 LOGIN
  Future<void> _onLogin(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, clearError: true));

    try {
      final user = await _authRepository.login(
        email: event.email,
        password: event.password,
      );

      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  /// 📝 REGISTER
  Future<void> _onRegister(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, clearError: true));

    try {
      final user = await _authRepository.register(
        name: event.name,
        email: event.email,
        password: event.password,
      );

      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  /// 🔄 AUTO LOGIN (TOKEN CHECK)
  Future<void> _onCheckAuth(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final token = await _authRepository.getAccessToken();

      if (token.isNotEmpty) {
        // 🔹 Optional: fetch profile here
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      } else {
        emit(
          state.copyWith(status: AuthStatus.unauthenticated, clearUser: true),
        );
      }
    } catch (_) {
      emit(state.copyWith(status: AuthStatus.unauthenticated, clearUser: true));
    }
  }

  /// 🚪 LOGOUT
  Future<void> _onLogout(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await SQLiteCache.clear(CacheKeys.accessToken);

    emit(
      state.copyWith(
        status: AuthStatus.unauthenticated,
        clearUser: true,
        clearError: true,
      ),
    );
  }
}
