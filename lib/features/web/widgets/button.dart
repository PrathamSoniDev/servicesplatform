import 'dart:ui';
import 'package:flutter/material.dart';

enum AppButtonType { solid, outline, glass }

class AppButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;

  /// 🎨 Customization
  final Color color;
  final Color textColor;
  final Gradient? gradient;

  /// 📐 Layout
  final EdgeInsets padding;
  final double borderRadius;
  final double borderWidth;

  /// ⚙️ State
  final bool isLoading;
  final bool isDisabled;

  /// ✨ Effects
  final bool enableGlow;
  final bool enableBlur;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = AppButtonType.solid,

    /// Default design
    this.color = const Color(0xFF00FFA3),
    this.textColor = Colors.white,
    this.gradient,

    /// Layout
    this.padding = const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
    this.borderRadius = 30,
    this.borderWidth = 1.5,

    /// States
    this.isLoading = false,
    this.isDisabled = false,

    /// Effects
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
    Widget buttonContent = _buildContent();

    if (widget.type == AppButtonType.glass && widget.enableBlur) {
      buttonContent = ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: buttonContent,
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
          duration: const Duration(milliseconds: 180),
          padding: widget.padding,
          decoration: BoxDecoration(
            gradient: widget.gradient,
            color: widget.gradient == null ? _backgroundColor() : null,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: _border(),
            boxShadow: _shadow(),
          ),
          child: buttonContent,
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (widget.isLoading) {
      return const SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      );
    }

    return Text(
      widget.text,
      style: TextStyle(
        color: widget.textColor,
        fontWeight: FontWeight.w600,
        fontSize: 16,
        letterSpacing: .4,
      ),
    );
  }

  Color _backgroundColor() {
    switch (widget.type) {
      case AppButtonType.solid:
        return _isHovering
            ? widget.color.withOpacity(.85)
            : widget.color;

      case AppButtonType.outline:
        return Colors.transparent;

      case AppButtonType.glass:
        return Colors.black.withOpacity(.25);
    }
  }

  Border? _border() {
    if (widget.type == AppButtonType.outline) {
      return Border.all(
        color: widget.color,
        width: widget.borderWidth,
      );
    }

    if (widget.type == AppButtonType.glass) {
      return Border.all(
        color: Colors.white.withOpacity(.25),
      );
    }

    return null;
  }

  List<BoxShadow>? _shadow() {
    if (!widget.enableGlow || widget.type == AppButtonType.outline) {
      return null;
    }

    return [
      BoxShadow(
        color: widget.color.withOpacity(.35),
        blurRadius: _isHovering ? 26 : 14,
        spreadRadius: 1,
      ),
    ];
  }
}