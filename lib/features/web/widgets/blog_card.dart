import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';

class BlogCard extends StatefulWidget {
  const BlogCard({super.key});

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return MouseRegion(
      onEnter: (_) {
        if (!isMobile) setState(() => _isHovered = true);
      },
      onExit: (_) {
        if (!isMobile) setState(() => _isHovered = false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()
          ..scale(_isHovered && !isMobile ? 1.02 : 1),

        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF1A1A1A),
              const Color(0xFF111111),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// IMAGE
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: Container(
                height: isMobile ? 120 : 180,   // 🔥 reduced height
                color: Colors.black,
                child: const Center(
                  child: Icon(
                    Icons.auto_awesome,
                    color: Color(0xFF00FFA3),
                    size: 32,
                  ),
                ),
              ),
            ),

            /// CONTENT
            Padding(
              padding: EdgeInsets.all(isMobile ? 16 : 22), // smaller padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "AI DEVELOPMENT",
                    style: TextStyle(
                      color: const Color(0xFF00FFA3),
                      fontSize: isMobile ? 10 : 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "How AI is Transforming Development",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 16 : 19,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "Explore the new era of software engineering powered by GenAI.",
                    maxLines: 2,                 // 🔥 prevents tall cards
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: isMobile ? 12.5 : 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}