import 'package:flutter/material.dart';

class BlogCard extends StatefulWidget {
  const BlogCard({super.key});

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..scale(_isHovered ? 1.03 : 1.0),
        decoration: BoxDecoration(
          // Dark Gradient for the "Sparkling" look
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A1A), // Off Black
              _isHovered ? const Color(0xFF0D0D0D) : const Color(0xFF121212),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered 
                ? const Color(0xFF00FFA3).withOpacity(0.5) 
                : Colors.white.withOpacity(0.05),
            width: 1,
          ),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: const Color(0xFF00FFA3).withOpacity(0.15),
                blurRadius: 40,
                offset: const Offset(0, 20),
              )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE AREA WITH OVERLAY
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: Container(
                height: 200,
                color: Colors.black,
                child: Stack(
                  children: [
                    // Placeholder for image
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    const Center(
                      child: Icon(Icons.auto_awesome, color: Color(0xFF00FFA3), size: 40),
                    ),
                  ],
                ),
              ),
            ),

            /// CONTENT
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "AI DEVELOPMENT",
                    style: TextStyle(
                      color: const Color(0xFF00FFA3),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "How AI is Transforming Development",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Explore the new era of software engineering powered by GenAI.",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 15,
                      height: 1.5,
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