import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';

class ProductDetailScreen extends StatelessWidget {
  final bool isDeveloper;

  const ProductDetailScreen({super.key, required this.isDeveloper});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;
    final random = Random();

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
          /// BLUR OVERLAY
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                color: Colors.black.withOpacity(0.7),
              ),
            ),
          ),

          /// MAIN PANEL
          Center(
            child: Container(
              width: isMobile ? size.width * 0.95 : 1100,
              height: isMobile ? size.height * 0.9 : 800,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppTheme.darkBackground.withOpacity(0.95),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppTheme.white10),
              ),
              child: Stack(
                children: [

                  /// SCROLL CONTENT
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        /// IMAGE STACK
                        ...productIcons.map((icon) {
                          bool isFirst = icon == productIcons.first;

                          return Container(
                            width: double.infinity,
                            height: 600,
                            margin: const EdgeInsets.only(bottom: 4),
                            color: AppTheme.darkCard,
                            child: Hero(
                              tag: isFirst
                                  ? (isDeveloper ? 'dev_prod' : 'biz_prod')
                                  : 'gallery_${random.nextInt(100000)}',
                              child: Icon(
                                icon,
                                size: 180,
                                color: isFirst
                                    ? AppTheme.primaryGreen
                                    : AppTheme.white10,
                              ),
                            ),
                          );
                        }),

                        /// CONTENT
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 24 : 80,
                            vertical: 80,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              /// LABEL
                              Text(
                                "DEEP DIVE & SPECS",
                                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: AppTheme.primaryGreen,
                                  letterSpacing: 4,
                                  fontSize: 12,
                                ),
                              ),

                              const SizedBox(height: 24),

                              /// TITLE
                              Text(
                                isDeveloper
                                    ? "Developer Hub Pro"
                                    : "Enterprise Business Suite",
                                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                  color: Colors.white,
                                  fontSize: 54,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -2,
                                ),
                              ),

                              const SizedBox(height: 32),

                              /// DESCRIPTION
                              Text(
                                "This project represents a paradigm shift in how users interact with digital ecosystems. "
                                "By leveraging low-latency architecture and high-fidelity motion design, we've created "
                                "a workspace that isn't just a tool—it's an extension of the professional's mind.",
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppTheme.textWhite60,
                                  fontSize: 18,
                                  height: 1.8,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),

                              const SizedBox(height: 80),

                              /// FEATURES
                              _buildFeature(context, "Next-Gen AI Integration",
                                  "Context-aware assistance built into every module."),
                              _buildFeature(context, "Zero-Trust Architecture",
                                  "Security that scales with your global team."),
                              _buildFeature(context, "Modular Design System",
                                  "Swap and adapt UI components in real-time."),

                              const SizedBox(height: 150),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// BOTTOM BAR
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
                            Colors.black.withOpacity(0.9),
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
                                  CircleAvatar(
                                    backgroundColor: AppTheme.primaryGreen,
                                    radius: 18,
                                    child: const Icon(Icons.bolt,
                                        color: Colors.black, size: 20),
                                  ),
                                  const SizedBox(width: 16),
                                  const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Version 2.4",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                      Text("Available for instant setup",
                                          style: TextStyle(
                                              color: Colors.white54,
                                              fontSize: 11)),
                                    ],
                                  ),
                                  const Spacer(),
                                ],
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.primaryGreen,
                                    foregroundColor: Colors.black,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 22),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12)),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    "CONFIGURE NOW",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// CLOSE BUTTON
                  Positioned(
                    top: 24,
                    right: 24,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: Colors.black45,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close_rounded,
                            color: Colors.white, size: 24),
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

  Widget _buildFeature(BuildContext context, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.circle,
                  color: AppTheme.primaryGreen, size: 8),
              const SizedBox(width: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              desc,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.textWhite54,
                    fontSize: 16,
                    height: 1.5,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}