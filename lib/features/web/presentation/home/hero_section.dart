// import 'package:flutter/material.dart';
//
// import '../../utils/responsive.dart';
//
// enum HeroContentAlignment { left, center, right }
//
// class HeroSection extends StatelessWidget {
//   const HeroSection({
//     super.key,
//     required this.title,
//     this.subtitle,
//     this.imagePath,
//     this.featuredText,
//     this.featuredColor = const Color(0xFFFF4D4D),
//     this.customButtons,
//     this.showNavigationArrows = false,
//     this.isOverlayMode = false,
//     this.contentAlignment = HeroContentAlignment.left,
//     this.imageFlex = 5,
//     this.contentFlex = 5,
//     this.gap = 40,
//     // --- Gradient Configuration ---
//     this.gradientText,
//     this.showGradient = false,
//   });
//
//   final String title;
//   final String? subtitle;
//   final String? imagePath;
//   final String? featuredText;
//   final Color featuredColor;
//   final List<Widget>? customButtons;
//   final bool showNavigationArrows;
//   final bool isOverlayMode;
//   final HeroContentAlignment contentAlignment;
//   final int imageFlex;
//   final int contentFlex;
//   final double gap;
//
//   final String? gradientText; // Text to apply gradient to
//   final bool showGradient; // Toggle gradient on/off
//
//   @override
//   Widget build(BuildContext context) {
//     final isMobile = Responsive.isMobile(context);
//     final isTablet = Responsive.isTablet(context);
//
//     // 🔹 Responsive Sizing
//     final double titleFontSize =
//         isMobile
//             ? 36
//             : isTablet
//             ? 48
//             : 64;
//     final double imageHeight = isMobile ? 320 : 500;
//
//     final CrossAxisAlignment crossAxisAlignment =
//         contentAlignment == HeroContentAlignment.left
//             ? CrossAxisAlignment.start
//             : contentAlignment == HeroContentAlignment.right
//             ? CrossAxisAlignment.end
//             : CrossAxisAlignment.center;
//
//     final TextAlign textAlign =
//         contentAlignment == HeroContentAlignment.left
//             ? TextAlign.left
//             : contentAlignment == HeroContentAlignment.right
//             ? TextAlign.right
//             : TextAlign.center;
//
//     // --- Helper: Title with Optional Gradient Line ---
//     Widget buildTitle() {
//       final baseStyle = TextStyle(
//         fontSize: titleFontSize,
//         height: 1.1,
//         fontWeight: FontWeight.w900,
//         color: Colors.white,
//         fontFamily: 'Outfit',
//       );
//
//       if (!showGradient || gradientText == null) {
//         return Text(title, textAlign: textAlign, style: baseStyle);
//       }
//
//       return Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: crossAxisAlignment,
//         children: [
//           Text(title, textAlign: textAlign, style: baseStyle),
//           const SizedBox(height: 8), // Small gap between title parts
//           ShaderMask(
//             shaderCallback:
//                 (bounds) => const LinearGradient(
//                   colors: [Color(0xFFE6D7FF), Color(0xFF8B5CF6)],
//                 ).createShader(bounds),
//             child: Text(
//               gradientText!,
//               textAlign: textAlign,
//               style: baseStyle.copyWith(color: Colors.white),
//             ),
//           ),
//         ],
//       );
//     }
//
//     // --- Helper: Content Column ---
//     Widget buildContent() {
//       return Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: crossAxisAlignment,
//         children: [
//           if (showNavigationArrows) _buildNavigation(),
//           if (featuredText != null) ...[
//             Text(
//               featuredText!.toUpperCase(),
//               style: TextStyle(
//                 letterSpacing: 2.0,
//                 color: featuredColor,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14,
//               ),
//             ),
//             const SizedBox(height: 16),
//           ],
//           buildTitle(),
//           if (subtitle != null) ...[
//             const SizedBox(height: 32), // 🔹 Space between title and subtitle
//             Text(
//               subtitle!,
//               textAlign: textAlign,
//               style: TextStyle(
//                 color: Colors.white.withValues(alpha: .7),
//                 fontSize: isMobile ? 16 : 20,
//                 height: 1.6,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ],
//           if (customButtons != null && customButtons!.isNotEmpty) ...[
//             const SizedBox(height: 48), // 🔹 Space between subtitle and buttons
//             Wrap(
//               spacing: 20,
//               runSpacing: 20,
//               alignment: WrapAlignment.center,
//               children: customButtons!,
//             ),
//           ],
//         ],
//       );
//     }
//
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: isMobile ? 24 : 60,
//         vertical: 60,
//       ),
//       child:
//           isOverlayMode
//               ? Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   if (imagePath != null)
//                     Opacity(
//                       opacity: 0.4,
//                       child: _buildHeroImage(imageHeight, isMobile, true),
//                     ),
//                   // Constrain content width for better readability in overlay mode
//                   SizedBox(
//                     width: isMobile ? double.infinity : 800,
//                     child: buildContent(),
//                   ),
//                 ],
//               )
//               : _buildStandardLayout(isMobile, buildContent(), imageHeight),
//     );
//   }
//
//   // Helper for Image
//   Widget _buildHeroImage(double height, bool isMobile, bool isOverlay) {
//     return Container(
//       height: height,
//       width: isMobile ? double.infinity : (isOverlay ? double.infinity : null),
//       decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
//       clipBehavior: Clip.antiAlias,
//       child:
//           imagePath!.startsWith('http')
//               ? Image.network(imagePath!, fit: BoxFit.cover)
//               : Image.asset(imagePath!, fit: BoxFit.contain),
//     );
//   }
//
//   // Helper for Row/Column Layout
//   Widget _buildStandardLayout(
//     bool isMobile,
//     Widget content,
//     double imageHeight,
//   ) {
//     if (isMobile) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (imagePath != null) ...[
//             _buildHeroImage(imageHeight, true, false),
//             const SizedBox(height: 48),
//           ],
//           content,
//         ],
//       );
//     }
//     return Row(
//       children: [
//         Expanded(flex: contentFlex, child: content),
//         SizedBox(width: gap),
//         if (imagePath != null)
//           Expanded(
//             flex: imageFlex,
//             child: _buildHeroImage(imageHeight, false, false),
//           ),
//       ],
//     );
//   }
//
//   Widget _buildNavigation() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 32),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             Icons.arrow_back,
//             color: Colors.white.withValues(alpha: .5),
//             size: 24,
//           ),
//           const SizedBox(width: 16),
//           const Icon(Icons.arrow_forward, color: Colors.white, size: 24),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

