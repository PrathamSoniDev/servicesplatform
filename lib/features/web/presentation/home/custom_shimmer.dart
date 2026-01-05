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

  final ShimmerLayout layout;
  final int lines;
  final bool showAvatar;
  final Widget? customChild;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    // ULTRA-PREMIUM PALETTE
    // Using deep charcoal and subtle slate-silver for a metallic finish
    const baseColor = Color(0xFF0A0A0A);      // Near Black
    const highlightColor = Color(0xFF1F1F23); // Gunmetal Highlight
    
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      period: const Duration(milliseconds: 2200), // Slightly slower is more "prestigious"
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

  // ================= ULTRA-LUXURY HERO =================
  Widget _heroSkeleton(Size size) {
    final width = size.width;
    final isMobile = width < 700;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : width * 0.1, 
        vertical: 80
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Elegant Badge/Tag
          _line(90, 24, radius: 100, opacity: 0.15),
          const SizedBox(height: 32),

          // Layered Typography
          _line(width * (isMobile ? 0.8 : 0.4), 64, radius: 12),
          const SizedBox(height: 16),
          _line(width * (isMobile ? 0.6 : 0.3), 64, radius: 12),
          const SizedBox(height: 40),

          // Multi-line Descriptive Block (More lines = More Premium)
          _line(width * (isMobile ? 0.9 : 0.45), 14, opacity: 0.3, radius: 4),
          const SizedBox(height: 10),
          _line(width * (isMobile ? 0.85 : 0.4), 14, opacity: 0.3, radius: 4),
          const SizedBox(height: 10),
          _line(width * (isMobile ? 0.7 : 0.35), 14, opacity: 0.2, radius: 4),
          
          const SizedBox(height: 60),

          // Sophisticated Interactive Elements
          Row(
            children: [
              _line(180, 56, radius: 12), // Bold Button
              const SizedBox(width: 20),
              _line(56, 56, radius: 12, opacity: 0.1), // Square Utility Button
            ],
          ),
        ],
      ),
    );
  }

  // ================= GLASS-DECO CARD =================
  Widget _cardSkeleton(Size size) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.03), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showAvatar)
            Row(
              children: [
                _circle(56),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _line(140, 16, radius: 4),
                    const SizedBox(height: 8),
                    _line(90, 12, opacity: 0.3, radius: 4),
                  ],
                ),
                const Spacer(),
                _line(24, 24, radius: 6, opacity: 0.1), // Tiny icon placeholder
              ],
            ),
          const SizedBox(height: 32),
          _line(size.width * 0.6, 24, radius: 6), // Bold Title
          const SizedBox(height: 20),
          
          // Paragraph structure
          ...List.generate(
            lines,
            (i) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _line(
                size.width * (0.85 - (i * 0.1)), 
                12, 
                opacity: 0.2, 
                radius: 4
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          // Metadata line
          _line(100, 12, radius: 4, opacity: 0.1),
        ],
      ),
    );
  }

  // ================= MINIMALIST LIST =================
  Widget _listSkeleton(Size size) {
    return Column(
      children: List.generate(
        lines,
        (index) => Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Row(
            children: [
              if (showAvatar) _circle(52),
              if (showAvatar) const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _line(size.width * 0.45, 18, radius: 4),
                    const SizedBox(height: 10),
                    _line(size.width * 0.25, 12, opacity: 0.25, radius: 4),
                  ],
                ),
              ),
              _line(40, 14, radius: 4, opacity: 0.1), // Date/Status tag
            ],
          ),
        ),
      ),
    );
  }

  // ================= LUXURY COMPONENTS =================
  Widget _line(double width, double height, {double radius = 8, double opacity = 1.0}) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          // Using a subtle gradient here prevents the "flat" look during animation
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.9),
              Colors.white.withOpacity(1.0),
            ],
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }

  Widget _circle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: Colors.white.withOpacity(0.05), width: 1),
      ),
    );
  }
}