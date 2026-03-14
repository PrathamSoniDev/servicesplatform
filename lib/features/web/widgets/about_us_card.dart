import 'dart:ui';
import 'package:flutter/material.dart';

class AboutUsGlassCard extends StatelessWidget {
  final bool isMobile;
  final AnimationController controller;

  const AboutUsGlassCard({
    super.key, 
    required this.isMobile, 
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    final Animation<Offset> slide = Tween<Offset>(
      begin: const Offset(0.2, 0.1), 
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller, 
      curve: const Interval(0.5, 1.0, curve: Curves.easeOutCubic),
    ));

    return FadeTransition(
      opacity: CurvedAnimation(parent: controller, curve: const Interval(0.5, 0.9)),
      child: SlideTransition(
        position: slide,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              width: isMobile ? 280 : 360,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                // Dark SaaS background
                color: const Color(0xFF1E2022).withOpacity(0.85), 
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 25),
                  _buildSectionTitle("Certifications"),
                  const Row(
                    children: [
                      Expanded(child: _MiniProgressCard(title: "ML Engineer", progress: 0.8)),
                      SizedBox(width: 12),
                      Expanded(child: _MiniProgressCard(title: "Data Scientist", progress: 0.4)),
                    ],
                  ),
                  const SizedBox(height: 25),
                  _buildSectionTitle("Badges"),
                  const Row(
                    children: [
                      _HexBadge(label: "PyTorch", icon: Icons.bolt),
                      SizedBox(width: 20),
                      _HexBadge(label: "Python", icon: Icons.terminal),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundImage: NetworkImage("https://randomuser.me/api/portraits/women/44.jpg"),
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Ada", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
            Text("ML Engineer", style: TextStyle(fontSize: 12, color: Colors.white60)),
          ],
        )
      ],
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text, 
        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _MiniProgressCard extends StatelessWidget {
  final String title;
  final double progress;
  const _MiniProgressCard({required this.title, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white70, fontSize: 9), maxLines: 1),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white10,
            color: const Color(0xFF00E676), // Brand Green
            minHeight: 2,
          ),
        ],
      ),
    );
  }
}

class _HexBadge extends StatelessWidget {
  final String label;
  final IconData icon;
  const _HexBadge({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40, height: 45,
          decoration: const ShapeDecoration(
            color: Color(0xFF2D3436), 
            shape: _HexagonBorder(),
          ),
          child: Icon(icon, color: const Color(0xFF00E676), size: 18),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 9)),
      ],
    );
  }
}

class _HexagonBorder extends ShapeBorder {
  const _HexagonBorder();
  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;
  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => getOuterPath(rect);
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..moveTo(rect.width * 0.5, 0)
      ..lineTo(rect.width, rect.height * 0.25)
      ..lineTo(rect.width, rect.height * 0.75)
      ..lineTo(rect.width * 0.5, rect.height)
      ..lineTo(0, rect.height * 0.75)
      ..lineTo(0, rect.height * 0.25)
      ..close();
  }
  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}
  @override
  ShapeBorder scale(double t) => this;
}