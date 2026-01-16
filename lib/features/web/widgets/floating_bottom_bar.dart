import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LuxuryFloatingBottomBar extends StatelessWidget {
  final bool isMobile;
  final VoidCallback? onLike;
  final VoidCallback? onShare;
  final VoidCallback? onSave;

  final String? views;
  final String? likes;
  final VoidCallback? onHire;

  final bool isLiked;
  final bool isSaved;

  const LuxuryFloatingBottomBar({
    super.key,
    required this.isMobile,
    required this.isLiked,
    required this.isSaved,
    this.onLike,
    this.onShare,
    this.onSave,
    this.views,
    this.likes,
    this.onHire,
  });

  @override
  Widget build(BuildContext context) {
    return _buildVerticalGlassBar(context);
  }

  Widget _buildVerticalGlassBar(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          width: 80,
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .03),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: Colors.white.withValues(alpha: .12),
              width: 0.8,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .3),
                blurRadius: 40,
                spreadRadius: -10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildVerticalAction(
                icon:
                    isLiked
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                label: "LIKE",
                color: isLiked ? Colors.pinkAccent : Colors.white,
                isActive: isLiked,
                onTap: () {
                  HapticFeedback.mediumImpact();
                  onLike?.call(); // 🔑 Bloc decides
                },
              ),
              _divider(),
              _buildVerticalAction(
                icon: Icons.ios_share_rounded,
                label: "SHARE",
                color: Colors.white,
                isActive: false,
                onTap: () {
                  HapticFeedback.lightImpact();
                  onShare?.call();
                },
              ),
              _divider(),
              _buildVerticalAction(
                icon:
                    isSaved
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_border_rounded,
                label: "SAVE",
                color: isSaved ? Colors.amberAccent : Colors.white,
                isActive: isSaved,
                onTap: () {
                  HapticFeedback.mediumImpact();
                  onSave?.call();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerticalAction({
    required IconData icon,
    required String label,
    required Color color,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 18),
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow:
              isActive
                  ? [
                    BoxShadow(
                      color: color.withValues(alpha: .15),
                      blurRadius: 20,
                    ),
                  ]
                  : [],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color.withValues(alpha: isActive ? 1 : 0.7),
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: color.withValues(alpha: isActive ? 0.9 : 0.3),
                fontSize: 8,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 30,
      height: 1,
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white.withValues(alpha: .06),
    );
  }
}
