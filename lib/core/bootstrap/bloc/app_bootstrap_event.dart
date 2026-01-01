import 'package:equatable/equatable.dart';

abstract class AppBootstrapEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAppBootstrap extends AppBootstrapEvent {}

class RetryAppBootstrap extends AppBootstrapEvent {}
