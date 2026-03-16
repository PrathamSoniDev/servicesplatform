import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';
import 'package:servicesplatform/features/web/widgets/blog_card.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final padding = Responsive.pagePadding(context);
    final isMobile = Responsive.isMobile(context);

    return SizedBox(
      height: MediaQuery.of(context).size.height,

      child: Container(
        width: double.infinity,
        color: const Color(0xFFF7F7F7),

        padding: EdgeInsets.symmetric(
          horizontal: padding,
          vertical: isMobile ? 40 : 80,
        ),

        child: Column(
          children: [

            /// HEADER
            _buildHeader(context),

            SizedBox(height: isMobile ? 30 : 50),

            /// BLOG CARDS
            Expanded(
              child: isMobile
                  ? _buildMobileScroll()
                  : _buildDesktopGrid(),
            ),

            const SizedBox(height: 20),

            /// VIEW MORE BUTTON
            _viewMoreButton(),
          ],
        ),
      ),
    );
  }

  /// HEADER
  Widget _buildHeader(BuildContext context) {

    return Column(
      children: [

        Text(
          "Insights & Innovations",
          style: TextStyle(
            color: Colors.green.shade700,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          "Latest from our Blog",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  /// DESKTOP GRID
  Widget _buildDesktopGrid() {

    return Center(
      child: Wrap(
        spacing: 30,
        runSpacing: 30,
        alignment: WrapAlignment.center,

        children: List.generate(3, (index) {

          return const SizedBox(
            width: 360,
            child: BlogCard(),
          );
        }),
      ),
    );
  }

  /// MOBILE HORIZONTAL SCROLL
  Widget _buildMobileScroll() {

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,

      itemBuilder: (context, index) {

        return Padding(
          padding: const EdgeInsets.only(right: 16),

          child: SizedBox(
            width: 280,
            child: const BlogCard(),
          ),
        );
      },
    );
  }

  /// VIEW MORE BUTTON
  Widget _viewMoreButton() {

    return TextButton(
      onPressed: () {},

      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          const Text(
            "View More Articles",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(width: 8),

          Icon(
            Icons.arrow_forward_rounded,
            color: Colors.green.shade600,
            size: 24,
          ),
        ],
      ),
    );
  }
}