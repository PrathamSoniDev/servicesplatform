import 'dart:ui';
import 'package:flutter/material.dart';

class SimpleContentCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final int likes;
  final int views;

  const SimpleContentCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    this.likes = 0,
    this.views = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        children: [
          // 🔹 Background Image
          Positioned.fill(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),

          // 🔹 Bottom Blur Overlay (FIXED)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 180,
            child: ClipRect( // ⭐ IMPORTANT FIX
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.15),
                        Colors.black.withOpacity(0.75),
                      ],
                    ),
                  ),
                  child: _CardContent(
                    title: title,
                    description: description,
                    likes: likes,
                    views: views,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _CardContent extends StatelessWidget {
  final String title;
  final String description;
  final int likes;
  final int views;

  const _CardContent({
    required this.title,
    required this.description,
    required this.likes,
    required this.views,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔹 Title
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 6),

        // 🔹 Description
        Text(
          description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.grey.shade300,
            fontSize: 14,
          ),
        ),

        const Spacer(),

        // 🔹 Actions
        Row(
          children: [
            _iconText(Icons.favorite_border, likes),
            const SizedBox(width: 16),
            _iconText(Icons.remove_red_eye_outlined, views),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.share_outlined, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _iconText(IconData icon, int value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.white),
        const SizedBox(width: 6),
        Text(
          value.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
