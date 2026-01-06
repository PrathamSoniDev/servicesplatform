import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';
import 'package:servicesplatform/models/blog_model.dart';

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
    final bool isMobile = Responsive.isMobile(context);
    // final bool isTablet = Responsive.isTablet(context);

    final dateStr =
        DateFormat("dd MMM, yyyy").format(widget.blog.createdAt).toLowerCase();

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform:
            isHovered
                ? (Matrix4.identity()..translate(0, -10, 0))
                : Matrix4.identity(),
        decoration: BoxDecoration(
          color: const Color(0xFF0D0D0D),
          borderRadius: BorderRadius.circular(isMobile ? 20 : 28),
          border: Border.all(
            color:
                isHovered
                    ? Colors.white.withValues(alpha: .2)
                    : Colors.white.withValues(alpha: .08),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isHovered ? 0.5 : 0.2),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(isMobile ? 20 : 28),
          child: InkWell(
            onTap: widget.onTap,
            child: LayoutBuilder(
              // 🛠️ LayoutBuilder prevents overflow by knowing constraints
              builder: (context, constraints) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- IMAGE SECTION ---
                    AspectRatio(
                      aspectRatio: isMobile ? 16 / 10 : 16 / 9,
                      child: Hero(
                        tag: 'blog_image_${widget.blog.id}',
                        child: Image.network(
                          widget.blog.placeholderImage ?? "",
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) => Container(
                                color: Colors.white10,
                                child: const Icon(
                                  Icons.broken_image_outlined,
                                  color: Colors.white24,
                                ),
                              ),
                        ),
                      ),
                    ),

                    // --- CONTENT SECTION ---
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(isMobile ? 16 : 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Category & Read Time
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _CategoryChip(text: widget.blog.categoryId),
                                Text(
                                  "${widget.blog.readingTime} min read",
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: .4),
                                    fontSize: isMobile ? 10 : 11,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Title
                            Text(
                              widget.blog.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: isMobile ? 16 : 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Description - Uses flexible to avoid overflow
                            Flexible(
                              child: Text(
                                widget.blog.shortDescription,
                                maxLines: isMobile ? 2 : 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: isMobile ? 12 : 13,
                                  height: 1.4,
                                  color: Colors.white.withValues(alpha: .4),
                                ),
                              ),
                            ),

                            // Spacer pushes footer to bottom
                            const Spacer(),

                            // Footer (Author & Date)
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: isMobile ? 10 : 12,
                                  backgroundColor: const Color(
                                    0xFF8B5CF6,
                                  ).withValues(alpha: .2),
                                  child: Icon(
                                    Icons.person,
                                    size: isMobile ? 12 : 14,
                                    color: const Color(0xFF8B5CF6),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    widget.blog.author,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: isMobile ? 11 : 12,
                                    ),
                                  ),
                                ),
                                Text(
                                  dateStr,
                                  style: TextStyle(
                                    color: Colors.white24,
                                    fontSize: isMobile ? 10 : 11,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            // Read More Button
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                vertical: isMobile ? 8 : 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    isHovered
                                        ? Colors.white
                                        : Colors.white.withValues(alpha: .05),
                                border: Border.all(
                                  color:
                                      isHovered ? Colors.white : Colors.white12,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Read More",
                                  style: TextStyle(
                                    color:
                                        isHovered ? Colors.black : Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: isMobile ? 12 : 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFF8B5CF6), // Primary Brand Color
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
