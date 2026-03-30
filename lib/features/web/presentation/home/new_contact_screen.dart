import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/presentation/seo/seo_widget.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final double sw = mq.size.width;
    final double sh = mq.size.height;
    final bool isMobile = sw < Responsive.mobileMax;

    final double hPad = isMobile ? sw * 0.04 : sw * 0.07;
    final double cardH = sh * 0.63;
    final double heroH = sh * 0.40;
    final double footH = (sh * 0.16).clamp(100.0, 160.0);
    final double formPH = isMobile ? 18.0 : 36.0;
    final double formPV = isMobile ? 18.0 : 26.0;

    final double selltechFs = isMobile
        ? (sh * 0.095).clamp(32.0, 72.0)
        : (sh * 0.110).clamp(48.0, 110.0);

    final double headlineFs = Responsive.scaleText(
      context,
      isMobile ? 32.0 : 46.0,
    ).clamp(24.0, 64.0);

    return Scaffold(
      backgroundColor: AppTheme.contactBg,
      body: Stack(
        children: [
          // Dot grid bg
          Positioned.fill(
            child: RepaintBoundary(
              child: CustomPaint(painter: const _DotGridPainter()),
            ),
          ),
          // Radar — more visible now
          Positioned(
            top: -(sh * 0.04),
            left: 0,
            right: 0,
            height: sh * 0.46,
            child: const RepaintBoundary(
              child: _RadarPainterWidget(),
            ),
          ),
          // Hero
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: heroH,
            child: _HeroSection(
              isMobile: isMobile,
              selltechFontSize: selltechFs,
              headlineFontSize: headlineFs,
              subtitleFontSize:
                  Responsive.scaleText(context, 13).clamp(11.0, 16.0),
            ),
          ),
          // Contact card
          Positioned(
            bottom: sh * 0.03,
            left: hPad,
            right: hPad,
            height: cardH,
            child: _ContactCard(
              isMobile: isMobile,
              footerHeight: footH,
              formPadH: formPH,
              formPadV: formPV,
            ),
          ),
          // Corner marks
          Positioned(
            top: sh * 0.03,
            left: hPad,
            child: const _CornerMark(),
          ),
          Positioned(
            top: sh * 0.03,
            right: hPad,
            child: const _CornerMark(flipH: true),
          ),
        ],
      ),
    );
  }
}

// ── Contact Card ──────────────────────────────────────────────────────────────

class _ContactCard extends StatelessWidget {
  final bool isMobile;
  final double footerHeight;
  final double formPadH;
  final double formPadV;

  const _ContactCard({
    required this.isMobile,
    required this.footerHeight,
    required this.formPadH,
    required this.formPadV,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppTheme.contactCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.contactBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.85),
            blurRadius: 80,
            offset: const Offset(0, 32),
          ),
          BoxShadow(
            color: AppTheme.contactWhite.withOpacity(0.03),
            blurRadius: 0,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Column(
          children: [
            const _ShimmerLine(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(
                    formPadH, formPadV, formPadH, 14),
                child: _FormContent(isMobile: isMobile),
              ),
            ),
            const Divider(height: 1, color: AppTheme.contactBorder),
            SizedBox(
              height: footerHeight,
              child: _FooterRow(isMobile: isMobile, padH: formPadH),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Form Content ──────────────────────────────────────────────────────────────

class _FormContent extends StatelessWidget {
  final bool isMobile;

  const _FormContent({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _ConsoleHeader(),
        const SizedBox(height: 20),

        if (isMobile) ...[
          const _ContactInput(label: "NAME", hint: "John Doe"),
          const SizedBox(height: 14),
          const _ContactInput(
              label: "EMAIL", hint: "john@selltech.com"),
        ] else
          Row(
            children: const [
              Expanded(
                  child: _ContactInput(label: "NAME", hint: "John Doe")),
              SizedBox(width: 12),
              Expanded(
                  child: _ContactInput(
                      label: "EMAIL", hint: "john@selltech.com")),
            ],
          ),

        const SizedBox(height: 14),
        const _ContactInput(
            label: "PHONE NUMBER", hint: "+1 (555) 000-0000"),
        const SizedBox(height: 14),
        const _ContactInput(
          label: "MESSAGE",
          hint: "How can we help you?",
          maxLines: 4,
        ),
        const SizedBox(height: 20),
        _SubmitButton(isMobile: isMobile),
      ],
    );
  }
}

// ── Contact Input ─────────────────────────────────────────────────────────────

class _ContactInput extends StatelessWidget {
  final String label;
  final String hint;
  final int maxLines;

  const _ContactInput({
    required this.label,
    required this.hint,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppTheme.contactInputBorder),
    );
    final focusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide:
          BorderSide(color: AppTheme.contactWhite.withOpacity(0.45)),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SeoText(
          label,
          style: const TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.5,
            color: AppTheme.contactTextSec,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          maxLines: maxLines,
          style: const TextStyle(
              fontSize: 13, color: AppTheme.contactTextPri),
          cursorColor: AppTheme.contactWhite,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
                color: AppTheme.contactTextTer, fontSize: 13),
            filled: true,
            fillColor: AppTheme.contactInputBg,
            contentPadding: const EdgeInsets.all(14),
            border: border,
            enabledBorder: border,
            focusedBorder: focusBorder,
          ),
        ),
      ],
    );
  }
}

