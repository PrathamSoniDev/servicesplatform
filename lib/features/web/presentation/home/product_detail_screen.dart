import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/features/web/presentation/seo/seo_widget.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';
import 'package:servicesplatform/models/service_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final bool isDeveloper;
  final ServiceModel service;

  const ProductDetailScreen({
    super.key,
    required this.isDeveloper,
    required this.service,
  });

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

    return SeoWrapper(
      child: Scaffold(
        backgroundColor: AppTheme.darkBackground,

        /// ✅ APP BAR WITH SEO
        appBar: AppBar(
          backgroundColor: AppTheme.darkBackground,
          elevation: 0,
          centerTitle: false,
          leading: IconButton(
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
              size: 20,
            ),
          ),
          title: SeoHeader(
            child: SeoHeading(
              service.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Responsive.scaleText(context, 18),
                color: Colors.white,
              ),
            ),
          ),
        ),

        /// ✅ BODY SEO
        body: SeoBody(
          child: Stack(
            children: [
              /// BACKGROUND GLOWS
              Positioned(
                top: -200,
                left: -180,
                child: _buildGlow(
                  color: AppTheme.primaryGreen,
                  size: 420,
                  opacity: .08,
                ),
              ),

              Positioned(
                bottom: -260,
                right: -220,
                child: _buildGlow(color: Colors.blue, size: 520, opacity: .05),
              ),

              /// MAIN CONTENT
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  /// HERO SECTION
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 24 : 80,
                        vertical: isMobile ? 40 : 80,
                      ),
                      child:
                          isMobile
                              ? Column(
                                children: [
                                  _heroLeft(context),
                                  const SizedBox(height: 40),
                                  _heroRight(),
                                ],
                              )
                              : Row(
                                children: [
                                  Expanded(child: _heroLeft(context)),
                                  const SizedBox(width: 60),
                                  Expanded(child: _heroRight()),
                                ],
                              ),
                    ),
                  ),

                  /// FULL DESCRIPTION
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: Responsive.screenPadding(context),
                      child: Container(
                        padding: const EdgeInsets.all(34),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(34),
                          color: Colors.white.withValues(alpha: .04),
                          border: Border.all(color: Colors.white12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SeoHeading(
                              "Solution Overview",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isMobile ? 28 : 40,
                                fontWeight: FontWeight.w900,
                              ),
                            ),

                            const SizedBox(height: 24),

                            SeoText(
                              service.fullDescription,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: .72),
                                fontSize: isMobile ? 14 : 17,
                                height: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// FEATURES
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: isMobile ? 60 : 90),
                      child: _sectionTitle(
                        context,
                        "Core Features",
                        "Built with enterprise-grade capabilities and scalable architecture.",
                      ),
                    ),
                  ),

                  SliverPadding(
                    padding: Responsive.screenPadding(context),
                    sliver: SliverToBoxAdapter(
                      child: Wrap(
                        spacing: 24,
                        runSpacing: 24,
                        children:
                            service.features.map((feature) {
                              return _featureCard(context, feature);
                            }).toList(),
                      ),
                    ),
                  ),

                  /// TECHNOLOGIES
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: isMobile ? 70 : 100),
                      child: _sectionTitle(
                        context,
                        "Technology Stack",
                        "Modern technologies engineered for performance, scalability, and security.",
                      ),
                    ),
                  ),

                  SliverPadding(
                    padding: Responsive.screenPadding(context),
                    sliver: SliverToBoxAdapter(
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children:
                            service.technologies.map((tech) {
                              return _techCard(tech);
                            }).toList(),
                      ),
                    ),
                  ),

                  /// BENEFITS SECTION
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: isMobile ? 70 : 100),
                      child: _sectionTitle(
                        context,
                        "Why Choose This Solution",
                        "Optimized for modern businesses, startups, and enterprise scalability.",
                      ),
                    ),
                  ),

                  SliverPadding(
                    padding: Responsive.screenPadding(context),
                    sliver: SliverToBoxAdapter(
                      child: Wrap(
                        spacing: 24,
                        runSpacing: 24,
                        children: [
                          _benefitCard(
                            "Enterprise Security",
                            Icons.security_rounded,
                          ),

                          _benefitCard(
                            "Scalable Infrastructure",
                            Icons.auto_graph_rounded,
                          ),

                          _benefitCard(
                            "Performance Optimized",
                            Icons.speed_rounded,
                          ),

                          _benefitCard("Cloud Ready", Icons.cloud_rounded),
                        ],
                      ),
                    ),
                  ),

                  /// CTA SECTION
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(isMobile ? 24 : 80),
                      child: Container(
                        padding: EdgeInsets.all(isMobile ? 30 : 50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          gradient: LinearGradient(
                            colors: [
                              AppTheme.primaryGreen.withValues(alpha: .18),
                              Colors.white.withValues(alpha: .03),
                            ],
                          ),
                          border: Border.all(color: Colors.white12),
                        ),
                        child: Column(
                          children: [
                            SeoHeading(
                              "Ready To Build Your Next Digital Product?",
                              align: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isMobile ? 30 : 52,
                                fontWeight: FontWeight.w900,
                                height: 1.1,
                              ),
                            ),

                            const SizedBox(height: 24),

                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 700),
                              child: SeoText(
                                "Partner with Sell Tech Ind. Productions to build scalable, secure, and enterprise-grade digital solutions engineered for long-term growth.",
                                align: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: .70),
                                  fontSize: isMobile ? 14 : 17,
                                  height: 1.9,
                                ),
                              ),
                            ),

                            const SizedBox(height: 40),

                            Wrap(
                              spacing: 20,
                              runSpacing: 20,
                              alignment: WrapAlignment.center,
                              children: [
                                _primaryButton("Start Project"),

                                _secondaryButton("Book Consultation"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _heroLeft(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppTheme.primaryGreen.withValues(alpha: .08),
            border: Border.all(
              color: AppTheme.primaryGreen.withValues(alpha: .15),
            ),
          ),
          child: SeoText(
            service.category.toUpperCase(),
            style: TextStyle(
              color: AppTheme.primaryGreen,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.6,
              fontSize: 11,
            ),
          ),
        ),

        const SizedBox(height: 30),

        SeoHeading(
          service.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: Responsive.isMobile(context) ? 44 : 78,
            fontWeight: FontWeight.w900,
            height: .95,
            letterSpacing: -3,
          ),
        ),

        const SizedBox(height: 30),

        SeoText(
          service.description,
          style: TextStyle(
            color: Colors.white.withValues(alpha: .68),
            fontSize: Responsive.isMobile(context) ? 15 : 18,
            height: 1.9,
          ),
        ),

        const SizedBox(height: 40),

        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _statCard(service.deliveryTime, "Delivery"),

            _statCard(service.scalability, "Scalability"),

            _statCard("24/7", "Support"),
          ],
        ),

        const SizedBox(height: 50),

        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            _primaryButton("Start Project"),

            _secondaryButton("Book Consultation"),
          ],
        ),
      ],
    );
  }

  Widget _heroRight() {
    return Container(
      height: 620,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryGreen.withValues(alpha: .16),
            Colors.white.withValues(alpha: .03),
          ],
        ),
        border: Border.all(color: Colors.white12),
      ),
      child: Center(
        child: Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                AppTheme.primaryGreen,
                AppTheme.primaryGreen.withValues(alpha: .65),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryGreen.withValues(alpha: .25),
                blurRadius: 40,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Icon(service.icon, size: 80, color: Colors.black),
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title, String subtitle) {
    final isMobile = Responsive.isMobile(context);

    return Padding(
      padding: Responsive.screenPadding(context),
      child: Column(
        children: [
          SeoHeading(
            title,
            align: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 34 : 54,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 18),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: SeoText(
              subtitle,
              align: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: .65),
                fontSize: isMobile ? 14 : 17,
                height: 1.8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureCard(BuildContext context, String feature) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: isMobile ? double.infinity : 320,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white.withValues(alpha: .04),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.primaryGreen.withValues(alpha: .12),
            ),
            child: Icon(Icons.check_rounded, color: AppTheme.primaryGreen),
          ),

          const SizedBox(height: 24),

          SeoText(
            feature,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 20,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _benefitCard(String title, IconData icon) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white.withValues(alpha: .04),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.primaryGreen, size: 40),

          const SizedBox(height: 24),

          SeoText(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _primaryButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: AppTheme.primaryGreen,
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _secondaryButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _statCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withValues(alpha: .04),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: AppTheme.primaryGreen,
              fontWeight: FontWeight.w900,
              fontSize: 22,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            label,
            style: TextStyle(color: Colors.white.withValues(alpha: .60)),
          ),
        ],
      ),
    );
  }

  Widget _buildGlow({
    required Color color,
    required double size,
    required double opacity,
  }) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withValues(alpha: opacity),
              color.withValues(alpha: 0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _techCard(String tech) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white.withValues(alpha: .04),
        border: Border.all(color: Colors.white12),
      ),
      child: SeoText(
        tech,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
