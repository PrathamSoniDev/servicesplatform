import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/presentation/seo/seo_widget.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';

class IndustriesSection extends StatefulWidget {
  const IndustriesSection({super.key});

  @override
  State<IndustriesSection> createState() => _IndustriesSectionState();
}

class _IndustriesSectionState extends State<IndustriesSection>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late final AnimationController _entranceCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  final List<_IndustryModel> industries = [
    _IndustryModel(
      title: "Healthcare",
      icon: Icons.local_hospital_rounded,
      description:
          "Digital healthcare platforms, telemedicine systems, and patient management solutions.",
    ),

    _IndustryModel(
      title: "Education",
      icon: Icons.school_rounded,
      description:
          "Modern eLearning ecosystems, LMS platforms, and virtual classroom solutions.",
    ),

    _IndustryModel(
      title: "Finance & Banking",
      icon: Icons.account_balance_rounded,
      description:
          "Secure fintech applications, banking systems, and payment infrastructures.",
    ),

    _IndustryModel(
      title: "eCommerce",
      icon: Icons.shopping_cart_rounded,
      description:
          "Scalable online stores, multi-vendor systems, and commerce ecosystems.",
    ),

    _IndustryModel(
      title: "Real Estate",
      icon: Icons.home_work_rounded,
      description: "Property management platforms and real estate CRM systems.",
    ),

    _IndustryModel(
      title: "Logistics",
      icon: Icons.local_shipping_rounded,
      description:
          "Fleet tracking, logistics automation, and transportation systems.",
    ),

    _IndustryModel(
      title: "Food & Restaurant",
      icon: Icons.restaurant_rounded,
      description:
          "Restaurant management systems and food delivery applications.",
    ),

    _IndustryModel(
      title: "Travel & Tourism",
      icon: Icons.flight_takeoff_rounded,
      description: "Travel booking platforms and tourism management systems.",
    ),

    _IndustryModel(
      title: "Fitness & Wellness",
      icon: Icons.fitness_center_rounded,
      description:
          "Fitness ecosystems, wellness applications, and subscription platforms.",
    ),

    _IndustryModel(
      title: "Media & Entertainment",
      icon: Icons.movie_creation_rounded,
      description:
          "Streaming platforms, media systems, and entertainment applications.",
    ),

    _IndustryModel(
      title: "HR & Recruitment",
      icon: Icons.groups_rounded,
      description:
          "Recruitment management systems and HR automation platforms.",
    ),

    _IndustryModel(
      title: "Social Networking",
      icon: Icons.public_rounded,
      description:
          "Real-time communication and community engagement platforms.",
    ),

    _IndustryModel(
      title: "Retail & Fashion",
      icon: Icons.checkroom_rounded,
      description: "Retail automation systems and fashion commerce platforms.",
    ),

    _IndustryModel(
      title: "SaaS Startups",
      icon: Icons.dashboard_customize_rounded,
      description:
          "Scalable SaaS products with cloud infrastructure and subscriptions.",
    ),

    _IndustryModel(
      title: "Enterprise Businesses",
      icon: Icons.business_center_rounded,
      description:
          "Enterprise-grade digital transformation and automation systems.",
    ),
  ];

  @override
  void initState() {
    super.initState();

    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    );

    _fadeAnim = CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeOut);

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeOutCubic),
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _entranceCtrl.forward(),
    );
  }

  @override
  void dispose() {
    _entranceCtrl.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scroll(bool left, double width) {
    final move = width * .75;

    final target =
        left
            ? (_scrollController.offset - move).clamp(
              0.0,
              _scrollController.position.maxScrollExtent,
            )
            : (_scrollController.offset + move).clamp(
              0.0,
              _scrollController.position.maxScrollExtent,
            );

    _scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
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
          child: Stack(
            children: [
              /// GLOW
              Positioned(
                top: -140,
                left: -120,
                child: _buildGlow(AppTheme.primaryGreen, 320, .05),
              ),

              Positioned(
                bottom: -120,
                right: -80,
                child: _buildGlow(AppTheme.primaryGreen, 260, .04),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: isMobile ? 24 : 44),

                  /// HEADER
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: hPadding),
                    child: _IndustriesHeader(
                      isMobile: isMobile,
                      screenW: screenW,
                    ),
                  ),

                  SizedBox(height: isMobile ? 20 : 36),

                  /// CARDS
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final maxW = constraints.maxWidth;

                        final maxH = constraints.maxHeight;

                        final cardW =
                            isMobile
                                ? screenW * .82
                                : isTablet
                                ? 300.0
                                : 350.0;

                        final cardH = maxH.clamp(160.0, 500.0);

                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            /// LIST
                            ListView.builder(
                              controller: _scrollController,
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 40 : 60,
                                vertical: 10,
                              ),
                              itemCount: industries.length,
                              itemBuilder: (context, index) {
                                final industry = industries[index];

                                return Padding(
                                  padding: EdgeInsets.only(
                                    right: isMobile ? 16 : 24,
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                      width: cardW,
                                      height: cardH - 20,
                                      child: _IndustryCard(industry: industry),
                                    ),
                                  ),
                                );
                              },
                            ),

                            /// LEFT
                            Positioned(
                              left: 8,
                              child: _ScrollArrow(
                                icon: Icons.arrow_back_ios_new_rounded,
                                onTap: () => _scroll(true, maxW),
                              ),
                            ),

                            /// RIGHT
                            Positioned(
                              right: 8,
                              child: _ScrollArrow(
                                icon: Icons.arrow_forward_ios_rounded,
                                onTap: () => _scroll(false, maxW),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  SizedBox(height: isMobile ? 24 : 44),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGlow(Color color, double size, double opacity) {
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
}

class _IndustriesHeader extends StatelessWidget {
  final bool isMobile;
  final double screenW;

  const _IndustriesHeader({required this.isMobile, required this.screenW});

  @override
  Widget build(BuildContext context) {
    final titleSize = screenW < 360 ? 22.0 : (isMobile ? 30.0 : 52.0);

    final subSize = screenW < 360 ? 11.0 : (isMobile ? 13.0 : 16.0);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 28,
              height: 1,
              color: AppTheme.primaryGreen.withValues(alpha: .35),
            ),

            const SizedBox(width: 10),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withValues(alpha: .08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppTheme.primaryGreen.withValues(alpha: .25),
                ),
              ),
              child: SeoText(
                "INDUSTRIES WE SERVE",
                style: TextStyle(
                  color: AppTheme.primaryGreen,
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                  letterSpacing: 1.6,
                ),
              ),
            ),

            const SizedBox(width: 10),

            Container(
              width: 28,
              height: 1,
              color: AppTheme.primaryGreen.withValues(alpha: .35),
            ),
          ],
        ),

        SizedBox(height: isMobile ? 12 : 18),

        SeoHeading(
          "Industries We Empower",
          align: TextAlign.center,
          style: TextStyle(
            color: AppTheme.textBlack,
            fontSize: titleSize,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
            height: 1.05,
          ),
        ),

        SizedBox(height: isMobile ? 10 : 14),

        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: SeoText(
            "We develop scalable technology solutions across multiple industries and business sectors.",
            align: TextAlign.center,
            style: TextStyle(
              color: AppTheme.textGrey,
              fontSize: subSize,
              height: 1.7,
            ),
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

class _IndustryCard extends StatefulWidget {
  final _IndustryModel industry;

  const _IndustryCard({required this.industry});

  @override
  State<_IndustryCard> createState() => _IndustryCardState();
}

class _IndustryCardState extends State<_IndustryCard> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        if (!isMobile) {
          setState(() => hovered = true);
        }
      },
      onExit: (_) {
        if (!isMobile) {
          setState(() => hovered = false);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.identity()..translate(0.0, hovered ? -6 : 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: const Color(0xFF111111),
          border: Border.all(
            color:
                hovered
                    ? AppTheme.primaryGreen.withValues(alpha: .35)
                    : Colors.white.withValues(alpha: .05),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .14),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: AppTheme.primaryGreen.withValues(alpha: .12),
                      border: Border.all(
                        color: AppTheme.primaryGreen.withValues(alpha: .18),
                      ),
                    ),
                    child: Icon(
                      widget.industry.icon,
                      color: AppTheme.primaryGreen,
                      size: 28,
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppTheme.primaryGreen.withValues(alpha: .08),
                      border: Border.all(
                        color: AppTheme.primaryGreen.withValues(alpha: .18),
                      ),
                    ),
                    child: SeoText(
                      "INDUSTRY",
                      style: TextStyle(
                        color: AppTheme.primaryGreen,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              SeoHeading(
                widget.industry.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 26,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 18),

              SeoText(
                widget.industry.description,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: .62),
                  fontSize: 14,
                  height: 1.8,
                ),
              ),

              const SizedBox(height: 28),

              Row(
                children: [
                  SeoText(
                    "Explore Industry",
                    style: TextStyle(
                      color: hovered ? AppTheme.primaryGreen : Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(width: 10),

                  /// Enable in Future
                  // AnimatedSlide(
                  //   duration: const Duration(milliseconds: 250),
                  //   offset: hovered ? const Offset(.2, 0) : Offset.zero,
                  //   child: Icon(
                  //     Icons.arrow_forward_rounded,
                  //     color: hovered ? AppTheme.primaryGreen : Colors.white,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScrollArrow extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ScrollArrow({required this.icon, required this.onTap});

  @override
  State<_ScrollArrow> createState() => _ScrollArrowState();
}

class _ScrollArrowState extends State<_ScrollArrow> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: hovered ? AppTheme.primaryGreen : Colors.white,
            border: Border.all(
              color: hovered ? AppTheme.primaryGreen : Colors.black12,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .08),
                blurRadius: 20,
              ),
            ],
          ),
          child: Icon(
            widget.icon,
            color: hovered ? Colors.white : Colors.black,
            size: 20,
          ),
        ),
      ),
    );
  }
}

class _IndustryModel {
  final String title;
  final String description;
  final IconData icon;

  _IndustryModel({
    required this.title,
    required this.description,
    required this.icon,
  });
}
