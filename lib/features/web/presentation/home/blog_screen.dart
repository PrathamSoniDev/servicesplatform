import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/features/web/presentation/seo/seo_widget.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/widgets/blog_card.dart';

class BlogItem {
  final String title;
  final String category;
  BlogItem({required this.title, required this.category});
}

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late final AnimationController _entranceCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  static final List<BlogItem> featuredBlogs = [
    BlogItem(title: "How AI is Transforming Development", category: "AI Development"),
    BlogItem(title: "The Future of Cloud Computing", category: "Cloud"),
    BlogItem(title: "UI/UX Trends to Watch in 2026", category: "Design"),
    BlogItem(title: "Cybersecurity in the GenAI Era", category: "Security"),
    BlogItem(title: "Building Scalable Flutter Web Apps", category: "Flutter"),
  ];

  @override
  void initState() {
    super.initState();
    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnim = CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeOutCubic));
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _entranceCtrl.forward());
  }

  @override
  void dispose() {
    _entranceCtrl.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scroll(bool isLeft, double constraintsWidth) {
    final double scrollAmount = constraintsWidth * 0.8;
    _scrollController.animateTo(
      isLeft
          ? (_scrollController.offset - scrollAmount)
              .clamp(0, _scrollController.position.maxScrollExtent)
          : (_scrollController.offset + scrollAmount)
              .clamp(0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 480),
      curve: Curves.easeInOutCubic,
    );
  }

  void _openBlogDetail(BuildContext context, BlogItem blog) {
    final slug = blog.title.toLowerCase().replaceAll(' ', '-');
    context.go(
        '/blog/detail/$slug?category=${Uri.encodeComponent(blog.category)}');
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final screenW = MediaQuery.of(context).size.width;
    final hPadding = Responsive.pagePadding(context);

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppTheme.bgOffWhite,
      child: FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: isMobile ? 24 : 44),

              // ── HEADER ────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: hPadding),
                child: _BlogHeader(isMobile: isMobile, screenW: screenW),
              ),

              SizedBox(height: isMobile ? 24 : 36),

              // ── CARD SCROLL AREA ──────────────────────────────────
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final maxW = constraints.maxWidth;
                    final maxH = constraints.maxHeight;

                    final double cardW = isMobile
                        ? (screenW < 300 ? screenW * 0.88 : maxW * 0.78)
                        : (screenW > 1200 ? 360.0 : 320.0);

                    final double cardH = maxH.clamp(180.0, 520.0);
                    final double arrowPad = isMobile ? 10.0 : 14.0;
                    final double arrowIcon = isMobile ? 16.0 : 20.0;

                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        // Card list
                        ListView.builder(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 40 : 60,
                            vertical: 10,
                          ),
                          itemCount: featuredBlogs.length,
                          itemBuilder: (ctx, i) {
                            final blog = featuredBlogs[i];
                            final slug = blog.title
                                .toLowerCase()
                                .replaceAll(' ', '-');
                            return Padding(
                              padding: EdgeInsets.only(
                                  right: isMobile ? 16 : 24),
                              child: Center(
                                child: SizedBox(
                                  width: cardW,
                                  height: cardH - 20,
                                  child: SeoLink(
                                    url: '/blog/detail/$slug?category=${Uri.encodeComponent(blog.category)}',
                                    text: blog.title,
                                    child: BlogCard(
                                      title: blog.title,
                                      category: blog.category,
                                      onTap: () => _openBlogDetail(ctx, blog), customHeight: 400,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        // ── ARROWS ────────────────────────────────────
                        Positioned(
                          left: 8,
                          child: _ScrollArrow(
                            icon: Icons.arrow_back_ios_new_rounded,
                            onTap: () => _scroll(true, maxW),
                            padding: arrowPad,
                            iconSize: arrowIcon,
                          ),
                        ),
                        Positioned(
                          right: 8,
                          child: _ScrollArrow(
                            icon: Icons.arrow_forward_ios_rounded,
                            onTap: () => _scroll(false, maxW),
                            padding: arrowPad,
                            iconSize: arrowIcon,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              SizedBox(height: isMobile ? 20 : 32),

              // ── VIEW MORE BUTTON ──────────────────────────────────
              Center(
                child: SeoLink(
                  url: '/blog/all',
                  text: 'View All Articles',
                  child: _ViewMoreButton(
                    onTap: () {
                      final loc = GoRouterState.of(context).uri.toString();
                      if (loc != '/blog/all') context.go('/blog/all');
                    },
                    screenW: screenW,
                  ),
                ),
              ),

              SizedBox(height: isMobile ? 24 : 44),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Header ────────────────────────────────────────────────────────────────────

class _BlogHeader extends StatelessWidget {
  final bool isMobile;
  final double screenW;
  const _BlogHeader({required this.isMobile, required this.screenW});

  @override
  Widget build(BuildContext context) {
    final titleSize = screenW < 360 ? 22.0 : (isMobile ? 26.0 : 44.0);
    final labelSize = screenW < 360 ? 9.0 : 12.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: 32,
                height: 1,
                color: AppTheme.primaryGreen.withOpacity(0.3)),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: AppTheme.primaryGreen.withOpacity(0.25)),
              ),
              child: SeoText(
                "INSIGHTS & INNOVATIONS",
                style: TextStyle(
                  color: AppTheme.primaryGreen,
                  fontWeight: FontWeight.w800,
                  fontSize: labelSize,
                  letterSpacing: 1.6,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
                width: 32,
                height: 1,
                color: AppTheme.primaryGreen.withOpacity(0.3)),
          ],
        ),
        SizedBox(height: isMobile ? 12 : 18),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: SeoHeading(
            "Latest from our Blog",
            align: TextAlign.center,
            style: TextStyle(
              color: AppTheme.textBlack,
              fontSize: titleSize,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.8,
              height: 1.1,
            ),
          ),
        ),
        SizedBox(height: isMobile ? 8 : 12),
        SeoText(
          "Explore ideas, trends and deep dives from our team.",
          align: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: AppTheme.textGrey,
            fontSize: screenW < 360 ? 12.0 : (isMobile ? 13.0 : 16.0),
            height: 1.5,
          ),
        ),
        SizedBox(height: isMobile ? 10 : 14),
        Container(
          width: 44,
          height: 3,
          decoration: BoxDecoration(
            color: AppTheme.primaryGreen,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}

// ── View More Button ──────────────────────────────────────────────────────────

class _ViewMoreButton extends StatefulWidget {
  final VoidCallback onTap;
  final double screenW;
  const _ViewMoreButton({required this.onTap, required this.screenW});

  @override
  State<_ViewMoreButton> createState() => _ViewMoreButtonState();
}

class _ViewMoreButtonState extends State<_ViewMoreButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: EdgeInsets.symmetric(
            horizontal: widget.screenW < 360 ? 24 : 36,
            vertical: widget.screenW < 360 ? 12 : 16,
          ),
          decoration: BoxDecoration(
            color: _hovered ? AppTheme.primaryGreen : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovered ? AppTheme.primaryGreen : AppTheme.borderLight,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "View All Articles",
                style: TextStyle(
                  fontSize: widget.screenW < 360 ? 13 : 15,
                  fontWeight: FontWeight.w700,
                  color: _hovered ? Colors.white : AppTheme.textBlack,
                ),
              ),
              const SizedBox(width: 10),
              AnimatedSlide(
                offset: _hovered ? const Offset(0.25, 0) : Offset.zero,
                duration: const Duration(milliseconds: 220),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: _hovered ? Colors.white : AppTheme.primaryGreen,
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Scroll Arrow ──────────────────────────────────────────────────────────────

class _ScrollArrow extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double padding;
  final double iconSize;
  const _ScrollArrow({
    required this.icon,
    required this.onTap,
    required this.padding,
    required this.iconSize,
  });

  @override
  State<_ScrollArrow> createState() => _ScrollArrowState();
}

class _ScrollArrowState extends State<_ScrollArrow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.all(widget.padding),
          decoration: BoxDecoration(
            color: _hovered ? AppTheme.primaryGreen : AppTheme.cardLight,
            shape: BoxShape.circle,
            border: Border.all(
              color: _hovered ? AppTheme.primaryGreen : AppTheme.borderLight,
              width: 1.5,
            ),
          ),
          child: Icon(
            widget.icon,
            size: widget.iconSize,
            color: _hovered ? Colors.white : AppTheme.textBlack,
          ),
        ),
      ),
    );
  }
}