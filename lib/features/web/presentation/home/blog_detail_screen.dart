import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/features/web/presentation/seo/seo_widget.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';

class BlogDetailScreen extends StatelessWidget {
  final String title;
  final String category;

  const BlogDetailScreen({
    super.key,
    required this.title,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return SeoWrapper( // ✅ FULL PAGE SEO WRAP
      child: Scaffold(
        backgroundColor: AppTheme.darkBackground,

        appBar: AppBar(
          backgroundColor: AppTheme.darkBackground,
          elevation: 0,
          centerTitle: false,
          leadingWidth: 80,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go('/');
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// ✅ SEO HEADER
          title: const SeoHeader(
            child: SeoHeading("Insights"),
          ),
        ),

        body: SeoBody( // ✅ BODY SEO
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: Responsive.maxContentWidth(context),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// HERO
                    Hero(
                      tag: title,
                      child: Container(
                        width: double.infinity,
                        height: isMobile ? 350 : 550,
                        decoration: BoxDecoration(
                          color: AppTheme.darkCard,
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.white.withOpacity(0.05),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.auto_awesome_mosaic_rounded,
                            size: isMobile ? 100 : 160,
                            color: AppTheme.primaryGreen.withOpacity(0.4),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: Responsive.screenPadding(context),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          /// CATEGORY
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryGreen.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: SeoText( // ✅ SEO TEXT
                              category.toUpperCase(),
                              style: TextStyle(
                                color: AppTheme.primaryGreen,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                                fontSize: Responsive.scaleText(context, 12),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          /// TITLE
                          SeoHeading(
                            title,
                            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                  color: Colors.white,
                                  fontSize: isMobile ? 32 : Responsive.scaleText(context, 54),
                                  fontWeight: FontWeight.w900,
                                  height: 1.1,
                                  letterSpacing: -1.5,
                                ),
                          ),

                          const SizedBox(height: 32),

                          /// AUTHOR
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white.withOpacity(0.1),
                                child: const Icon(
                                  Icons.person_outline_rounded,
                                  color: AppTheme.primaryGreen,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SeoText(
                                    "By Editorial Team",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SeoText(
                                    "March 19, 2026 • 5 min read",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.5),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 48),

                          /// CONTENT
                          const SeoText(
                            "The landscape of software development is shifting beneath our feet...\n\n"
                            "In this deep dive, we explore how GenAI tools...",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                              height: 1.8,
                              fontFamily: 'Georgia',
                            ),
                          ),

                          const SizedBox(height: 40),

                          /// IMAGE BLOCK
                          Container(
                            height: isMobile ? 300 : 450,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppTheme.darkCard,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: Colors.white.withOpacity(0.05)),
                            ),
                            child: Icon(
                              Icons.auto_graph_rounded,
                              size: 80,
                              color: AppTheme.primaryGreen.withOpacity(0.2),
                            ),
                          ),

                          const SizedBox(height: 40),

                          const SeoText(
                            "This transition requires a new set of skills...",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                              height: 1.8,
                              fontFamily: 'Georgia',
                            ),
                          ),

                          const SizedBox(height: 100),

                          /// CTA
                          Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 500),
                              child: Container(
                                padding: const EdgeInsets.all(40),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryGreen.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(color: AppTheme.primaryGreen.withOpacity(0.1)),
                                ),
                                child: Column(
                                  children: [
                                    const SeoHeading(
                                      "Stay ahead of the curve",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    SeoText(
                                      "Weekly insights on AI, Cloud, and Flutter development delivered to your inbox.",
                                      style: TextStyle(color: Colors.white.withOpacity(0.6)),
                                      align: TextAlign.center,
                                    ),
                                    const SizedBox(height: 32),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppTheme.primaryGreen,
                                        foregroundColor: Colors.black,
                                        minimumSize: const Size(double.infinity, 60),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: const Text(
                                        "SUBSCRIBE NOW",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 120),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}