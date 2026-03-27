import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';

class BlogCard extends StatefulWidget {
  final VoidCallback onTap;
  final String title;
  final String category;
  final String? description;
  final double? customHeight;

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
          // If customHeight is null, it will expand to fit content safely
          height: widget.customHeight,
          clipBehavior: Clip.antiAlias, // Ensures internal children don't bleed out
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
              Flexible(
                flex: isMobile ? 4 : 5,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Container(
                    width: double.infinity,
                    color: Colors.black,
                    child: Center(
                      child: Icon(Icons.auto_awesome, 
                        color: AppTheme.primaryGreen, 
                        size: Responsive.scaleText(context, 32)
                      ),
                    ),
                  ),
                ),
              ),

              /// CONTENT SECTION
              Flexible(
                flex: 6,
                child: Padding(
                  padding: EdgeInsets.all(isMobile ? 16 : 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.category.toUpperCase(),
                        style: TextStyle(
                          color: AppTheme.primaryGreen,
                          fontSize: Responsive.scaleText(context, 10),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Responsive.scaleText(context, isMobile ? 16 : 19),
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Flexible wrapper prevents description from pushing off the edge
                      Flexible(
                        child: Text(
                          widget.description ?? "Explore the new era of software engineering powered by GenAI.",
                          maxLines: isMobile ? 2 : 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: Responsive.scaleText(context, 13),
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}