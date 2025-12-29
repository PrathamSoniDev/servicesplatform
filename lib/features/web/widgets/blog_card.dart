import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:servicesplatform/features/web/models/blog_model.dart';

class BlogCard extends StatefulWidget {
  final BlogModel blog;
  final VoidCallback? onTap;

  const BlogCard({super.key, required this.blog, this.onTap});

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: isHovered 
            ? (Matrix4.identity()..translate(0, -8, 0)) 
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: const Color(0xFF121212), // Premium Obsidian
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isHovered ? Colors.white.withOpacity(0.2) : Colors.white.withOpacity(0.08),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(24),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ImageSection(blog: widget.blog, isHovered: isHovered),
                _ContentSection(blog: widget.blog),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ImageSection extends StatelessWidget {
  final BlogModel blog;
  final bool isHovered;
  const _ImageSection({required this.blog, required this.isHovered});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Hero tag matches the detail screen for a seamless transition
        Hero(
          tag: 'blog_image_${blog.id}', 
          child: AnimatedScale(
            scale: isHovered ? 1.05 : 1.0,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutQuart,
            child: AspectRatio(
              aspectRatio: 16 / 10,
              child: Image.network(
                blog.imageUrl,
                fit: BoxFit.cover,
                // Error handling for network images
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[900],
                  child: const Icon(Icons.broken_image, color: Colors.white24),
                ),
              ),
            ),
          ),
        ),
        // Gradient overlay for better text readability and depth
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.6, 1.0],
                colors: [
                  Colors.black.withOpacity(0.4),
                  Colors.transparent,
                  Colors.black.withOpacity(0.2),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 16,
          top: 16,
          child: _CategoryChip(text: blog.category),
        ),
      ],
    );
  }
}

class _ContentSection extends StatelessWidget {
  final BlogModel blog;
  const _ContentSection({required this.blog});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat("MMM dd, yyyy").format(blog.publishedAt);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            blog.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
              height: 1.2,
              color: Colors.white,
              fontFamily: 'Outfit', // Using the font from your Hero Section
            ),
          ),
          const SizedBox(height: 12),
          Text(
            blog.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 24),
          // Footer: Author and Read Time
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white12),
                  image: const DecorationImage(
                    image: NetworkImage("https://ui-avatars.com/api/?background=random&color=fff"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      blog.authorName,
                      style: const TextStyle(
                        fontSize: 13, 
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "$date • ${blog.readMinutes} min read",
                      style: TextStyle(
                        fontSize: 11, 
                        color: Colors.white.withOpacity(0.4),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_rounded,
                size: 18,
                color: Colors.white.withOpacity(0.3),
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        // backdropFilter: const ColorFilter.mode(Colors.black12, BlendMode.blur),
      ),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 10,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
    );
  }
}