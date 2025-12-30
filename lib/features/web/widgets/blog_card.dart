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
    if (widget.blog == null) {
      return const SizedBox.shrink(); 
    }

    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;
    
    final dateStr = DateFormat("dd MMM, yyyy")
        .format(widget.blog.publishedAt)
        .toLowerCase();

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: isHovered 
            ? (Matrix4.identity()..translate(0, -10, 0)) 
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: const Color(0xFF0D0D0D),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: isHovered ? Colors.white.withOpacity(0.2) : Colors.white.withOpacity(0.08),
            width: 1,
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
              mainAxisSize: MainAxisSize.min, // KEY: Card wraps its content
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- IMAGE SECTION ---
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

                // --- CONTENT SECTION ---
                // We use Flexible to ensure this section can shrink if the grid height is restricted
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16 : 24,
                      vertical: 20,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // KEY: Button stays inside
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category & Time
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _CategoryChip(text: widget.blog.category),
                            Text(
                              "${widget.blog.readMinutes} min read",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.4),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Title
                        Text(
                          widget.blog.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: isMobile ? 18 : 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Description
                        Text(
                          widget.blog.description,
                          maxLines: isMobile ? 2 : 3, // Constrain lines to prevent overflow
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Colors.white.withOpacity(0.4),
                          ),
                        ),
                        
                        const SizedBox(height: 24),

                        // Author Footer
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white12,
                              child: Icon(Icons.person, size: 18, color: Colors.white.withOpacity(0.5)),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                widget.blog.authorName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ),
                            Text(
                              dateStr,
                              style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 12),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 20),

                        // --- READ MORE BUTTON (Inside Card) ---
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: isHovered ? Colors.white : Colors.transparent,
                            border: Border.all(
                              color: isHovered ? Colors.white : Colors.white.withOpacity(0.15),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Read More",
                              style: TextStyle(
                                color: isHovered ? Colors.black : Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w900,
          color: Colors.black,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}