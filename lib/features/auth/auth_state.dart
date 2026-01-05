part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, failure }

class AuthState extends Equatable {
  final AuthStatus status;
  final UserModel? user;
  final String? errorMessage;
  final ProfileModel? profile;
  const AuthState({
    required this.status,
    this.user,
    this.errorMessage,
    this.profile,
  });

  /// 🔹 Initial state
  factory AuthState.initial() {
    return const AuthState(status: AuthStatus.initial);
  }

  /// 🔹 copyWith for state updates
  AuthState copyWith({
    AuthStatus? status,
    UserModel? user,
    String? errorMessage,
    ProfileModel? profile,
    bool clearUser = false,
    bool clearError = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: clearUser ? null : user ?? this.user,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      profile: profile ?? this.profile,
    );
  }

  @override
  List<Object?> get props => [status, user, errorMessage, profile];
}
