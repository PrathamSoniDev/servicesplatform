// import 'package:flutter/material.dart';
//
// import '../../utils/responsive.dart';
// import '../../widgets/hero_shimmer.dart';
//
// enum HeroContentAlignment { left, center, right, start }
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
//
//     // Gradient
//     this.gradientText,
//     this.showGradient = false,
//
//     // Loading
//     this.isLoading = false,
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
//   final String? gradientText;
//   final bool showGradient;
//
//   final bool isLoading;
//
//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return HeroShimmer();
//     }
//
//     final isMobile = Responsive.isMobile(context);
//     final isTablet = Responsive.isTablet(context);
//
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
//             ? CrossAxisAlignment.start
//             : CrossAxisAlignment.center;
//
//     final TextAlign textAlign =
//         contentAlignment == HeroContentAlignment.left
//             ? TextAlign.left
//             : contentAlignment == HeroContentAlignment.right
//             ? TextAlign.right
//             : TextAlign.center;
//
//     Widget buildTitle() {
//       final baseStyle = TextStyle(
//         fontSize: titleFontSize,
//         height: 1.1,
//         fontWeight: FontWeight.w900,
//         color: Colors.white,
//       );
//
//       if (!showGradient || gradientText == null) {
//         return Text(title, style: baseStyle);
//       }
//
//       return Column(
//         crossAxisAlignment: crossAxisAlignment,
//         children: [
//           Text(title, style: baseStyle),
//           const SizedBox(height: 8),
//           ShaderMask(
//             shaderCallback: (bounds) {
//               return const LinearGradient(
//                 colors: [Color(0xFFE6D7FF), Color(0xFF8B5CF6)],
//               ).createShader(bounds);
//             },
//             child: Text(
//               gradientText!,
//               style: baseStyle.copyWith(color: Colors.white),
//             ),
//           ),
//         ],
//       );
//     }
//
//     Widget buildContent() {
//       return Column(
//         crossAxisAlignment: crossAxisAlignment,
//         children: [
//           if (showNavigationArrows) _buildNavigation(),
//           if (featuredText != null) ...[
//             Text(
//               featuredText!.toUpperCase(),
//               textAlign: TextAlign.left,
//               style: TextStyle(
//                 letterSpacing: 2,
//                 color: featuredColor,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14,
//               ),
//             ),
//             const SizedBox(height: 16),
//           ],
//           buildTitle(),
//           if (subtitle != null) ...[
//             const SizedBox(height: 32),
//             Text(
//               subtitle!,
//               style: TextStyle(
//                 color: Colors.white.withValues(alpha: .7),
//                 fontSize: isMobile ? 16 : 20,
//                 height: 1.6,
//               ),
//             ),
//           ],
//           if (customButtons != null && customButtons!.isNotEmpty) ...[
//             const SizedBox(height: 48),
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
//               ? _buildOverlayLayout(isMobile, imageHeight, buildContent())
//               : _buildStandardLayout(isMobile, imageHeight, buildContent()),
//     );
//   }
//
//   /// 🔥 Overlay layout (RESTORED)
//   Widget _buildOverlayLayout(
//     bool isMobile,
//     double imageHeight,
//     Widget content,
//   ) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         if (imagePath != null)
//           Opacity(opacity: 0.4, child: _secureImage(imageHeight, cover: true)),
//         SizedBox(width: isMobile ? double.infinity : 800, child: content),
//       ],
//     );
//   }
//
//   /// Standard layout
//   Widget _buildStandardLayout(
//     bool isMobile,
//     double imageHeight,
//     Widget content,
//   ) {
//     if (isMobile) {
//       return Column(
//         children: [
//           if (imagePath != null) _secureImage(imageHeight),
//           const SizedBox(height: 48),
//           content,
//         ],
//       );
//     }
//
//     return Row(
//       children: [
//         Expanded(flex: contentFlex, child: content),
//         SizedBox(width: gap),
//         if (imagePath != null)
//           Expanded(flex: imageFlex, child: _secureImage(imageHeight)),
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
//
//   /// 🔐 Secure image loader
//   Widget _secureImage(double height, {bool cover = false}) {
//     final url =
//         imagePath?.startsWith('http') == true ? imagePath! : imagePath ?? '';
//
//     return Container(
//       height: height,
//       decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
//       clipBehavior: Clip.antiAlias,
//       child: Image.network(
//         url,
//         fit: cover ? BoxFit.cover : BoxFit.contain,
//         loadingBuilder: (context, child, progress) {
//           if (progress == null) return child;
//           return const Center(child: CircularProgressIndicator());
//         },
//         errorBuilder:
//             (_, __, ___) => const Center(
//               child: Icon(Icons.broken_image, color: Colors.white54, size: 48),
//             ),
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/responsive.dart';

enum HeroContentAlignment { left, center, right, start }

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
    this.gradientText,
    this.showGradient = false,
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
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    final titleFontSize =
        isMobile
            ? 36.0
            : isTablet
            ? 48.0
            : 64.0;
    final imageHeight = isMobile ? 320.0 : 500.0;

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

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 60,
        vertical: 60,
      ),
      child: RepaintBoundary(
        child:
            isOverlayMode
                ? _OverlayLayout(
                  imagePath: imagePath,
                  imageHeight: imageHeight,
                  content: _HeroContent(
                    title: title,
                    subtitle: subtitle,
                    titleFontSize: titleFontSize,
                    featuredText: featuredText,
                    featuredColor: featuredColor,
                    customButtons: customButtons,
                    showNavigationArrows: showNavigationArrows,
                    crossAxisAlignment: crossAxisAlignment,
                    showGradient: showGradient,
                    gradientText: gradientText,
                    isLoading: isLoading,
                  ),
                )
                : _StandardLayout(
                  imagePath: imagePath,
                  imageHeight: imageHeight,
                  contentFlex: contentFlex,
                  imageFlex: imageFlex,
                  gap: gap,
                  isMobile: isMobile,
                  content: _HeroContent(
                    title: title,
                    subtitle: subtitle,
                    titleFontSize: titleFontSize,
                    featuredText: featuredText,
                    featuredColor: featuredColor,
                    customButtons: customButtons,
                    showNavigationArrows: showNavigationArrows,
                    crossAxisAlignment: crossAxisAlignment,
                    showGradient: showGradient,
                    gradientText: gradientText,
                    isLoading: isLoading,
                  ),
                ),
      ),
    );
  }
}

