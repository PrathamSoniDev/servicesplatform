import 'package:flutter/material.dart';
import 'package:seo_renderer/seo_renderer.dart';

/// ===============================
/// SEO HEADING
/// ===============================
class SeoHeading extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? align;

  const SeoHeading(
    this.text, {
    super.key,
    this.style,
    this.align,
  });

  @override
  Widget build(BuildContext context) {
    return TextRenderer(
      text: text,
      child: Text(
        text,
        textAlign: align,
        style: style,
      ),
    );
  }
}

/// ===============================
/// SEO TEXT
/// ===============================
class SeoText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? align;
  final int? maxLines;

  const SeoText(
    this.text, {
    super.key,
    this.style,
    this.align,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextRenderer(
      text: text,
      child: Text(
        text,
        style: style,
        textAlign: align,
        maxLines: maxLines,
      ),
    );
  }
}

/// ===============================
/// SEO NETWORK IMAGE
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
      ),
    );
  }
}

/// ===============================
/// SEO ASSET IMAGE
/// ===============================
class SeoAssetImage extends StatelessWidget {
  final String assetPath;
  final String alt;
  final double? width;
  final double? height;
  final BoxFit fit;

  const SeoAssetImage({
    super.key,
    required this.assetPath,
    required this.alt,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return ImageRenderer(
      src: assetPath,
      alt: alt,
      child: Image.asset(
        assetPath,
        width: width,
        height: height,
        fit: fit,
      ),
    );
  }
}

/// ===============================
/// SEO LINK
/// ===============================
class SeoLink extends StatelessWidget {
  final String url;
  final Widget child;

  const SeoLink({
    super.key,
    required this.url,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LinkRenderer(
      href: url,
      text: '',
      child: child,
    );
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
      text: '',
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}