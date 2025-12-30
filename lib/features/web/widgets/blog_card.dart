import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BlogCard extends StatefulWidget {
  final dynamic blog;
  final VoidCallback? onTap;

  const BlogCard({super.key, required this.blog, this.onTap});

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    if (widget.blog == null) return const SizedBox.shrink();

    final bool isMobile = MediaQuery.of(context).size.width < 600;
    final dateStr = DateFormat("dd MMM, yyyy").format(widget.blog.publishedAt).toLowerCase();

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: isHovered ? (Matrix4.identity()..translate(0, -10, 0)) : Matrix4.identity(),
        decoration: BoxDecoration(
          color: const Color(0xFF0D0D0D),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: isHovered ? Colors.white.withOpacity(0.2) : Colors.white.withOpacity(0.08),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isHovered ? 0.5 : 0.2),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: InkWell(
            onTap: widget.onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- IMAGE ---
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Hero(
                    tag: 'blog_image_${widget.blog.id}',
                    child: Image.network(
                      widget.blog.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.white10,
                        child: const Icon(Icons.broken_image_outlined, color: Colors.white24),
                      ),
                    ),
                  ),
                ),

                // --- CONTENT ---
                Expanded( // KEY: Ensures content fits the GridView cell
                  child: Padding(
                    padding: EdgeInsets.all(isMobile ? 16 : 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _CategoryChip(text: widget.blog.category),
                            Text(
                              "${widget.blog.readMinutes} min read",
                              style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 11),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.blog.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: isMobile ? 17 : 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        
                        // DESCRIPTION: Wrapped in Expanded to prevent overflow
                        Expanded(
                          child: Text(
                            widget.blog.description,
                            maxLines: isMobile ? 2 : 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.5,
                              color: Colors.white.withOpacity(0.4),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // FOOTER
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.white12,
                              child: Icon(Icons.person, size: 14, color: Colors.white54),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                widget.blog.authorName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white70, fontSize: 12),
                              ),
                            ),
                            Text(dateStr, style: TextStyle(color: Colors.white24, fontSize: 11)),
                          ],
                        ),
                        
                        const SizedBox(height: 16),

                        // BUTTON
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: isHovered ? Colors.white : Colors.transparent,
                            border: Border.all(color: isHovered ? Colors.white : Colors.white12),
                          ),
                          child: Center(
                            child: Text(
                              "Read More",
                              style: TextStyle(
                                color: isHovered ? Colors.black : Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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

class _CategoryChip extends StatelessWidget {
  final String text;
  const _CategoryChip({required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.black),
      ),
    );
  }
}