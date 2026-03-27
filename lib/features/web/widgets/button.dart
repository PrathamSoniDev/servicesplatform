import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';

enum AppButtonType { solid, outline, glass }

class AppButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;

  /// 🎨 Customization
  final Color? color;
  final Color? textColor;
  final Gradient? gradient;

  /// 📐 Layout
  final EdgeInsets? padding;
  final double borderRadius;
  final double borderWidth;

  /// 📏 Size scaling
  final double fontSize;
  final double minWidth;
  final double height;

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

    /// Theme based default
    this.color,
    this.textColor,
    this.gradient,

    /// Layout
    this.padding,
    this.borderRadius = 30,
    this.borderWidth = 1.5,

    /// Size
    this.fontSize = 16,
    this.minWidth = 0,
    this.height = 0,

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
    /// 🔥 RESPONSIVE VALUES
    final scaledFont = Responsive.scaleText(context, widget.fontSize);
    final scaledPadding = widget.padding ??
        EdgeInsets.symmetric(
          horizontal: Responsive.wp(context, 0.02), // 🔥 fluid padding
          vertical: Responsive.hp(context, 0.012),
        );

    final buttonHeight =
        widget.height == 0 ? Responsive.hp(context, 0.055) : widget.height;

    Widget button = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      constraints: BoxConstraints(
        minWidth: widget.minWidth,
        minHeight: buttonHeight,
      ),
      padding: scaledPadding,
      decoration: BoxDecoration(
        gradient: widget.gradient,
        color: widget.gradient == null ? _backgroundColor(context) : null,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: _border(context),
        boxShadow: _shadow(context),
      ),
      child: Center(child: _buildContent(scaledFont, context)),
    );

    /// 🔥 GLASS EFFECT
    if (widget.type == AppButtonType.glass && widget.enableBlur) {
      button = ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: button,
        ),
      );
    }

    return MouseRegion(
      cursor: _canPress ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: Opacity(
        opacity: widget.isDisabled ? 0.5 : 1,
        child: GestureDetector(
          onTap: _canPress ? widget.onPressed : null,
          child: button,
        ),
      ),
    );
  }

  /// ================= CONTENT =================

  Widget _buildContent(double fontSize, BuildContext context) {
    if (widget.isLoading) {
      return SizedBox(
        width: fontSize,
        height: fontSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: _textColor(context),
        ),
      );
    }

    return Text(
      widget.text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: _textColor(context),
        fontWeight: FontWeight.w600,
        fontSize: fontSize,
        letterSpacing: .4,
      ),
    );
  }

  /// ================= COLORS =================

  Color _backgroundColor(BuildContext context) {
    final baseColor = widget.color ?? AppTheme.primary;

    switch (widget.type) {
      case AppButtonType.solid:
        return _isHovering
            ? baseColor.withOpacity(.85)
            : baseColor;

      case AppButtonType.outline:
        return Colors.transparent;

      case AppButtonType.glass:
        return AppTheme.glassOverlayDark;
    }
  }

  Color _textColor(BuildContext context) {
    if (widget.textColor != null) return widget.textColor!;

    if (widget.type == AppButtonType.solid) {
      return Colors.black;
    }

    return AppTheme.getTextPrimary(context);
  }

  Border? _border(BuildContext context) {
    final baseColor = widget.color ?? AppTheme.primary;

    if (widget.type == AppButtonType.outline) {
      return Border.all(
        color: baseColor,
        width: widget.borderWidth,
      );
    }

    if (widget.type == AppButtonType.glass) {
      return Border.all(
        color: Colors.white.withOpacity(.2),
      );
    }

    return null;
  }

  List<BoxShadow>? _shadow(BuildContext context) {
    if (!widget.enableGlow || widget.type == AppButtonType.outline) {
      return null;
    }

    final baseColor = widget.color ?? AppTheme.primary;

    return [
      BoxShadow(
        color: baseColor.withOpacity(.35),
        blurRadius: _isHovering ? 28 : 14,
        spreadRadius: 1,
      ),
    ];
  }
}