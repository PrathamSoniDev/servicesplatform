import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/presentation/designs/design_overlay_screen.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';

class DesignCard extends StatelessWidget {
  const DesignCard({super.key});

  void _showDetail(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Design Detail',
      barrierColor: Colors.black.withOpacity(0.5), // The dimming behind the blur
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, anim1, anim2) {
        return const DesignDetailOverlay();
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.1),
              end: Offset.zero,
            ).animate(anim1),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: () => _showDetail(context),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: NetworkImage('https://picsum.photos/600/500'),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppTheme.primary, AppTheme.secondary],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Design",
                          style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Mobile App Design Best Practices",
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Explore our most popular designs crafted with precision and creativity.",
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white54),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            const Row(
              children: [
                Icon(Icons.favorite_border, color: AppTheme.primary, size: 16),
                SizedBox(width: 4),
                Text("Like", style: TextStyle(color: Colors.white38, fontSize: 11)),
                SizedBox(width: 12),
                Icon(Icons.visibility_outlined, color: Colors.white38, size: 16),
                SizedBox(width: 4),
                Text("1000 Views", style: TextStyle(color: Colors.white38, fontSize: 11)),
                Spacer(),
                Icon(Icons.share_outlined, color: Colors.white38, size: 16),
                SizedBox(width: 4),
                Text("Share", style: TextStyle(color: Colors.white38, fontSize: 11)),
              ],
            )
          ],
        ),
      ),
    );
  }
}