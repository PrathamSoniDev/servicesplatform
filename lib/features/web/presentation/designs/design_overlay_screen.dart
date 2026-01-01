import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';

class DesignDetailOverlay extends StatelessWidget {
  const DesignDetailOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = Responsive.isMobile(context);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Background blur
      child: Container(
        color: Colors.black.withOpacity(0.8), // Dimmed background
        child: Center(
          child: Container(
            width: Responsive.isDesktop(context) ? 1000 : double.infinity,
            margin: EdgeInsets.only(top: isMobile ? 40 : 20),
            decoration: const BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: Scaffold(
                backgroundColor: AppTheme.background,
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Header / Navigation Bar ---
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          children: [
                            TextButton.icon(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 18),
                              label: Text("Back to all designs", 
                                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70)),
                            ),
                            const Spacer(),
                            _buildActionButton(Icons.public),
                            const SizedBox(width: 12),
                            _buildActionButton(Icons.favorite_border),
                            const SizedBox(width: 12),
                            _buildActionButton(Icons.share_outlined),
                          ],
                        ),
                      ),

                      // --- Metadata Section ---
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Digital Agency Landing Page",
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w900,
                                fontSize: isMobile ? 28 : 42,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "Professional agency website with dynamic sections highlighting services, case studies, and team expertise.",
                              style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white60),
                            ),
                            const SizedBox(height: 30),
                            
                            // Info Row (Tags, Colors, Tools)
                            Wrap(
                              spacing: 40,
                              runSpacing: 20,
                              children: [
                                _buildDetailItem("Project", "Fintech Dashboard"),
                                _buildDetailItem("Category", "SaaS / Web App"),
                                _buildDetailItem("Published", "January 2026"),
                              ],
                            ),
                            const SizedBox(height: 40),
                            
                            // Call to Action
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primary,
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: const Text("View Live Design", style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 60),

                      // --- Full Length Design Image ---
                      // This represents your long scrollable design content
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1551434678-e076c223a692', // Replace with your long asset
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      
                      // Example of long content scrolling
                      Container(
                        height: 1000,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFF1E0044), Colors.black],
                          ),
                        ),
                        child: const Center(
                          child: Text("Detailed Design Content Continued..."),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title.toUpperCase(), style: const TextStyle(color: Colors.white30, fontSize: 10, letterSpacing: 1.5, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildActionButton(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white10),
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(icon, color: Colors.white70, size: 20),
      ),
    );
  }
}