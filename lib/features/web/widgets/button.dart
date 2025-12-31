import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../core/theme/app_theme_provider.dart';
import '../../../core/theme/theme_parser.dart';

enum AppButtonType { solid, outline, glass }

class AppButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;

  /// ✅ Main color (will pull from Theme if not provided)
  final Color color;
  final Color textColor;
  final EdgeInsets padding;
  final double borderRadius;
  final double borderWidth;
  final bool isLoading;
  final bool isDisabled;
  final bool enableGlow;
  final bool enableBlur;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = AppButtonType.solid,
    this.color = const Color(0xFF8E2DE2), // Fallback to Primary Purple
    this.textColor = Colors.white,
    this.padding = const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
    this.borderRadius = 30,
    this.borderWidth = 1.8,
    this.isLoading = false,
    this.isDisabled = false,
    this.enableGlow = false,
    this.enableBlur = false,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isHovering = false;

  bool get _canPress =>
      widget.onPressed != null && !widget.isDisabled && !widget.isLoading;

  @override
  Widget build(BuildContext context) {
    // 🔑 Theme Integration
    final tokens = AppThemeProvider.of(context);
    final buttonToken = tokens.colors['buttonPrimary'];
    
    final Gradient? themeGradient = ThemeParser.parseGradientToken(buttonToken);
    final Color themeColor = ThemeParser.parseColorToken(buttonToken);

    // ✅ LOGIC UPDATE: Use passed color if themeColor is transparent/null
    final Color effectiveColor = widget.isDisabled
        ? Colors.grey
        : (themeColor == Colors.transparent || themeColor == const Color(0x00000000))
            ? widget.color
            : themeColor;

    Widget buttonChild = _buildContent(context);

    if (widget.type == AppButtonType.glass && widget.enableBlur) {
      buttonChild = ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: buttonChild,
        ),
      );
    }

    return MouseRegion(
      cursor: _canPress ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: _canPress ? widget.onPressed : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: widget.padding,
          decoration: BoxDecoration(
            // ✅ Gradient handles Theme automatically
            gradient: widget.type == AppButtonType.solid ? themeGradient : null,

            // ✅ Color uses our new effectiveColor logic
            color: themeGradient == null ? _backgroundColor(effectiveColor) : null,

            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: _border(effectiveColor),
            boxShadow: _boxShadow(effectiveColor),
          ),
          child: buttonChild,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (widget.isLoading) {
      return const SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
      );
    }

    return Text(
      widget.text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: widget.textColor,
            fontWeight: FontWeight.bold, // Made bolder for better visibility
          ),
    );
  }

  Color _backgroundColor(Color color) {
    switch (widget.type) {
      case AppButtonType.solid:
        // Using withOpacity for backward compatibility if withValues isn't available
        return _isHovering ? color.withOpacity(0.85) : color;
      case AppButtonType.outline:
        return Colors.transparent;
      case AppButtonType.glass:
        return Colors.black.withOpacity(0.25);
    }
  }

  Border? _border(Color color) {
    if (widget.type == AppButtonType.outline) {
      return Border.all(color: color, width: widget.borderWidth);
    }
    if (widget.type == AppButtonType.glass) {
      return Border.all(color: Colors.white.withOpacity(0.25), width: 1);
    }
    return null;
  }

  List<BoxShadow>? _boxShadow(Color color) {
    if (!widget.enableGlow || widget.type == AppButtonType.outline) return null;

    return [
      BoxShadow(
        color: color.withOpacity(0.3),
        blurRadius: _isHovering ? 20 : 12,
        spreadRadius: 1,
      ),
    ];
  }
}