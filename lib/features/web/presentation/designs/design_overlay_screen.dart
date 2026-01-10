import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:servicesplatform/features/web/widgets/floating_bottom_bar.dart';
import 'package:servicesplatform/models/design_item_models.dart';

class NoScrollbarBehavior extends ScrollBehavior {
  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}

class DesignDetailOverlay extends StatelessWidget {
  final DesignItem data;

  const DesignDetailOverlay({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // 1. DYNAMIC BACKGROUND
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.7, -0.6),
                radius: 1.2,
                colors: [Color(0xFF1A1A2E), Color(0xFF050505)],
              ),
            ),
          ),

          // 2. SCROLLABLE CONTENT (Scrollbar Removed)
          Positioned.fill(
            child: ScrollConfiguration(
              behavior: NoScrollbarBehavior(),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _buildUniqueHeader(context),
                    _buildArtisticHero(isMobile, data),
                    _buildVerticalShowcase(data.images),
                    _buildDesignDNAFooter(data),
                    _buildBookingCTA(context),
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          ),

          // 3. FLOATING SIDEBAR
          if (!isMobile)
            Positioned(
              right: 40,
              top: 0,
              bottom: 0,
              child: Center(
                child: LuxuryFloatingBottomBar(
                  isMobile: isMobile,
                  views: "12,400",
                  likes: '1,250',
                  onLike: () {
                    print("Project Liked");
                  },
                  onHire: () {
                    print("Hire Requested");
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color parseHexColor(String hex) {
    final value = hex.replaceAll('#', '').toUpperCase();

    if (value.length == 6) {
      return Color(int.parse('FF$value', radix: 16));
    } else if (value.length == 8) {
      return Color(int.parse(value, radix: 16));
    }

    throw FormatException('Invalid hex color: $hex');
  }

  // --- DESIGN DNA FOOTER ---
  Widget _buildDesignDNAFooter(DesignItem project) {
    final palette = project.colors.map(parseHexColor).toList(growable: false);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      child: Column(
        children: [
          const Divider(color: Colors.white10),
          const SizedBox(height: 60),
          Wrap(
            spacing: 60,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: [
              //_infoBlock("THEME", project.themeName.toUpperCase()),
              _colorPaletteBlock("PALETTE", palette),
              _infoBlock("TYPOGRAPHY", project.fonts.toUpperCase()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _colorPaletteBlock(String label, List<Color> colors) {
    return Column(
      children: [
        Text(label, style: _luxuryStyle(10, color: Colors.white24, spacing: 3)),
        const SizedBox(height: 16),
        Row(
          mainAxisSize: MainAxisSize.min,
          children:
              colors
                  .map(
                    (c) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: c,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white10),
                      ),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }

  // --- BOOKING CALL TO ACTION ---
  Widget _buildBookingCTA(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: OutlinedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Redirecting to Booking System...")),
          );
          print("Booking Process Initiated");
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.blueAccent, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Text(
          "BOOK THIS EXPERIENCE",
          style: _luxuryStyle(
            12,
            color: Colors.blueAccent,
            spacing: 4,
            weight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // --- VERTICAL STACKED SHOWCASE ---
  Widget _buildVerticalShowcase(List<String> images) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children:
            images
                .map(
                  (url) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _luxuryImageCard(url),
                  ),
                )
                .toList(),
      ),
    );
  }

  Widget _luxuryImageCard(String url) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1100),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(url, width: double.infinity, fit: BoxFit.fitWidth),
      ),
    );
  }

  // --- HERO SECTION ---
  Widget _buildArtisticHero(bool isMobile, DesignItem project) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 100,
        vertical: 120,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            project.title!.toUpperCase(),
            style: TextStyle(
              fontSize: isMobile ? 70 : 160,
              foreground:
                  Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 1
                    ..color = Colors.white.withOpacity(0.03),
              fontWeight: FontWeight.w900,
            ),
          ),
          Column(
            children: [
              Text(
                project.subtitle ?? "",
                style: _luxuryStyle(
                  12,
                  color: Colors.blueAccent,
                  spacing: 8,
                  weight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                project.title ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isMobile ? 42 : 84,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoBlock(String label, String val) {
    return Column(
      children: [
        Text(label, style: _luxuryStyle(10, color: Colors.white24, spacing: 3)),
        const SizedBox(height: 12),
        Text(val, style: _luxuryStyle(14, weight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildUniqueHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Row(
        children: [
          _blurButton(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.close_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _blurButton({required Widget child, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  TextStyle _luxuryStyle(
    double size, {
    Color color = Colors.white,
    double spacing = 0,
    FontWeight weight = FontWeight.normal,
  }) {
    return TextStyle(
      fontSize: size,
      color: color,
      letterSpacing: spacing,
      fontWeight: weight,
      fontFamily: 'Inter',
    );
  }
}
