import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/web/presentation/home/custom_shimmer.dart';
import 'app_bootstrap_controller.dart';
import 'app_bootstrap_model.dart';

class AppBootstrapBuilder extends StatelessWidget {
  const AppBootstrapBuilder({super.key, required this.builder});

  final Widget Function(BuildContext, AppBootstrapModel data) builder;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppBootstrapController>(
      builder: (context, controller, _) {
        if (controller.isLoading) {
          return const AdaptiveShimmer(layout: ShimmerLayout.hero);
        }

        if (controller.error != null) {
          return Center(
            child: Text(
              'Failed to load app data',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          );
        }

        return builder(context, controller.data!);
      },
    );
  }
}