import '../../utils/responsive.dart';
import '../../widgets/hero_shimmer.dart';

enum HeroContentAlignment { left, center, right }

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.title,
    this.subtitle,
    this.imagePath,
    this.featuredText,
    this.featuredColor = const Color(0xFFFF4D4D),
    this.customButtons,
    this.showNavigationArrows = false,
    this.isOverlayMode = false,
    this.contentAlignment = HeroContentAlignment.left,
    this.imageFlex = 5,
    this.contentFlex = 5,
    this.gap = 40,

    // Gradient
    this.gradientText,
    this.showGradient = false,

    // Loading
    this.isLoading = false,
  });

  final String title;
  final String? subtitle;
  final String? imagePath;
  final String? featuredText;
  final Color featuredColor;
  final List<Widget>? customButtons;
  final bool showNavigationArrows;
  final bool isOverlayMode;
  final HeroContentAlignment contentAlignment;
  final int imageFlex;
  final int contentFlex;
  final double gap;

  final String? gradientText;
  final bool showGradient;

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return HeroShimmer();
    }

    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    final double titleFontSize =
        isMobile
            ? 36
            : isTablet
            ? 48
            : 64;
    final double imageHeight = isMobile ? 320 : 500;

    final CrossAxisAlignment crossAxisAlignment =
        contentAlignment == HeroContentAlignment.left
            ? CrossAxisAlignment.start
            : contentAlignment == HeroContentAlignment.right
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center;

    // final TextAlign textAlign =
    //     contentAlignment == HeroContentAlignment.left
    //         ? TextAlign.left
    //         : contentAlignment == HeroContentAlignment.right
    //         ? TextAlign.right
    //         : TextAlign.center;

    Widget buildTitle() {
      final baseStyle = TextStyle(
        fontSize: titleFontSize,
        height: 1.1,
        fontWeight: FontWeight.w900,
        color: Colors.white,
        fontFamily: 'Outfit',
      );

      if (!showGradient || gradientText == null) {
        return Text(title, style: baseStyle);
      }

      return Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(title, style: baseStyle),
          const SizedBox(height: 8),
          ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                colors: [Color(0xFFE6D7FF), Color(0xFF8B5CF6)],
              ).createShader(bounds);
            },
            child: Text(
              gradientText!,
              style: baseStyle.copyWith(color: Colors.white),
            ),
          ),
        ],
      );
    }

    Widget buildContent() {
      return Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          if (showNavigationArrows) _buildNavigation(),
          if (featuredText != null) ...[
            Text(
              featuredText!.toUpperCase(),
              textAlign: TextAlign.left,
              style: TextStyle(
                letterSpacing: 2,
                color: featuredColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
          ],
          buildTitle(),
          if (subtitle != null) ...[
            const SizedBox(height: 32),
            Text(
              subtitle!,
              style: TextStyle(
                color: Colors.white.withValues(alpha: .7),
                fontSize: isMobile ? 16 : 20,
                height: 1.6,
              ),
            ),
          ],
          if (customButtons != null && customButtons!.isNotEmpty) ...[
            const SizedBox(height: 48),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: customButtons!,
            ),
          ],
        ],
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 60,
        vertical: 60,
      ),
      child:
          isOverlayMode
              ? _buildOverlayLayout(isMobile, imageHeight, buildContent())
              : _buildStandardLayout(isMobile, imageHeight, buildContent()),
    );
  }

  /// 🔥 Overlay layout (RESTORED)
  Widget _buildOverlayLayout(
    bool isMobile,
    double imageHeight,
    Widget content,
  ) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (imagePath != null)
          Opacity(opacity: 0.4, child: _secureImage(imageHeight, cover: true)),
        SizedBox(width: isMobile ? double.infinity : 800, child: content),
      ],
    );
  }

  /// Standard layout
  Widget _buildStandardLayout(
    bool isMobile,
    double imageHeight,
    Widget content,
  ) {
    if (isMobile) {
      return Column(
        children: [
          if (imagePath != null) _secureImage(imageHeight),
          const SizedBox(height: 48),
          content,
        ],
      );
    }

    return Row(
      children: [
        Expanded(flex: contentFlex, child: content),
        SizedBox(width: gap),
        if (imagePath != null)
          Expanded(flex: imageFlex, child: _secureImage(imageHeight)),
      ],
    );
  }

  Widget _buildNavigation() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.arrow_back,
            color: Colors.white.withValues(alpha: .5),
            size: 24,
          ),
          const SizedBox(width: 16),
          const Icon(Icons.arrow_forward, color: Colors.white, size: 24),
        ],
      ),
    );
  }

  /// 🔐 Secure image loader
  Widget _secureImage(double height, {bool cover = false}) {
    final url =
        imagePath?.startsWith('http') == true ? imagePath! : imagePath ?? '';

    return Container(
      height: height,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        url,
        fit: cover ? BoxFit.cover : BoxFit.contain,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
        errorBuilder:
            (_, __, ___) => const Center(
              child: Icon(Icons.broken_image, color: Colors.white54, size: 48),
            ),
      ),
    );
  }
}
