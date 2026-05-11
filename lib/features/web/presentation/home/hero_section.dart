import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/presentation/seo/seo_widget.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';
import 'package:servicesplatform/features/web/widgets/button.dart';
import 'package:servicesplatform/features/web/widgets/custom_app_bar.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onAboutTap;
  final VoidCallback onProductTap;
  final VoidCallback onBlogTap;
  final VoidCallback onContactTap;

  const HeroSection({
    super.key,
    required this.onHomeTap,
    required this.onAboutTap,
    required this.onProductTap,
    required this.onBlogTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final size = MediaQuery.of(context).size;
    final isSmallDesktop = size.width < 1100 && !isMobile;

    final double titleSize =
        isMobile
            ? 34
            : isSmallDesktop
            ? 48
            : (size.width * 0.06).clamp(60, 88);
    final double mediumTitleSize =
        isMobile
            ? 28
            : isSmallDesktop
            ? 36
            : (size.width * 0.045).clamp(40, 60);
    final double subTitleSize = isMobile ? 14 : (isSmallDesktop ? 16 : 19);

    const double appBarHeight = 80;

    return Stack(
      children: [
        // ── BASE ──────────────────────────────────────────────────
        const Positioned.fill(child: ColoredBox(color: Color(0xFF060810))),

        // ── LAYER 1: STARFIELD ────────────────────────────────────
        // RepaintBoundary isolates repaints to this layer only
        const Positioned.fill(
          child: RepaintBoundary(child: _StarfieldWidget()),
        ),

        // ── LAYER 2: PLANET ARC GLOW (static — never repaints) ───
        const Positioned.fill(
          child: RepaintBoundary(
            child: CustomPaint(
              painter: _PlanetArcPainter(),
              // isComplex=true → raster cache the heavy planet paint
              isComplex: true,
              willChange: false,
            ),
          ),
        ),

        // ── LAYER 3: ATMOSPHERIC HAZE ─────────────────────────────
        const Positioned.fill(
          child: RepaintBoundary(child: _AtmosphericHazeWidget()),
        ),

        // ── LAYER 4: MOVING PARTICLES ─────────────────────────────
        const Positioned.fill(
          child: RepaintBoundary(child: _ParticlesWidget()),
        ),

        // ── LAYER 5: TOP VIGNETTE (static — never repaints) ───────
        const Positioned.fill(
          child: RepaintBoundary(
            child: CustomPaint(
              painter: _TopVignettePainter(),
              isComplex: true,
              willChange: false,
            ),
          ),
        ),

        // ── HERO CONTENT ──────────────────────────────────────────
        // Wrapped in RepaintBoundary so text never triggers bg repaint
        Positioned.fill(
          child: RepaintBoundary(
            child: Container(
              padding: EdgeInsets.only(
                top: appBarHeight + 20,
                left: isMobile ? 20 : 60,
                right: isMobile ? 20 : 60,
                bottom: 20,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SeoHeading(
                      "Custom Software Development That Scales Your Business",
                      align: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.displayMedium?.copyWith(
                        fontSize: titleSize,
                        height: 1.0,
                        color: Colors.white.withValues(alpha: .35),
                        fontWeight: FontWeight.w600,
                        letterSpacing: -1.0,
                      ),
                    ),

                    const SizedBox(height: 15),

                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "is",
                            style: Theme.of(
                              context,
                            ).textTheme.displayMedium?.copyWith(
                              fontSize: mediumTitleSize,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.fingerprint,
                            size: mediumTitleSize,
                            color: AppTheme.neonGreen,
                            shadows: [
                              Shadow(
                                color: AppTheme.neonGreen.withValues(
                                  alpha: .35,
                                ),
                                blurRadius: 25,
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "human +",
                            style: Theme.of(
                              context,
                            ).textTheme.displayMedium?.copyWith(
                              fontSize: mediumTitleSize,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.auto_awesome,
                            color: AppTheme.neonGreen,
                            size: mediumTitleSize,
                            shadows: [
                              Shadow(
                                color: AppTheme.neonGreen.withValues(alpha: .7),
                                blurRadius: 30,
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "AI",
                            style: Theme.of(
                              context,
                            ).textTheme.displayMedium?.copyWith(
                              fontSize: mediumTitleSize,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: isMobile ? 400 : (isSmallDesktop ? 500 : 650),
                      ),
                      child: SeoText(
                        "Sell Tech Ind. Productions delivers modern mobile applications, scalable software systems, high-converting websites, SaaS platforms, and enterprise-grade digital solutions designed to help startups, businesses, and brands grow faster in the digital world.",
                        align: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: subTitleSize,
                          color: Colors.white.withValues(alpha: .6),
                          height: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        AppButton(
                          text: 'Get In Touch',
                          onPressed: onContactTap,
                          type: AppButtonType.outline,
                          enableBlur: true,
                        ),
                        const SizedBox(width: 40),
                        AppButton(
                          text: 'View Portfolio',
                          onPressed: () {},
                          type: AppButtonType.solid,
                          enableGlow: true,
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.03),
                  ],
                ),
              ),
            ),
          ),
        ),

        // ── APP BAR ───────────────────────────────────────────────
        RepaintBoundary(
          child: CustomAppBar(
            onHomeTap: onHomeTap,
            onAboutTap: onAboutTap,
            onProductTap: onProductTap,
            onBlogTap: onBlogTap,
            onContactTap: onContactTap,
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// LAYER 1 — Starfield
// Single controller shared across build; painter only repaints its own layer
// ═══════════════════════════════════════════════════════════════════════════════

class _StarfieldWidget extends StatefulWidget {
  const _StarfieldWidget();

  @override
  State<_StarfieldWidget> createState() => _StarfieldWidgetState();
}

class _StarfieldWidgetState extends State<_StarfieldWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  // Pre-build star data once at init — never rebuilt
  static final List<List<double>> _stars = () {
    final rng = math.Random(42);
    return List.generate(
      220,
      (_) => [
        rng.nextDouble(),
        rng.nextDouble() * 0.75,
        rng.nextDouble() * 1.4 + 0.3,
        rng.nextDouble() * 2 * math.pi,
      ],
    );
  }();

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
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
      // child: null — painter is cheap, no sub-tree to preserve
      builder:
          (_, __) => CustomPaint(
            painter: _StarfieldPainter(t: _ctrl.value, stars: _stars),
          ),
    );
  }
}

class _StarfieldPainter extends CustomPainter {
  final double t;
  final List<List<double>> stars;

  const _StarfieldPainter({required this.t, required this.stars});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final twBase = t * 2 * math.pi * 0.8;

    for (final s in stars) {
      final twinkle = 0.35 + 0.65 * math.sin(twBase + s[3]);
      paint.color = Color.fromRGBO(255, 255, 255, twinkle * 0.7);
      canvas.drawCircle(
        Offset(s[0] * size.width, s[1] * size.height),
        s[2],
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_StarfieldPainter old) => old.t != t;
}

// ═══════════════════════════════════════════════════════════════════════════════
// LAYER 2 — Planet Arc Glow (static CustomPainter — raster cached)
// ═══════════════════════════════════════════════════════════════════════════════

class _PlanetArcPainter extends CustomPainter {
  const _PlanetArcPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final W = size.width;
    final H = size.height;
    final cx = W * 0.5;
    final cy = H * 1.18;
    final planetR = W * 0.72;
    final planetCenter = Offset(cx, cy);
    final planetRect = Rect.fromCircle(center: planetCenter, radius: planetR);

    // Dark planet body
    canvas.drawCircle(
      planetCenter,
      planetR,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(0, 0.6),
          radius: 1.0,
          colors: const [
            Color(0xFF0D1525),
            Color(0xFF080E1A),
            Color(0xFF050A12),
          ],
          stops: const [0.0, 0.5, 1.0],
        ).createShader(planetRect),
    );

    // Atmospheric rim — batched into one loop, no allocation per frame
    const glowStops = [
      [55.0, 0.03, 50.0],
      [28.0, 0.07, 28.0],
      [14.0, 0.13, 14.0],
      [6.0, 0.20, 6.0],
      [2.0, 0.35, 2.5],
      [0.0, 0.55, 1.2],
    ];

    final rimPaint = Paint()..style = PaintingStyle.stroke;
    for (final g in glowStops) {
      rimPaint
        ..strokeWidth = g[2]
        ..color = Color.fromRGBO(40, 160, 255, g[1])
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, g[2] * 0.6);
      canvas.drawCircle(planetCenter, planetR + g[0], rimPaint);
    }

    // Bright inner rim line (no maskFilter — cheap)
    canvas.drawCircle(
      planetCenter,
      planetR + 1,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
        ..color = const Color(0xBB60C8FF)
        ..maskFilter = null,
    );

    // Surface light
    canvas.drawCircle(
      planetCenter,
      planetR,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(0, -0.92),
          radius: 0.4,
          colors: const [Color(0x183060CC), Colors.transparent],
        ).createShader(planetRect),
    );

    // Horizon bloom
    final bloomRect = Rect.fromLTWH(0, H * 0.55, W, H * 0.45);
    canvas.drawRect(
      bloomRect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: const [
            Color(0x221060CC),
            Color(0x100840AA),
            Colors.transparent,
          ],
          stops: const [0.0, 0.4, 1.0],
        ).createShader(bloomRect),
    );
  }

  @override
  bool shouldRepaint(_PlanetArcPainter _) => false; // static — never repaints
}

// ═══════════════════════════════════════════════════════════════════════════════
// LAYER 3 — Atmospheric Haze
// Slow 8s cycle — pre-computed sin values, minimal allocations
// ═══════════════════════════════════════════════════════════════════════════════

class _AtmosphericHazeWidget extends StatefulWidget {
  const _AtmosphericHazeWidget();

  @override
  State<_AtmosphericHazeWidget> createState() => _AtmosphericHazeWidgetState();
}

class _AtmosphericHazeWidgetState extends State<_AtmosphericHazeWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
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
      builder:
          (_, __) =>
              CustomPaint(painter: _AtmosphericHazePainter(t: _ctrl.value)),
    );
  }
}

class _AtmosphericHazePainter extends CustomPainter {
  final double t;

  const _AtmosphericHazePainter({required this.t});

  @override
  void paint(Canvas canvas, Size size) {
    final W = size.width;
    final H = size.height;

    // Pre-compute trig once
    final tau = t * 2 * math.pi;
    final pulse = 0.6 + 0.4 * math.sin(tau * 0.3);
    final hazeY = H * 0.72 + math.sin(tau * 0.2) * H * 0.01;

    final hazeRect = Rect.fromCenter(
      center: Offset(W * 0.5, hazeY),
      width: W,
      height: 160,
    );

    canvas.drawRect(
      hazeRect,
      Paint()
        ..shader = RadialGradient(
          colors: [
            Color.fromRGBO(30, 100, 220, 0.14 * pulse),
            Color.fromRGBO(10, 50, 140, 0.06 * pulse),
            Colors.transparent,
          ],
          stops: const [0.0, 0.55, 1.0],
        ).createShader(hazeRect),
    );

    final tealRect = Rect.fromCenter(
      center: Offset(W * 0.35, H * 0.70),
      width: W * 0.5,
      height: 120,
    );
    canvas.drawRect(
      tealRect,
      Paint()
        ..shader = RadialGradient(
          colors: [
            Color.fromRGBO(0, 180, 200, 0.07 * pulse),
            Colors.transparent,
          ],
        ).createShader(tealRect),
    );
  }

  @override
  bool shouldRepaint(_AtmosphericHazePainter old) => old.t != t;
}

// ═══════════════════════════════════════════════════════════════════════════════
// LAYER 4 — Moving Particles
// Key optimizations:
//   • Particle list allocated ONCE in initState, never in build/paint
//   • paint() mutates particle positions in-place (no allocations)
//   • LayoutBuilder only re-inits when size actually changes
//   • Paint object reused across all particles
// ═══════════════════════════════════════════════════════════════════════════════

class _Particle {
  double x, y, radius, opacity, phase, speed, sway;

  _Particle({
    required this.x,
    required this.y,
    required this.radius,
    required this.opacity,
    required this.phase,
    required this.speed,
    required this.sway,
  });
}

class _ParticlesWidget extends StatefulWidget {
  const _ParticlesWidget();

  @override
  State<_ParticlesWidget> createState() => _ParticlesWidgetState();
}

class _ParticlesWidgetState extends State<_ParticlesWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  List<_Particle> _particles = [];
  final _rng = math.Random(13);
  Size _lastSize = Size.zero;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    )..repeat();
  }

  void _initParticles(Size size) {
    if (size == _lastSize) return;
    _lastSize = size;
    final n = (size.width * size.height / 6000).clamp(50, 160).toInt();
    _particles = List.generate(
      n,
      (_) => _Particle(
        x: _rng.nextDouble() * size.width,
        y: _rng.nextDouble() * size.height,
        radius: _rng.nextDouble() * 1.5 + 0.2,
        opacity: _rng.nextDouble() * 0.55 + 0.08,
        phase: _rng.nextDouble() * 2 * math.pi,
        speed: _rng.nextDouble() * 0.30 + 0.05,
        sway: _rng.nextDouble() * 3.0 + 0.5,
      ),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, box) {
        _initParticles(Size(box.maxWidth, box.maxHeight));
        return AnimatedBuilder(
          animation: _ctrl,
          builder:
              (_, __) => CustomPaint(
                painter: _ParticlesPainter(
                  particles: _particles,
                  t: _ctrl.value,
                  canvasHeight: _lastSize.height,
                ),
              ),
        );
      },
    );
  }
}

