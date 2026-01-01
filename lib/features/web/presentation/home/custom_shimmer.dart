import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

enum ShimmerLayout { hero, card, list, custom }

class AdaptiveShimmer extends StatelessWidget {
  const AdaptiveShimmer({
    super.key,
    this.layout = ShimmerLayout.hero,
    this.lines = 3,
    this.showAvatar = false,
    this.customChild,
  });

  /// Preset layout type
  final ShimmerLayout layout;

  /// Number of text lines (for list / card)
  final int lines;

  /// Optional avatar / image placeholder
  final bool showAvatar;

  /// Custom shimmer child (advanced use)
  final Widget? customChild;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final baseColor = isDark ? Colors.grey.shade800 : Colors.grey.shade300;
    final highlightColor = isDark ? Colors.grey.shade600 : Colors.grey.shade100;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: customChild ?? _buildLayout(context, size),
    );
  }

  Widget _buildLayout(BuildContext context, Size size) {
    switch (layout) {
      case ShimmerLayout.hero:
        return _heroSkeleton(size);
      case ShimmerLayout.card:
        return _cardSkeleton(size);
      case ShimmerLayout.list:
        return _listSkeleton(size);
      case ShimmerLayout.custom:
        return const SizedBox.shrink();
    }
  }

  // ================= HERO =================
  Widget _heroSkeleton(Size size) {
    final width = size.width;
    final isMobile = width < 700;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _line(width * 0.3, 14),
        const SizedBox(height: 20),

        _line(width * (isMobile ? 0.85 : 0.6), 48),
        const SizedBox(height: 12),

        _line(width * (isMobile ? 0.65 : 0.45), 40),
        const SizedBox(height: 28),

        _line(width * 0.9, 16),
      ],
    );
  }

  // ================= CARD =================
  Widget _cardSkeleton(Size size) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showAvatar)
            Row(
              children: [
                _circle(44),
                const SizedBox(width: 12),
                Expanded(child: _line(size.width * 0.4, 14)),
              ],
            ),
          const SizedBox(height: 16),
          ...List.generate(
            lines,
            (i) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _line(size.width * (0.8 - i * 0.1), 14),
            ),
          ),
        ],
      ),
    );
  }

  // ================= LIST =================
  Widget _listSkeleton(Size size) {
    return Column(
      children: List.generate(
        lines,
        (_) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              if (showAvatar) _circle(40),
              if (showAvatar) const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _line(size.width * 0.7, 14),
                    const SizedBox(height: 8),
                    _line(size.width * 0.5, 12),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= HELPERS =================
  Widget _line(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(height / 2),
      ),
    );
  }

  Widget _circle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
    );
  }
}
