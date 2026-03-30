import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/presentation/seo/seo_widget.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';
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

    final double titleSize = isMobile
        ? 34
        : isSmallDesktop
            ? 48
            : (size.width * 0.06).clamp(60, 88);

    final double subTitleSize = isMobile ? 14 : (isSmallDesktop ? 16 : 19);

    const double appBarHeight = 80;

    return Stack(
      children: [
        // ── BASE: near-black deep space ──────────────────────────
        Positioned.fill(
          child: ColoredBox(color: const Color(0xFF060810)),
        ),

        // ── LAYER 1: STARFIELD ────────────────────────────────────
        Positioned.fill(
          child: RepaintBoundary(child: const _StarfieldWidget()),
        ),

        // ── LAYER 2: PLANET ARC GLOW ──────────────────────────────
        Positioned.fill(
          child: CustomPaint(painter: const _PlanetArcPainter()),
        ),

        // ── LAYER 3: ATMOSPHERIC HAZE ─────────────────────────────
        Positioned.fill(
          child: RepaintBoundary(child: const _AtmosphericHazeWidget()),
        ),

        // ── LAYER 4: MOVING PARTICLES ─────────────────────────────
        Positioned.fill(
          child: RepaintBoundary(child: const _ParticlesWidget()),
        ),

        // ── LAYER 5: TOP VIGNETTE ─────────────────────────────────
        Positioned.fill(
          child: CustomPaint(painter: const _TopVignettePainter()),
        ),

        // ── HERO CONTENT ──────────────────────────────────────────
        Positioned.fill(
          child: Container(
            padding: EdgeInsets.only(
              top: appBarHeight + 20,
              left: isMobile ? 20 : 60,
              right: isMobile ? 20 : 60,
              bottom: 20,
            ),
            child: Center(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SeoHeading(
                      "The future of development",
                      align: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                            fontSize: titleSize,
                            height: 1.0,
                            color: Colors.white.withOpacity(.35),
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
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontSize: titleSize,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.fingerprint,
                            size: isMobile ? 50 : (isSmallDesktop ? 70 : 110),
                            color: AppTheme.neonGreen,
                            shadows: [
                              Shadow(
                                color: AppTheme.neonGreen.withOpacity(.35),
                                blurRadius: 25,
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "human +",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontSize: titleSize,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.auto_awesome,
                            color: AppTheme.neonGreen,
                            size: isMobile ? 40 : (isSmallDesktop ? 60 : 90),
                            shadows: [
                              Shadow(
                                color: AppTheme.neonGreen.withOpacity(.7),
                                blurRadius: 30,
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "AI",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontSize: titleSize,
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
                        maxWidth:
                            isMobile ? 400 : (isSmallDesktop ? 500 : 650),
                      ),
                      child: SeoText(
                        "We help you map the skills you need, track the skills you have, and close your gaps to thrive in a GenAI world.",
                        align: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontSize: subTitleSize,
                                  color: Colors.white.withOpacity(.6),
                                  height: 1.5,
                                ),
                      ),
                    ),

                    SizedBox(height: size.height * 0.03),
                  ],
                ),
              ),
            ),
          ),
        ),

        // ── APP BAR (ON TOP) ──────────────────────────────────────
        CustomAppBar(
          onHomeTap: onHomeTap,
          onAboutTap: onAboutTap,
          onProductTap: onProductTap,
          onBlogTap: onBlogTap,
          onContactTap: onContactTap,
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// LAYER 1 — Starfield (static dots, seed-deterministic)
// ═══════════════════════════════════════════════════════════════════════════════

class _StarfieldWidget extends StatefulWidget {
  const _StarfieldWidget();
  @override
  State<_StarfieldWidget> createState() => _StarfieldWidgetState();
}

class _StarfieldWidgetState extends State<_StarfieldWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 6))
      ..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _ctrl,
        builder: (_, __) =>
            CustomPaint(painter: _StarfieldPainter(t: _ctrl.value)),
      );
}

class _StarfieldPainter extends CustomPainter {
  final double t;
  const _StarfieldPainter({required this.t});

  // Pre-generated star positions (x%, y%, size, twinkle phase)
  static final List<List<double>> _stars = () {
    final rng = math.Random(42);
    return List.generate(220, (_) => [
          rng.nextDouble(),
          rng.nextDouble() * 0.75, // only upper 75% — planet covers bottom
          rng.nextDouble() * 1.4 + 0.3,
          rng.nextDouble() * 2 * math.pi,
        ]);
  }();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (final s in _stars) {
      final twinkle = 0.35 + 0.65 * math.sin(t * 2 * math.pi * 0.8 + s[3]);
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
// LAYER 2 — Planet Arc Glow (static — the hero element)
// A massive dark sphere rising from bottom with glowing blue atmospheric rim
// ═══════════════════════════════════════════════════════════════════════════════

class _PlanetArcPainter extends CustomPainter {
  const _PlanetArcPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final W = size.width;
    final H = size.height;

    // Planet center sits well below the visible area so only the arc shows
    final cx = W * 0.5;
    final cy = H * 1.18; // below bottom edge
    final planetR = W * 0.72; // big radius so arc spans full width

    // ── Dark planet body fill ─────────────────────────────────
    final bodyPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0, 0.6),
        radius: 1.0,
        colors: const [
          Color(0xFF0D1525),
          Color(0xFF080E1A),
          Color(0xFF050A12),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: planetR));

    canvas.drawCircle(Offset(cx, cy), planetR, bodyPaint);

