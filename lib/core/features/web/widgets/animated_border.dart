import 'package:flutter/material.dart';

class AnimatedBorder extends StatefulWidget {
  final Widget child;
  final double radius;
  final double strokeWidth;

  const AnimatedBorder({
    super.key,
    required this.child,
    this.radius = 24,
    this.strokeWidth = 3.5, // 👈 default for cards
  });

  @override
  State<AnimatedBorder> createState() => _AnimatedBorderState();
}

class _AnimatedBorderState extends State<AnimatedBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), // smooth & clean speed
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return CustomPaint(
          foregroundPainter: _AnimatedBorderPainter(
            progress: _controller.value,
            radius: widget.radius,
            strokeWidth: widget.strokeWidth,
          ),
          child: widget.child, // 🔥 card stays sharp
        );
      },
    );
  }
}

/* ───────────────────────────────────────────── */

class _AnimatedBorderPainter extends CustomPainter {
  final double progress;
  final double radius;
  final double strokeWidth;

  _AnimatedBorderPainter({
    required this.progress,
    required this.radius,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth // 👈 dynamic thickness
      ..shader = SweepGradient(
        colors: const [
          Colors.white,
          Colors.black,
          Colors.white,
        ],
        stops: const [0.0, 0.5, 1.0],
        transform: GradientRotation(progress * 6.28319),
      ).createShader(rect);

    final rrect = RRect.fromRectAndRadius(
      rect.deflate(strokeWidth / 2), // 👈 perfect edge alignment
      Radius.circular(radius),
    );

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant _AnimatedBorderPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.radius != radius;
  }
}
