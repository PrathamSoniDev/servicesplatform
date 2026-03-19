import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';

class BlogCard extends StatefulWidget {
  final VoidCallback onTap;
  final String title;
  final String category;
  final String? description;
  final double? customHeight; // Changed to double? to match Flutter standards

  const BlogCard({
    super.key,
    required this.onTap,
    required this.title,
    required this.category,
    this.description,
    this.customHeight,
  });

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) { if (!isMobile) setState(() => _isHovered = true); },
      onExit: (_) { if (!isMobile) setState(() => _isHovered = false); },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: widget.customHeight,
          transform: Matrix4.identity()..scale(_isHovered && !isMobile ? 1.02 : 1),
          decoration: BoxDecoration(
            color: const Color(0xFF111111), 
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered ? AppTheme.primaryGreen : Colors.white.withOpacity(0.05),
              width: 1.5,
            ),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: AppTheme.primaryGreen.withOpacity(0.2),
                  blurRadius: 25,
                  spreadRadius: 2,
                )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              /// IMAGE SECTION
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Container(
                  height: isMobile ? 130 : 180,
                  width: double.infinity,
                  color: Colors.black,
                  child: Center(
                    child: Icon(Icons.auto_awesome, color: AppTheme.primaryGreen, size: 32),
                  ),
                ),
              ),

              /// CONTENT SECTION
              Padding(
                padding: EdgeInsets.all(isMobile ? 18 : 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.category.toUpperCase(),
                      style: const TextStyle(
                        color: AppTheme.primaryGreen,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isMobile ? 17 : 20,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.description ?? "Explore the new era of software engineering powered by GenAI.",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}