// ── Console Header ────────────────────────────────────────────────────────────

class _ConsoleHeader extends StatelessWidget {
  const _ConsoleHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _PulseDot(),
        const SizedBox(width: 8),
        SeoText(
          "INQUIRY CONSOLE",
          style: const TextStyle(
            letterSpacing: 3,
            fontSize: 9,
            fontWeight: FontWeight.w700,
            color: AppTheme.contactTextPri,
            fontFamily: 'monospace',
          ),
        ),
        const Spacer(),
        DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0x0DFFFFFF),
            borderRadius: BorderRadius.circular(4),
            border:
                Border.all(color: AppTheme.contactBorderHi, width: 0.5),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Text(
              "ENTERPRISE",
              style: TextStyle(
                color: AppTheme.contactTextPri,
                fontSize: 8,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Submit Button ─────────────────────────────────────────────────────────────

class _SubmitButton extends StatefulWidget {
  final bool isMobile;
  const _SubmitButton({required this.isMobile});

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: widget.isMobile ? 46 : 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: _hovered ? AppTheme.contactWhite : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _hovered
                ? AppTheme.contactWhite
                : AppTheme.contactBorderHi,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(10),
            child: Center(
              child: Text(
                "INITIALIZE CONNECTION",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.5,
                  fontSize: 10,
                  color: _hovered
                      ? Colors.black
                      : AppTheme.contactTextPri,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Footer Row ────────────────────────────────────────────────────────────────

class _FooterRow extends StatelessWidget {
  final bool isMobile;
  final double padH;
  const _FooterRow({required this.isMobile, required this.padH});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padH, vertical: 14),
      child: Row(
        children: [
          SeoLink(
            url: '/product',
            text: 'Product',
            child: const _FooterLinkCol(
                title: "PRODUCT", links: ["Engine", "Cloud"]),
          ),
          const SizedBox(width: 32),
          SeoLink(
            url: '/legal',
            text: 'Legal',
            child: const _FooterLinkCol(
                title: "LEGAL", links: ["Privacy", "Terms"]),
          ),
          const Spacer(),
          if (!isMobile)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                _FadedWordmark(),
                SizedBox(height: 8),
                _SocialRow(),
              ],
            ),
        ],
      ),
    );
  }
}

// ── Hero Section ──────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  final bool isMobile;
  final double selltechFontSize;
  final double headlineFontSize;
  final double subtitleFontSize;

  const _HeroSection({
    required this.isMobile,
    required this.selltechFontSize,
    required this.headlineFontSize,
    required this.subtitleFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              Color(0x00FFFFFF),
              Color(0x0EFFFFFF),
              Color(0x00FFFFFF)
            ],
            stops: [0.0, 0.5, 1.0],
          ).createShader(bounds),
          child: Text(
            "SELLTECH",
            style: TextStyle(
              fontSize: selltechFontSize,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: isMobile ? 4 : 14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.contactBorderHi),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Text(
                    "ENTERPRISE  ·  SOLUTIONS  ·  2026",
                    style: TextStyle(
                      color: AppTheme.contactTextSec,
                      fontSize: 9,
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ),
              SizedBox(height: isMobile ? 12 : 16),
              SeoHeading(
                "Let's Build\nthe Future.",
                align: TextAlign.center,
                style: TextStyle(
                  color: AppTheme.contactTextPri,
                  fontSize: headlineFontSize,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -2,
                  height: 1.05,
                ),
              ),
              SizedBox(height: isMobile ? 10 : 14),
              SeoText(
                "Reach out to our enterprise team for custom solutions.",
                align: TextAlign.center,
                style: TextStyle(
                  color: AppTheme.contactTextSec,
                  fontSize: subtitleFontSize,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Footer Link Col ───────────────────────────────────────────────────────────

class _FooterLinkCol extends StatelessWidget {
  final String title;
  final List<String> links;
  const _FooterLinkCol({required this.title, required this.links});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SeoText(
          title,
          style: const TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
            color: AppTheme.contactTextSec,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 8),
        for (final link in links)
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: SeoText(
              link,
              style: const TextStyle(
                  color: AppTheme.contactFooterLink, fontSize: 12),
            ),
          ),
      ],
    );
  }
}

// ── Faded Wordmark ────────────────────────────────────────────────────────────

class _FadedWordmark extends StatelessWidget {
  const _FadedWordmark();

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [AppTheme.contactShimmer, Color(0x00FFFFFF)],
      ).createShader(bounds),
      child: const Text(
        "SELLTECH",
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 22,
          color: Colors.white,
          letterSpacing: 5,
        ),
      ),
    );
  }
}

