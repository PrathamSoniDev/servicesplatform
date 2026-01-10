import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LuxuryFloatingBottomBar extends StatefulWidget {
  final bool isMobile;
  final VoidCallback? onLike;
  final VoidCallback? onShare;
  final VoidCallback? onSave;

  // Kept for compatibility with your existing parent widgets
  final String? views;
  final String? likes;
  final VoidCallback? onHire;

  const LuxuryFloatingBottomBar({
    super.key,
    required this.isMobile,
    this.onLike,
    this.onShare,
    this.onSave,
    this.views,
    this.likes,
    this.onHire,
  });

  @override
  State<LuxuryFloatingBottomBar> createState() => _LuxuryFloatingBottomBarState();
}

class _LuxuryFloatingBottomBarState extends State<LuxuryFloatingBottomBar> {
  bool _isLiked = false;
  bool _isSaved = false;

  @override
  Widget build(BuildContext context) {
    return _buildVerticalGlassBar();
  }

  Widget _buildVerticalGlassBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30), // Enhanced luxury blur
        child: Container(
          width: 80, // Fixed width for a consistent vertical look
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.03),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: Colors.white.withOpacity(0.12),
              width: 0.8,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 40,
                spreadRadius: -10,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // LIKE ACTION
              _buildVerticalAction(
                icon: _isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                label: "LIKE",
                color: _isLiked ? Colors.pinkAccent : Colors.white,
                isActive: _isLiked,
                onTap: () {
                  HapticFeedback.mediumImpact();
                  setState(() => _isLiked = !_isLiked);
                  widget.onLike?.call();
                },
              ),
              
              _buildHorizontalDivider(),

              // SHARE ACTION
              _buildVerticalAction(
                icon: Icons.ios_share_rounded,
                label: "SHARE",
                color: Colors.white,
                isActive: false,
                onTap: () {
                  HapticFeedback.lightImpact();
                  widget.onShare?.call();
                },
              ),

              _buildHorizontalDivider(),

              // SAVE ACTION
              _buildVerticalAction(
                icon: _isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                label: "SAVE",
                color: _isSaved ? Colors.amberAccent : Colors.white,
                isActive: _isSaved,
                onTap: () {
                  HapticFeedback.mediumImpact();
                  setState(() => _isSaved = !_isSaved);
                  widget.onSave?.call();
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
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: isActive ? [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 20,
            )
          ] : [],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color.withOpacity(isActive ? 1.0 : 0.7),
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: color.withOpacity(isActive ? 0.9 : 0.3),
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

  Widget _buildHorizontalDivider() {
    return Container(
      width: 30,
      height: 1,
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white.withOpacity(0.06),
    );
  }
}