class _ParticlesPainter extends CustomPainter {
  final List<_Particle> particles;
  final double t;
  final double canvasHeight;

  const _ParticlesPainter({
    required this.particles,
    required this.t,
    required this.canvasHeight,
  });

  // Single reused Paint object — no per-particle allocation
  static final _paint = Paint()..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    final tau = t * 2 * math.pi;
    final swayBase = tau * 0.25;
    final twBase = tau * 1.1;

    for (final p in particles) {
      p.y -= p.speed;
      if (p.y < -4) p.y = size.height + 4;

      final sx = p.x + math.sin(swayBase + p.phase) * p.sway;
      final tw = p.opacity * (0.3 + 0.7 * math.sin(twBase + p.phase));

      final yFrac = p.y / canvasHeight;
      _paint.color =
          yFrac > 0.65
              ? Color.fromRGBO(100, 180, 255, tw.clamp(0.0, 1.0))
              : Color.fromRGBO(255, 255, 255, tw.clamp(0.0, 1.0));

      canvas.drawCircle(Offset(sx, p.y), p.radius, _paint);
    }
  }

  @override
  bool shouldRepaint(_ParticlesPainter old) => old.t != t;
}

// ═══════════════════════════════════════════════════════════════════════════════
// LAYER 5 — Top Vignette (static — raster cached, never repaints)
// ═══════════════════════════════════════════════════════════════════════════════

class _TopVignettePainter extends CustomPainter {
  const _TopVignettePainter();

  @override
  void paint(Canvas canvas, Size size) {
    // Top fade
    final topRect = Rect.fromLTWH(0, 0, size.width, size.height * 0.35);
    canvas.drawRect(
      topRect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xCC060810), Colors.transparent],
        ).createShader(topRect),
    );

    // Edge vignette
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..shader = RadialGradient(
          center: Alignment.center,
          radius: 0.9,
          colors: const [Colors.transparent, Color(0x88060810)],
          stops: const [0.45, 1.0],
        ).createShader(Offset.zero & size),
    );
  }

  @override
  bool shouldRepaint(_TopVignettePainter _) => false;
}