    // ── Atmospheric rim — wide teal/blue glow ─────────────────
    // Painted as concentric arcs with decreasing opacity
    final glowStops = [
      // [extraRadius, alpha, blur-equivalent via strokeWidth]
      [55.0, 0.03, 50.0],
      [28.0, 0.07, 28.0],
      [14.0, 0.13, 14.0],
      [6.0,  0.20,  6.0],
      [2.0,  0.35,  2.5],
      [0.0,  0.55,  1.2],
    ];

    for (final g in glowStops) {
      final r = planetR + g[0];
      canvas.drawCircle(
        Offset(cx, cy),
        r,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = g[2]
          ..color = Color.fromRGBO(40, 160, 255, g[1])
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, g[2] * 0.6),
      );
    }

    // ── Bright inner rim line ─────────────────────────────────
    canvas.drawCircle(
      Offset(cx, cy),
      planetR + 1,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
        ..color = const Color(0xBB60C8FF),
    );

    // ── Top-of-planet surface light (like sunlight hitting limb)
    canvas.drawCircle(
      Offset(cx, cy),
      planetR,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(0, -0.92),
          radius: 0.4,
          colors: const [
            Color(0x183060CC),
            Colors.transparent,
          ],
        ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: planetR)),
    );

    // ── Horizon glow spill above arc (upward bloom) ───────────
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
  bool shouldRepaint(_PlanetArcPainter _) => false;
}

// ═══════════════════════════════════════════════════════════════════════════════
// LAYER 3 — Atmospheric Haze
// Slow-pulsing blue/teal nebula haze that sits above the planet rim
// ═══════════════════════════════════════════════════════════════════════════════

class _AtmosphericHazeWidget extends StatefulWidget {
  const _AtmosphericHazeWidget();
  @override
  State<_AtmosphericHazeWidget> createState() =>
      _AtmosphericHazeWidgetState();
}

class _AtmosphericHazeWidgetState extends State<_AtmosphericHazeWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 8))
      ..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _ctrl,
        builder: (_, __) =>
            CustomPaint(painter: _AtmosphericHazePainter(t: _ctrl.value)),
      );
}

class _AtmosphericHazePainter extends CustomPainter {
  final double t;
  const _AtmosphericHazePainter({required this.t});

  @override
  void paint(Canvas canvas, Size size) {
    final W = size.width;
    final H = size.height;
    final pulse = 0.6 + 0.4 * math.sin(t * 2 * math.pi * 0.3);

    // Wide central blue haze centred around horizon area
    final hazeY = H * 0.72 + math.sin(t * 2 * math.pi * 0.2) * H * 0.01;
    final hazeRect =
        Rect.fromCenter(center: Offset(W * 0.5, hazeY), width: W, height: 160);

    canvas.drawRect(
      hazeRect,
      Paint()
        ..shader = RadialGradient(
          center: Alignment.center,
          radius: 1.0,
          colors: [
            Color.fromRGBO(30, 100, 220, 0.14 * pulse),
            Color.fromRGBO(10, 50, 140, 0.06 * pulse),
            Colors.transparent,
          ],
          stops: const [0.0, 0.55, 1.0],
        ).createShader(hazeRect),
    );

    // Subtle teal accent left of center
    final tealRect = Rect.fromCenter(
        center: Offset(W * 0.35, H * 0.70), width: W * 0.5, height: 120);
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
// Slow upward-drifting luminous specks — like light dust over the planet
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
        vsync: this, duration: const Duration(seconds: 14))
      ..repeat();
  }

  void _init(Size size) {
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
    return LayoutBuilder(builder: (ctx, box) {
      _init(Size(box.maxWidth, box.maxHeight));
      return AnimatedBuilder(
        animation: _ctrl,
        builder: (_, __) => CustomPaint(
          painter: _ParticlesPainter(particles: _particles, t: _ctrl.value),
        ),
      );
    });
  }
}

class _ParticlesPainter extends CustomPainter {
  final List<_Particle> particles;
  final double t;
  const _ParticlesPainter({required this.particles, required this.t});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (final p in particles) {
      // Drift upward
      p.y -= p.speed;
      if (p.y < -4) p.y = size.height + 4;

      // Sway side to side
      final sx = p.x + math.sin(t * 2 * math.pi * 0.25 + p.phase) * p.sway;

      // Twinkle
      final tw =
          p.opacity * (0.3 + 0.7 * math.sin(t * 2 * math.pi * 1.1 + p.phase));

      // Particles near bottom (planet surface) get a slight blue tint
      final yFrac = p.y / size.height;
      if (yFrac > 0.65) {
        paint.color = Color.fromRGBO(100, 180, 255, tw.clamp(0.0, 1.0));
      } else {
        paint.color = Color.fromRGBO(255, 255, 255, tw.clamp(0.0, 1.0));
      }

      canvas.drawCircle(Offset(sx, p.y), p.radius, paint);
    }
  }

  @override
  bool shouldRepaint(_ParticlesPainter old) => old.t != t;
}

// ═══════════════════════════════════════════════════════════════════════════════
// LAYER 5 — Top & Edge Vignette (static)
// ═══════════════════════════════════════════════════════════════════════════════

class _TopVignettePainter extends CustomPainter {
  const _TopVignettePainter();

  @override
  void paint(Canvas canvas, Size size) {
    // Top fade to near-black
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height * 0.35),
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xCC060810),
            Colors.transparent,
          ],
        ).createShader(
            Rect.fromLTWH(0, 0, size.width, size.height * 0.35)),
    );

    // Edge radial crush
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()
        ..shader = RadialGradient(
          center: Alignment.center,
          radius: 0.9,
          colors: [Colors.transparent, const Color(0x88060810)],
          stops: const [0.45, 1.0],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
    );
  }

  @override
  bool shouldRepaint(_TopVignettePainter _) => false;
}