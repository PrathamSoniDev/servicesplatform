import 'package:flutter/material.dart';

import 'app_bootstrap_model.dart';
import 'app_bootstrap_repository.dart';

class AppBootstrapController extends ChangeNotifier {
  final AppBootstrapRepository repository;

  AppBootstrapController(this.repository);

  AppBootstrapModel? data;
  bool isLoading = true;
  String? error;

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      data = await repository.bootstrap();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
