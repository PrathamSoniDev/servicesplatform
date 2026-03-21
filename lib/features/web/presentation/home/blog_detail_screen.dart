import 'dart:ui';
import 'package:flutter/material.dart';
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
    final size = MediaQuery.of(context).size;
    final isMobile = Responsive.isMobile(context);

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
                color: AppTheme.darkBackground.withOpacity(0.5),
              ),
            ),
          ),

          /// MAIN PANEL
          Center(
            child: Container(
              width: isMobile ? size.width * 0.95 : 1100,
              height: isMobile ? size.height * 0.9 : 850,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppTheme.bgOffWhite,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                  )
                ],
              ),
              child: Stack(
                children: [

                  /// CONTENT
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        /// HERO IMAGE
                        Container(
                          width: double.infinity,
                          height: isMobile ? 300 : 500,
                          color: AppTheme.borderLight.withOpacity(0.5),
                          child: Hero(
                            tag: title,
                            child: Icon(
                              Icons.article_outlined,
                              size: isMobile ? 80 : 120,
                              color: AppTheme.primaryGreen.withOpacity(0.5),
                            ),
                          ),
                        ),

                        /// BODY
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 24 : 100,
                            vertical: 60,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              /// CATEGORY
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryGreen.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  category.toUpperCase(),
                                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                        color: AppTheme.primaryGreen,
                                      ),
                                ),
                              ),

                              const SizedBox(height: 24),

                              /// TITLE
                              Text(
                                title,
                                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                      color: AppTheme.textBlack,
                                      fontSize: isMobile ? 32 : 48,
                                      height: 1.1,
                                    ),
                              ),

                              const SizedBox(height: 24),

                              /// AUTHOR
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: AppTheme.borderLight,
                                    child: Icon(
                                      Icons.person,
                                      size: 20,
                                      color: AppTheme.textGrey,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "By Editorial Team",
                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: AppTheme.textBlack,
                                            ),
                                      ),
                                      Text(
                                        "March 19, 2026 • 5 min read",
                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                              fontSize: 12,
                                              color: AppTheme.textGrey,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height: 48),

                              /// CONTENT TEXT
                              Text(
                                "The landscape of software development is shifting beneath our feet. As AI becomes an integral part of the IDE, the role of a developer is moving from 'writer' to 'architect'.\n\n"
                                "In this deep dive, we explore how GenAI tools are not just completing lines of code, but are actually helping engineers conceptualize complex system architectures faster than ever before.",
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: AppTheme.textGrey.withOpacity(0.9),
                                      fontFamily: 'Georgia',
                                    ),
                              ),

                              const SizedBox(height: 40),

                              /// INFOGRAPHIC
                              Container(
                                height: 400,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.03),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: AppTheme.borderLight),
                                ),
                                child: Icon(
                                  Icons.auto_graph_rounded,
                                  size: 80,
                                  color: AppTheme.textGrey.withOpacity(0.2),
                                ),
                              ),

                              const SizedBox(height: 40),

                              Text(
                                "This transition requires a new set of skills. It's no longer just about knowing the syntax of a language; it's about knowing how to prompt, how to audit AI-generated code, and how to maintain security standards in an automated world.",
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: AppTheme.textGrey.withOpacity(0.9),
                                      fontFamily: 'Georgia',
                                    ),
                              ),

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
                            AppTheme.bgOffWhite.withOpacity(0),
                            AppTheme.bgOffWhite.withOpacity(0.9),
                          ],
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            color: Colors.black.withOpacity(0.05),
                            child: Row(
                              children: [
                                if (!isMobile)
                                  Text(
                                    "Did you find this insightful?",
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.textBlack,
                                        ),
                                  ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.ios_share,
                                    size: 20,
                                    color: AppTheme.textBlack,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.darkBackground,
                                    foregroundColor: AppTheme.bgOffWhite,
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    "JOIN NEWSLETTER",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
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
                      child: CircleAvatar(
                        backgroundColor: AppTheme.borderLight,
                        child: Icon(
                          Icons.close,
                          color: AppTheme.textBlack,
                          size: 18,
                        ),
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
}