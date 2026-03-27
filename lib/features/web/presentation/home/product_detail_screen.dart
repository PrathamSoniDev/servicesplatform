import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';

class ProductDetailScreen extends StatelessWidget {
  final bool isDeveloper;

  const ProductDetailScreen({super.key, required this.isDeveloper});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final random = Random();

    final productIcons = [
      isDeveloper ? Icons.terminal_rounded : Icons.rocket_launch_rounded,
      Icons.analytics_outlined,
      Icons.security_rounded,
      Icons.speed_rounded,
      Icons.auto_awesome_mosaic_rounded,
    ];

    return Scaffold(
      backgroundColor: AppTheme.darkBackground,

      /// ✅ IMPROVED APP BAR
      appBar: AppBar(
        backgroundColor: AppTheme.darkBackground,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            // ✅ Fix: If there's a history, go back. Otherwise, go to Home.
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/'); 
            }
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
        ),
        title: Text(
          isDeveloper ? "Developer Platform" : "Business Platform",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Responsive.scaleText(context, 18),
            color: Colors.white,
          ),
        ),
      ),

      /// ✅ BODY
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: Responsive.maxContentWidth(context),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// 🔥 HERO IMAGE STACK
                ...productIcons.map((icon) {
                  bool isFirst = icon == productIcons.first;

                  return Container(
                    width: double.infinity,
                    height: isMobile ? 300 : 500,
                    margin: const EdgeInsets.only(bottom: 4),
                    color: AppTheme.darkCard,
                    child: Hero(
                      tag: isFirst
                          ? (isDeveloper ? 'dev_prod' : 'biz_prod')
                          : 'gallery_${icon.hashCode}_${random.nextInt(100)}',
                      child: Icon(
                        icon,
                        size: isMobile ? 100 : 180,
                        color: isFirst
                            ? AppTheme.primaryGreen
                            : AppTheme.white10,
                      ),
                    ),
                  );
                }),

                /// CONTENT SECTION
                Padding(
                  padding: Responsive.screenPadding(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// LABEL
                      Text(
                        "DEEP DIVE & SPECS",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: AppTheme.primaryGreen,
                              letterSpacing: 4,
                              fontSize: Responsive.scaleText(context, 12),
                              fontWeight: FontWeight.bold,
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
                              fontSize: isMobile ? 32 : Responsive.scaleText(context, 54),
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
                              fontSize: isMobile ? 14 : Responsive.scaleText(context, 18),
                              height: 1.8,
                              fontWeight: FontWeight.w300,
                            ),
                      ),

                      const SizedBox(height: 80),

                      /// FEATURES
                      _buildFeature(
                        context,
                        "Next-Gen AI Integration",
                        "Context-aware assistance built into every module.",
                      ),
                      _buildFeature(
                        context,
                        "Zero-Trust Architecture",
                        "Security that scales with your global team.",
                      ),
                      _buildFeature(
                        context,
                        "Modular Design System",
                        "Swap and adapt UI components in real-time.",
                      ),

                      const SizedBox(height: 100),

                      /// CTA BUTTON
                      Center(
                        child: SizedBox(
                          width: isMobile ? double.infinity : 300,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryGreen,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              "CONFIGURE NOW",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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
              const Icon(Icons.circle, color: AppTheme.primaryGreen, size: 8),
              const SizedBox(width: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontSize: Responsive.scaleText(context, 22),
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
                    fontSize: Responsive.scaleText(context, 16),
                    height: 1.5,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}