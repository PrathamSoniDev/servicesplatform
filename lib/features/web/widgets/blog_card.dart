import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/blog_model.dart';

class BlogCard extends StatelessWidget {
  final BlogModel blog;
  final VoidCallback? onTap;

  const BlogCard({super.key, required this.blog, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0E0E0E),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_ImageSection(blog: blog), _ContentSection(blog: blog)],
        ),
      ),
    );
  }
}

/* ---------------- Image Section ---------------- */

class _ImageSection extends StatelessWidget {
  final BlogModel blog;
  const _ImageSection({required this.blog});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16 / 10,
          child: Image.network(blog.imageUrl, fit: BoxFit.cover),
        ),

        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black.withOpacity(0.35), Colors.transparent],
              ),
            ),
          ),
        ),

        Positioned(
          left: 12,
          top: 12,
          child: _CategoryChip(text: blog.category),
        ),
      ],
    );
  }
}

/* ---------------- Content Section ---------------- */

class _ContentSection extends StatelessWidget {
  final BlogModel blog;
  const _ContentSection({required this.blog});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat("dd MMM, yyyy").format(blog.publishedAt);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                blog.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "${blog.readMinutes}min read",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            blog.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              height: 1.45,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 18),

          Row(
            children: [
              const CircleAvatar(radius: 10, backgroundColor: Colors.white24),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  blog.authorName,
                  style: const TextStyle(fontSize: 13, color: Colors.white70),
                ),
              ),
              Text(
                date,
                style: const TextStyle(fontSize: 12, color: Colors.white38),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String text;
  const _CategoryChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}
