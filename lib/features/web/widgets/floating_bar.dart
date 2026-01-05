import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LuxuryFloatingBottomBar extends StatefulWidget {
  final bool isMobile;
  final String views;
  final String likes;
  final VoidCallback? onLike;
  final VoidCallback? onHire;
  final VoidCallback? onBookmark;
  final VoidCallback? onShare;

  const LuxuryFloatingBottomBar({
    super.key,
    required this.isMobile,
    required this.views,
    required this.likes,
    this.onLike,
    this.onHire,
    this.onBookmark,
    this.onShare,
  });

  @override
  State<LuxuryFloatingBottomBar> createState() => _LuxuryFloatingBottomBarState();
}

class _LuxuryFloatingBottomBarState extends State<LuxuryFloatingBottomBar> {
  // Local states to handle color changes on click
  bool _isLiked = false;
  bool _isBookmarked = false;
  bool _isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return widget.isMobile ? _buildHorizontalMobile() : _buildVerticalSidebar();
  }

  Widget _buildVerticalSidebar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 90,
          padding: const EdgeInsets.symmetric(vertical: 30),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildProfileAvatar(),
              const SizedBox(height: 30),
              _buildItem(
                icon: Icons.mail_outline_rounded,
                label: "Hire",
                bg: Colors.white,
                iconCol: Colors.black,
                onTap: widget.onHire,
              ),
              const SizedBox(height: 25),
              _buildItem(
                icon: Icons.psychology_outlined,
                label: "Tools",
                bg: Colors.white.withOpacity(0.1),
                iconCol: Colors.white,
              ),
              const SizedBox(height: 25),
              _buildItem(
                icon: _isBookmarked ? Icons.folder_rounded : Icons.folder_open_rounded,
                label: "Save",
                bg: _isBookmarked ? Colors.amber.withOpacity(0.2) : Colors.white.withOpacity(0.1),
                iconCol: _isBookmarked ? Colors.amber : Colors.white,
                onTap: () {
                  setState(() => _isBookmarked = !_isBookmarked);
                  widget.onBookmark?.call();
                },
              ),
              const SizedBox(height: 25),
              _buildItem(
                icon: Icons.ios_share_rounded,
                label: "Share",
                bg: Colors.white.withOpacity(0.1),
                iconCol: Colors.white,
                onTap: widget.onShare,
              ),
              const SizedBox(height: 30),
              _buildItem(
                icon: Icons.thumb_up_rounded,
                label: "Appreciate",
                bg: _isLiked ? Colors.blueAccent : Colors.white.withOpacity(0.1),
                iconCol: _isLiked ? Colors.white : Colors.blueAccent,
                isBig: true,
                onTap: () {
                  HapticFeedback.lightImpact(); // Professional haptic touch
                  setState(() => _isLiked = !_isLiked);
                  widget.onLike?.call();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem({
    required IconData icon,
    required String label,
    required Color bg,
    required Color iconCol,
    VoidCallback? onTap,
    bool isBig = false,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isBig ? 60 : 50,
            width: isBig ? 60 : 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bg,
              boxShadow: _isLiked && isBig 
                ? [BoxShadow(color: Colors.blueAccent.withOpacity(0.3), blurRadius: 15)] 
                : [],
            ),
            child: Icon(icon, color: iconCol, size: isBig ? 24 : 20),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildProfileAvatar() {
    return GestureDetector(
      onTap: () => setState(() => _isFollowing = !_isFollowing),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _isFollowing ? Colors.greenAccent : Colors.blueAccent,
                width: 2,
              ),
            ),
            child: const CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=9'),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _isFollowing ? "Following" : "Follow",
            style: TextStyle(
              color: _isFollowing ? Colors.greenAccent : Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalMobile() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => setState(() => _isLiked = !_isLiked),
                  icon: Icon(
                    _isLiked ? Icons.thumb_up_rounded : Icons.thumb_up_outlined,
                    color: _isLiked ? Colors.blueAccent : Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: widget.onHire,
                  icon: const Icon(Icons.mail_outline_rounded, color: Colors.white),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () => setState(() => _isBookmarked = !_isBookmarked),
                  icon: Icon(
                    _isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_outline,
                    color: _isBookmarked ? Colors.amber : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}