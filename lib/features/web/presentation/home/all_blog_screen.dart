import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/features/web/presentation/seo/seo_widget.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/widgets/blog_card.dart';

class AllBlogsScreen extends StatelessWidget {
  const AllBlogsScreen({super.key});

  void openBlog(BuildContext context, String title, String category) {
    final slug = title.toLowerCase().replaceAll(' ', '-');
    context.push(
      '/blog/detail/$slug?category=${Uri.encodeComponent(category)}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final padding = Responsive.pagePadding(context);

    return SeoWrapper(                                         // ✅ FULL PAGE SEO WRAP
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
                      onPressed: () async {
                        final bool didPop =
                            await Navigator.of(context).maybePop();
                        if (!didPop && context.mounted) {
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
            child: SeoHeading("Insights & News"),
          ),
        ),

        body: SeoBody(                                         // ✅ BODY SEO WRAP
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 60, horizontal: padding),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// TITLE
                    SeoHeading(                                // ✅ SEO HEADING
                      "Our Blog",
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: 56,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -2,
                            color: Colors.white,
                          ),
                    ),

                    const SizedBox(height: 12),

                    /// SUBTITLE
                    SeoText(                                   // ✅ SEO TEXT
                      "Deep dives into engineering, AI, and business growth.",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppTheme.textWhite70,
                            fontSize: 18,
                            height: 1.5,
                          ),
                    ),

                    const SizedBox(height: 60),

                    /// BLOG GRID
                    Wrap(
                      spacing: 30,
                      runSpacing: 40,
                      alignment: isMobile
                          ? WrapAlignment.center
                          : WrapAlignment.start,
                      children: [
                        _buildGridItem(context, "The Future of GenAI in Coding", "TECHNOLOGY"),
                        _buildGridItem(context, "How to Scale Engineering Teams", "BUSINESS"),
                        _buildGridItem(context, "Security Protocols for 2026", "SECURITY"),
                        _buildGridItem(context, "The Rise of No-Code Architecture", "TRENDS"),
                      ],
                    ),

                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, String title, String category) {
    final isMobile = Responsive.isMobile(context);

    return SeoLink(                                            // ✅ SEO LINK WRAP
      url: '/blog/detail/${title.toLowerCase().replaceAll(' ', '-')}?category=${Uri.encodeComponent(category)}',
      text: title,
      child: SizedBox(
        width: isMobile ? double.infinity : 360,
        height: 420,
        child: BlogCard(
          title: title,
          category: category,
          onTap: () => openBlog(context, title, category),
          customHeight: 420,
        ),
      ),
    );
  }
}