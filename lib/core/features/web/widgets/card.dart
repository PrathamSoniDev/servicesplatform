import 'package:flutter/material.dart';
import 'package:servicesplatform/core/features/web/widgets/animated_border.dart';
import '../models/design_item_models.dart';

class LuxuryCard extends StatelessWidget {
  final DesignItem item;
  final bool hovered;

  const LuxuryCard({
    super.key,
    required this.item,
    required this.hovered,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // MAIN CARD CLIPPING
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // BACKGROUND IMAGE
              Positioned.fill(
                child: AnimatedScale(
                  scale: hovered ? 1.1 : 1.0,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutCubic,
                  child: Image.network(item.image, fit: BoxFit.cover),
                ),
              ),

              // OVERLAY GRADIENT
              Positioned.fill(
                child: AnimatedOpacity(
                  opacity: hovered ? 1 : 0,
                  duration: const Duration(milliseconds: 400),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.1),
                          Colors.black.withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // CONTENT
              Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: _CardContent(item: item, visible: hovered),
              ),
            ],
          ),
        ),

        // ANIMATED BORDER (Only on hover)
        Positioned.fill(
          child: IgnorePointer(
            child: AnimatedOpacity(
              opacity: hovered ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: AnimatedBorder(
                radius: 20,
                strokeWidth: 3.0,
                child: Container(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CardContent extends StatelessWidget {
  final DesignItem item;
  final bool visible;

  const _CardContent({required this.item, required this.visible});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: const Duration(milliseconds: 300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            item.title,
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            item.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _stat(Icons.remove_red_eye_outlined, item.views),
              const SizedBox(width: 16),
              _stat(Icons.favorite_border_rounded, item.likes),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.white10, shape: BoxShape.circle),
                child: const Icon(Icons.share_outlined, color: Colors.white, size: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stat(IconData icon, String val) => Row(
    children: [
      Icon(icon, color: Colors.white70, size: 16),
      const SizedBox(width: 4),
      Text(val, style: const TextStyle(color: Colors.white70, fontSize: 12)),
    ],
  );
}