class _HeroContent extends StatelessWidget {
  const _HeroContent({
    required this.title,
    required this.titleFontSize,
    required this.crossAxisAlignment,
    required this.isLoading,
    this.subtitle,
    this.featuredText,
    this.featuredColor,
    this.customButtons,
    this.showNavigationArrows = false,
    this.showGradient = false,
    this.gradientText,
  });

  final String title;
  final double titleFontSize;
  final CrossAxisAlignment crossAxisAlignment;
  final bool isLoading;

  final String? subtitle;
  final String? featuredText;
  final Color? featuredColor;
  final List<Widget>? customButtons;
  final bool showNavigationArrows;
  final bool showGradient;
  final String? gradientText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        if (showNavigationArrows) _buildNavigation(),

        if (featuredText != null)
          _ShimmerText(
            isLoading: isLoading,
            child: Text(
              featuredText!.toUpperCase(),
              style: TextStyle(
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: featuredColor,
              ),
            ),
          ),

        const SizedBox(height: 16),

        _ShimmerText(
          isLoading: isLoading,
          child: _HeroTitle(
            title: title,
            fontSize: titleFontSize,
            alignment: crossAxisAlignment,
            showGradient: showGradient,
            gradientText: gradientText,
          ),
        ),

        if (subtitle != null) ...[
          const SizedBox(height: 24),
          _ShimmerText(
            isLoading: isLoading,
            child: Text(
              subtitle!,
              style: TextStyle(
                fontSize: 18,
                height: 1.6,
                color: Colors.white.withValues(alpha: .7),
              ),
            ),
          ),
        ],

        if (customButtons != null) ...[
          const SizedBox(height: 40),
          Wrap(spacing: 20, runSpacing: 20, children: customButtons!),
        ],
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
}

class _HeroImage extends StatelessWidget {
  const _HeroImage({
    required this.imagePath,
    required this.height,
    this.cover = false,
  });

  final String imagePath;
  final double height;
  final bool cover;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: CachedNetworkImage(
          imageUrl: imagePath,
          height: height,
          fit: cover ? BoxFit.cover : BoxFit.contain,
          placeholder:
              (_, __) => const Center(child: CircularProgressIndicator()),
          errorWidget:
              (_, __, ___) => const Icon(
                Icons.broken_image,
                color: Colors.white54,
                size: 48,
              ),
        ),
      ),
    );
  }
}

class _ShimmerText extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const _ShimmerText({required this.child, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return child;

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade600,
      child: Container(color: Colors.white, child: child),
    );
  }
}

class _StandardLayout extends StatelessWidget {
  const _StandardLayout({
    required this.content,
    required this.imagePath,
    required this.imageHeight,
    required this.isMobile,
    required this.contentFlex,
    required this.imageFlex,
    required this.gap,
  });

  final Widget content;
  final String? imagePath;
  final double imageHeight;
  final bool isMobile;
  final int contentFlex;
  final int imageFlex;
  final double gap;

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Column(
        children: [
          if (imagePath != null)
            _HeroImage(imagePath: imagePath!, height: imageHeight),
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
          Expanded(
            flex: imageFlex,
            child: _HeroImage(imagePath: imagePath!, height: imageHeight),
          ),
      ],
    );
  }
}

class _OverlayLayout extends StatelessWidget {
  const _OverlayLayout({
    required this.imagePath,
    required this.imageHeight,
    required this.content,
  });

  final String? imagePath;
  final double imageHeight;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (imagePath != null)
          Opacity(
            opacity: .4,
            child: _HeroImage(
              imagePath: imagePath!,
              height: imageHeight,
              cover: true,
            ),
          ),
        SizedBox(width: 800, child: content),
      ],
    );
  }
}

class _HeroTitle extends StatelessWidget {
  const _HeroTitle({
    required this.title,
    required this.fontSize,
    required this.alignment,
    this.showGradient = false,
    this.gradientText,
  });

  final String title;
  final double fontSize;
  final CrossAxisAlignment alignment;
  final bool showGradient;
  final String? gradientText;

  @override
  Widget build(BuildContext context) {
    final baseStyle = TextStyle(
      fontSize: fontSize,
      height: 1.1,
      fontWeight: FontWeight.w900,
      color: Colors.white,
    );

    final textAlign =
        alignment == CrossAxisAlignment.start
            ? TextAlign.left
            : TextAlign.center;

    // 🔹 Simple title (no gradient)
    if (!showGradient || gradientText == null) {
      return Text(title, textAlign: textAlign, style: baseStyle);
    }

    // 🔹 Title + Gradient subtitle
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(title, textAlign: textAlign, style: baseStyle),
        const SizedBox(height: 8),
        ShaderMask(
          shaderCallback:
              (bounds) => const LinearGradient(
                colors: [Color(0xFFE6D7FF), Color(0xFF8B5CF6)],
              ).createShader(bounds),
          child: Text(
            gradientText!,
            textAlign: textAlign,
            style: baseStyle.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
