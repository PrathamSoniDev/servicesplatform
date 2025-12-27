import 'package:flutter/material.dart';
import 'package:flutter_seo/flutter_seo.dart';

enum SeoTextTag { h1, h2, h3, h4, h5, h6, p, span }

class CustomText extends StatelessWidget {
  final String text;
  final SeoTextTag tag;
  final TextStyle? style;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;

  const CustomText({
    super.key,
    required this.text,
    this.tag = SeoTextTag.p,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.visible,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      key: _seoKey(),
      style: style ?? _defaultStyle(context),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  /// Map our enum → flutter_seo TagType
  Key _seoKey() {
    switch (tag) {
      case SeoTextTag.h1:
        return SeoKey(TagType.h1, text: text);
      case SeoTextTag.h2:
        return SeoKey(TagType.h2, text: text);
      case SeoTextTag.h3:
        return SeoKey(TagType.h3, text: text);
      case SeoTextTag.h4:
        return SeoKey(TagType.h4, text: text);
      case SeoTextTag.h5:
        return SeoKey(TagType.h5, text: text);
      case SeoTextTag.h6:
        return SeoKey(TagType.h6, text: text);
      case SeoTextTag.p:
        return SeoKey(TagType.p, text: text);
      default:
        return SeoKey(TagType.p, text: text);
    }
  }

  /// Centralized typography system
  TextStyle _defaultStyle(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    switch (tag) {
      case SeoTextTag.h1:
        return theme.displayLarge!.copyWith(
          fontWeight: FontWeight.bold,
          height: 1.2,
        );

      case SeoTextTag.h2:
        return theme.displayMedium!.copyWith(fontWeight: FontWeight.bold);

      case SeoTextTag.h3:
        return theme.headlineLarge!.copyWith(fontWeight: FontWeight.w600);

      case SeoTextTag.h4:
        return theme.headlineMedium!.copyWith(fontWeight: FontWeight.w600);

      case SeoTextTag.h5:
        return theme.titleLarge!.copyWith(fontWeight: FontWeight.w500);

      case SeoTextTag.h6:
        return theme.titleMedium!.copyWith(fontWeight: FontWeight.w500);

      case SeoTextTag.p:
        return theme.bodySmall!;
      default:
        return theme.bodyLarge!;
    }
  }
}
