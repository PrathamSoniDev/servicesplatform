import 'dart:ui';

import 'package:flutter/material.dart';

enum AppButtonType { solid, outline, glass }

class AppButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;

  final AppButtonType type;
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
    this.color = const Color(0xFF8E2DE2),
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
    final Color effectiveColor = widget.isDisabled ? Colors.grey : widget.color;

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
            color: _backgroundColor(effectiveColor),
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
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Color _backgroundColor(Color color) {
    switch (widget.type) {
      case AppButtonType.solid:
        return _isHovering ? color.withValues(alpha: .9) : color;

      case AppButtonType.outline:
        return Colors.transparent;

      case AppButtonType.glass:
        return Colors.black.withValues(alpha: .25);
    }
  }

  Border? _border(Color color) {
    if (widget.type == AppButtonType.outline) {
      return Border.all(color: color, width: widget.borderWidth);
    }
    if (widget.type == AppButtonType.glass) {
      return Border.all(color: Colors.white.withValues(alpha: .25), width: 1);
    }
    return null;
  }

  List<BoxShadow>? _boxShadow(Color color) {
    if (!widget.enableGlow) return null;

    return [
      BoxShadow(
        color: color.withValues(alpha: .45),
        blurRadius: _isHovering ? 24 : 16,
        spreadRadius: 1,
      ),
    ];
  }
}