// ── Shimmer Line ──────────────────────────────────────────────────────────────

class _ShimmerLine extends StatelessWidget {
  const _ShimmerLine();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            AppTheme.contactShimmer,
            Colors.transparent
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
    );
  }
}

// ── Social Row ────────────────────────────────────────────────────────────────

class _SocialRow extends StatelessWidget {
  const _SocialRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        _SocialIcon(Icons.alternate_email),
        SizedBox(width: 10),
        _SocialIcon(Icons.terminal),
        SizedBox(width: 10),
        _SocialIcon(Icons.public),
      ],
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  const _SocialIcon(this.icon);

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: _hovered
              ? AppTheme.contactWhite.withOpacity(0.07)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              color: _hovered
                  ? AppTheme.contactBorderHi
                  : Colors.transparent),
        ),
        child: Icon(widget.icon,
            size: 13,
            color: _hovered
                ? AppTheme.contactWhite
                : AppTheme.contactTextSec),
      ),
    );
  }
}

// ── Pulse Dot ─────────────────────────────────────────────────────────────────

class _PulseDot extends StatefulWidget {
  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.25, end: 1.0).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppTheme.contactWhite.withOpacity(_anim.value),
        ),
      ),
    );
  }
}

// ── Corner Mark ───────────────────────────────────────────────────────────────

class _CornerMark extends StatelessWidget {
  final bool flipH;
  const _CornerMark({this.flipH = false});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scaleX: flipH ? -1 : 1,
      child: const CustomPaint(
          size: Size(18, 18), painter: _CornerPainter()),
    );
  }
}

class _CornerPainter extends CustomPainter {
  const _CornerPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = AppTheme.contactBorderHi
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset.zero, Offset(size.width, 0), p);
    canvas.drawLine(Offset.zero, Offset(0, size.height), p);
  }

  @override
  bool shouldRepaint(_CornerPainter _) => false;
}

// ── Radar Painter Widget ──────────────────────────────────────────────────────

class _RadarPainterWidget extends StatefulWidget {
  const _RadarPainterWidget();

  @override
  State<_RadarPainterWidget> createState() => _RadarPainterWidgetState();
}

class _RadarPainterWidgetState extends State<_RadarPainterWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 14))
      ..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => CustomPaint(
          painter:
              _RadarPainter(angle: _ctrl.value * 2 * math.pi)),
    );
  }
}

// ── Radar Painter — more visible ──────────────────────────────────────────────

class _RadarPainter extends CustomPainter {
  final double angle;
  const _RadarPainter({required this.angle});

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;
    final cx = size.width / 2;
    final cy = size.height * 0.60;
    final maxR = size.width * 0.36;

    // Rings — boosted opacity from 0.03 to 0.10
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    for (int i = 1; i <= 4; i++) {
      ringPaint.color = Color.fromRGBO(
          255, 255, 255, 0.10 * (5 - i).toDouble());
      canvas.drawCircle(Offset(cx, cy), maxR * i / 4, ringPaint);
    }

    // Cross lines — boosted opacity
    final crossPaint = Paint()
      ..color = const Color(0x28FFFFFF) // was contactRadarRing (~0x0A)
      ..strokeWidth = 0.7;
    canvas.drawLine(
        Offset(cx - maxR, cy), Offset(cx + maxR, cy), crossPaint);
    canvas.drawLine(
        Offset(cx, cy - maxR), Offset(cx, cy + maxR), crossPaint);

    // Sweep line — brighter
    canvas.drawLine(
      Offset(cx, cy),
      Offset(cx + maxR * math.cos(angle),
          cy + maxR * math.sin(angle)),
      Paint()
        ..color = const Color(0x99FFFFFF) // was contactRadarSweep (~0x33)
        ..strokeWidth = 1.2
        ..strokeCap = StrokeCap.round,
    );

    // Sweep arc glow — more opaque trail
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: maxR * 0.43),
      angle - 0.65,
      0.65,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = maxR * 0.85
        ..shader = SweepGradient(
          startAngle: angle - 0.65,
          endAngle: angle,
          colors: const [
            Colors.transparent,
            Color(0x18FFFFFF), // was 0x07 — ~3x brighter
          ],
        ).createShader(
            Rect.fromCircle(center: Offset(cx, cy), radius: maxR * 0.43)),
    );

    // Centre dot
    canvas.drawCircle(
      Offset(cx, cy),
      3,
      Paint()..color = const Color(0x55FFFFFF),
    );
  }

  @override
  bool shouldRepaint(_RadarPainter old) => old.angle != angle;
}

// ── Dot Grid Painter ──────────────────────────────────────────────────────────

class _DotGridPainter extends CustomPainter {
  const _DotGridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.contactDotGrid
      ..strokeCap = StrokeCap.round;
    const spacing = 30.0;
    for (double x = 0; x <= size.width; x += spacing) {
      for (double y = 0; y <= size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 0.75, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DotGridPainter _) => false;
}