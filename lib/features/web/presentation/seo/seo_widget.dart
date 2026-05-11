import 'package:flutter/material.dart';
import 'package:seo_renderer/seo_renderer.dart';

/// ===============================
/// SEO WRAPPER (IMPORTANT)
/// ===============================
class SeoWrapper extends StatelessWidget {
  final Widget child;

  const SeoWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return RobotDetector(child: child);
  }
}

/// ===============================
/// SEO HEADER
/// ===============================
class SeoHeader extends StatelessWidget {
  final Widget child;

  const SeoHeader({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Semantics(container: true, header: true, child: child);
  }
}

/// ===============================
/// SEO FOOTER
/// ===============================
class SeoFooter extends StatelessWidget {
  final Widget child;

  const SeoFooter({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Semantics(container: true, child: child);
  }
}

/// ===============================
/// SEO BODY WRAPPER
/// ===============================
class SeoBody extends StatelessWidget {
  final Widget child;

  const SeoBody({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Semantics(container: true, child: child);
  }
}

/// ===============================
/// SEO HEADING (UPDATED 🔥)
/// ===============================
class SeoHeading extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? align;

  const SeoHeading(this.text, {super.key, this.style, this.align});

  @override
  Widget build(BuildContext context) {
    return TextRenderer(
      text: text,
      child: Text(
        text,
        textAlign: align ?? TextAlign.start, // ✅ default added
        style: style,
      ),
    );
  }
}

/// ===============================
/// SEO TEXT (UPDATED 🔥)
/// ===============================
class SeoText extends StatelessWidget {
  final String text;
  final TextOverflow? overflow;
  final TextStyle? style;
  final TextAlign? align;
  final int? maxLines;

  const SeoText(
    this.text, {
    super.key,
    this.style,
    this.overflow,
    this.align,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextRenderer(
      text: text,
      child: Text(
        text,
        overflow: overflow,
        softWrap: true,
        textAlign: align ?? TextAlign.start,
        // ✅ default added
        style: style,
        maxLines: maxLines,
      ),
    );
  }
}

/// ===============================
/// SEO IMAGE
/// ===============================
class SeoImage extends StatelessWidget {
  final String src;
  final String alt;
  final double? width;
  final double? height;
  final BoxFit fit;

  const SeoImage({
    super.key,
    required this.src,
    required this.alt,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return ImageRenderer(
      src: src,
      alt: alt,
      child: Image.network(
        src,
        width: width,
        height: height,
        fit: fit,
        semanticLabel: alt,
      ),
    );
  }
}

/// ===============================
/// SEO LINK
/// ===============================
class SeoLink extends StatelessWidget {
  final String url;
  final String text;
  final Widget child;

  const SeoLink({
    super.key,
    required this.url,
    required this.text,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LinkRenderer(href: url, text: text, child: child);
  }
}

/// ===============================
/// SEO BUTTON LINK
/// ===============================
class SeoButtonLink extends StatelessWidget {
  final String url;
  final String text;
  final VoidCallback onPressed;

  const SeoButtonLink({
    super.key,
    required this.url,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return LinkRenderer(
      href: url,
      text: text,
      child: ElevatedButton(onPressed: onPressed, child: Text(text)),
    );
  }
}
