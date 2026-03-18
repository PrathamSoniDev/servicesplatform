import 'dart:ui';
import 'dart:math'; // 1. ADDED THIS IMPORT
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final bool isDeveloper;

  const ProductDetailScreen({super.key, required this.isDeveloper});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;
    const accentGreen = Color(0xFF27AE60);
    const darkCard = Color(0xFF1A1A1A);
    final random = Random(); // 2. INITIALIZED RANDOM HERE

    // Mock list of icons representing different showcase images/sections
    final productIcons = [
      isDeveloper ? Icons.terminal_rounded : Icons.rocket_launch_rounded,
      Icons.analytics_outlined,
      Icons.security_rounded,
      Icons.speed_rounded,
      Icons.auto_awesome_mosaic_rounded,
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // --- BLUR OVERLAY ---
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(color: Colors.black.withOpacity(0.7)),
            ),
          ),

          // --- MAIN SCROLLABLE PANEL ---
          Center(
            child: Container(
              width: isMobile ? size.width * 0.95 : 1100,
              height: isMobile ? size.height * 0.9 : 800,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: const Color(0xFF0D0D0D),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white10),
              ),
              child: Stack(
                children: [
                  // THE SCROLLABLE CONTENT (Case Study Style)
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // IMAGE GALLERY STACK
                        // Replicates the scrolling through multiple designs/images
                        ...productIcons.map((icon) {
                          bool isFirst = icon == productIcons.first;
                          return Container(
                            width: double.infinity,
                            height: 600,
                            margin: const EdgeInsets.only(bottom: 4),
                            color: darkCard,
                            child: Hero(
                              // Hero only on the first image to prevent tag conflicts
                              tag: isFirst ? (isDeveloper ? 'dev_prod' : 'biz_prod') : 'gallery_${random.nextInt(100000)}',
                              child: Icon(
                                icon, 
                                size: 180, 
                                color: isFirst ? accentGreen : Colors.white10
                              ),
                            ),
                          );
                        }),

                        // CONTENT SECTION
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 24 : 80,
                            vertical: 80,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "DEEP DIVE & SPECS",
                                style: TextStyle(
                                  color: accentGreen, 
                                  letterSpacing: 4, 
                                  fontSize: 12, 
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                isDeveloper ? "Developer Hub Pro" : "Enterprise Business Suite",
                                style: const TextStyle(
                                  color: Colors.white, 
                                  fontSize: 54, 
                                  fontWeight: FontWeight.w900, 
                                  letterSpacing: -2
                                ),
                              ),
                              const SizedBox(height: 32),
                              const Text(
                                "This project represents a paradigm shift in how users interact with digital ecosystems. "
                                "By leveraging low-latency architecture and high-fidelity motion design, we've created "
                                "a workspace that isn't just a tool—it's an extension of the professional's mind.",
                                style: TextStyle(
                                  color: Colors.white60, 
                                  fontSize: 18, 
                                  height: 1.8,
                                  fontWeight: FontWeight.w300
                                ),
                              ),
                              const SizedBox(height: 80),
                              
                              // Features List
                              _buildFeature("Next-Gen AI Integration", "Context-aware assistance built into every module."),
                              _buildFeature("Zero-Trust Architecture", "Security that scales with your global team."),
                              _buildFeature("Modular Design System", "Swap and adapt UI components in real-time."),
                              
                              const SizedBox(height: 150), // Gap for the sticky bottom bar
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // --- STICKY BOTTOM ACTION BAR ---
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent, 
                            Colors.black.withOpacity(0.9)
                          ],
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            color: Colors.white.withOpacity(0.05),
                            child: Row(
                              children: [
                                if (!isMobile) ...[
                                  const CircleAvatar(
                                    backgroundColor: accentGreen, 
                                    radius: 18, 
                                    child: Icon(Icons.bolt, color: Colors.black, size: 20)
                                  ),
                                  const SizedBox(width: 16),
                                  const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Version 2.4", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                      Text("Available for instant setup", style: TextStyle(color: Colors.white54, fontSize: 11)),
                                    ],
                                  ),
                                  const Spacer(),
                                ],
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: accentGreen,
                                    foregroundColor: Colors.black,
                                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 22),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    "CONFIGURE NOW", 
                                    style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1)
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // --- CLOSE BUTTON ---
                  Positioned(
                    top: 24,
                    right: 24,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: Colors.black45, 
                          shape: BoxShape.circle
                        ),
                        child: const Icon(Icons.close_rounded, color: Colors.white, size: 24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeature(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.circle, color: Color(0xFF27AE60), size: 8),
              const SizedBox(width: 12),
              Text(
                title, 
                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)
              ),
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              desc, 
              style: const TextStyle(color: Colors.white54, fontSize: 16, height: 1.5)
            ),
          ),
        ],
      ),
    );
  }
}