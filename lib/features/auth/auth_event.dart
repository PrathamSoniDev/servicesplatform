part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// 🔐 Login Event
final class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

/// 📝 Register Event
final class AuthRegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const AuthRegisterRequested({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, password];
}

/// 🔄 Check Existing Login (Auto-Login)
final class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}

final class AuthProfileFetched extends AuthEvent {
  const AuthProfileFetched();
}

/// 🚪 Logout
final class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}
