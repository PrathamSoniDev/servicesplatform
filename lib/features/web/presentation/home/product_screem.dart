import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/features/web/presentation/seo/seo_widget.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';
import 'package:servicesplatform/features/web/widgets/product_card.dart';
import 'package:servicesplatform/models/service_model.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _productScrollController = ScrollController();

  late final AnimationController _entranceCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  final List<ServiceModel> services = [
    ServiceModel(
      name: 'Mobile App Development',
      category: 'Mobile Solutions',
      description:
          'Custom Android, iOS, and cross-platform mobile applications built for performance, scalability, and exceptional user experience.',
      fullDescription:
          'We develop high-quality mobile applications using modern technologies such as Flutter, React Native, Kotlin, and Swift. Our apps are optimized for speed, scalability, security, and seamless user interaction.\n\nWhether you need a startup MVP, enterprise mobile solution, eCommerce app, booking platform, social app, healthcare solution, or on-demand service application, we create products that deliver real business results.',
      imageUrl: [],
      features: [
        'Android App Development',
        'iOS App Development',
        'Flutter App Development',
        'Cross-Platform Applications',
        'App UI/UX Design',
        'API Integration',
        'Firebase Integration',
        'Real-Time Features',
        'Push Notifications',
        'App Store Deployment',
        'Play Store Deployment',
        'App Maintenance & Support',
      ],
      technologies: [
        'Flutter',
        'Firebase',
        'Node.js',
        'REST API',
        'Supabase',
        'MongoDB',
      ],
      deliveryTime: '4 - 12 Weeks',
      scalability: 'Enterprise Ready',
      icon: Icons.phone_android_rounded,
    ),

    ServiceModel(
      name: 'Web Development',
      category: 'Web Solutions',
      description:
          'Modern, responsive, SEO-friendly websites and web applications designed for business growth.',
      fullDescription:
          'We create fast, secure, responsive, and conversion-focused websites for startups, businesses, agencies, and enterprises. Our development approach focuses on performance optimization, clean architecture, responsive design, and scalable backend systems.\n\nFrom company websites to advanced web applications and SaaS platforms, we build solutions that enhance digital presence and customer engagement.',
      imageUrl: [],
      features: [
        'Corporate Websites',
        'Business Websites',
        'Portfolio Websites',
        'eCommerce Websites',
        'Admin Dashboards',
        'SaaS Platforms',
        'Progressive Web Apps',
        'CMS Development',
        'API Development',
        'SEO Optimization',
        'Responsive Design',
        'Website Maintenance',
      ],
      technologies: [
        'React',
        'Next.js',
        'Flutter Web',
        'Firebase Hosting',
        'Node.js',
        'TypeScript',
      ],
      deliveryTime: '3 - 10 Weeks',
      scalability: 'Cloud Scalable',
      icon: Icons.language_rounded,
    ),

    ServiceModel(
      name: 'Custom Software Development',
      category: 'Enterprise Software',
      description:
          'Enterprise-grade custom software solutions tailored to your business operations and workflows.',
      fullDescription:
          'We develop secure and scalable software systems that streamline operations, automate processes, and improve business productivity.\n\nOur custom software solutions are designed specifically around your business requirements, ensuring maximum efficiency, flexibility, and scalability.',
      imageUrl: [],
      features: [
        'ERP Solutions',
        'CRM Development',
        'HRMS Platforms',
        'Business Automation',
        'Inventory Management',
        'Billing & POS Software',
        'Workflow Automation',
        'Cloud-Based Software',
        'Enterprise Architecture',
        'Data Management Systems',
      ],
      technologies: [
        'Flutter',
        'Node.js',
        'PostgreSQL',
        'MongoDB',
        'AWS',
        'Docker',
      ],
      deliveryTime: '6 - 16 Weeks',
      scalability: 'Enterprise Grade',
      icon: Icons.business_center_rounded,
    ),

    ServiceModel(
      name: 'UI/UX Design',
      category: 'Design Services',
      description:
          'User-centered interface and experience design focused on engagement and usability.',
      fullDescription:
          'We design visually modern, intuitive, and conversion-driven user interfaces that enhance customer experience and improve product usability.\n\nOur UI/UX process focuses on user research, wireframing, prototyping, accessibility, interaction design, and responsive experiences.',
      imageUrl: [],
      features: [
        'Mobile App UI Design',
        'Website UI Design',
        'Dashboard Design',
        'Wireframing',
        'Interactive Prototypes',
        'Design Systems',
        'UX Research',
        'Responsive Design',
        'User Journey Mapping',
        'Accessibility Optimization',
      ],
      technologies: ['Figma', 'Adobe XD', 'Photoshop', 'Illustrator', 'Framer'],
      deliveryTime: '2 - 6 Weeks',
      scalability: 'Design System Ready',
      icon: Icons.design_services_rounded,
    ),

    ServiceModel(
      name: 'Cloud & Backend Solutions',
      category: 'Backend Infrastructure',
      description:
          'Scalable backend infrastructure and cloud-based solutions for modern digital products.',
      fullDescription:
          'We develop secure backend systems and cloud architectures that power scalable applications and enterprise platforms.\n\nOur backend solutions ensure high availability, strong security, seamless integrations, and optimized performance.',
      imageUrl: [],
      features: [
        'Backend API Development',
        'Node.js Development',
        'Firebase Solutions',
        'Cloud Deployment',
        'Database Architecture',
        'Authentication Systems',
        'Real-Time Infrastructure',
        'Server Management',
        'DevOps Integration',
        'Scalable Cloud Solutions',
      ],
      technologies: [
        'Node.js',
        'Firebase',
        'Supabase',
        'AWS',
        'Docker',
        'PostgreSQL',
      ],
      deliveryTime: '3 - 8 Weeks',
      scalability: 'Highly Scalable',
      icon: Icons.cloud_rounded,
    ),

    ServiceModel(
      name: 'Digital Transformation',
      category: 'Business Innovation',
      description:
          'Helping businesses modernize operations through innovative technology solutions.',
      fullDescription:
          'We help organizations transition from traditional processes to digital-first ecosystems through automation, software integration, cloud technologies, and scalable digital infrastructure.',
      imageUrl: [],
      features: [
        'Business Process Automation',
        'Digital Workflow Optimization',
        'Software Modernization',
        'Cloud Migration',
        'Data Digitization',
        'Enterprise Transformation',
        'Productivity Solutions',
        'Technology Consulting',
        'Infrastructure Modernization',
      ],
      technologies: [
        'Cloud Infrastructure',
        'Automation Tools',
        'ERP Systems',
        'CRM Platforms',
        'AI Integrations',
      ],
      deliveryTime: '6 - 20 Weeks',
      scalability: 'Enterprise Transformation',
      icon: Icons.auto_graph_rounded,
    ),

    ServiceModel(
      name: 'SaaS Platform Development',
      category: 'SaaS Solutions',
      description:
          'Scalable SaaS applications engineered for startups, enterprises, and subscription-based businesses.',
      fullDescription:
          'We build secure, scalable, and high-performance SaaS platforms with modern architecture, subscription systems, multi-tenant infrastructure, and advanced dashboards.',
      imageUrl: [],
      features: [
        'Subscription Management',
        'Admin Dashboards',
        'Multi-Tenant Architecture',
        'Authentication & Roles',
        'Billing Integrations',
        'Analytics Dashboard',
        'Cloud Infrastructure',
        'API Integrations',
        'Scalable Backend',
        'Performance Optimization',
      ],
      technologies: [
        'Flutter',
        'Next.js',
        'Node.js',
        'Stripe',
        'AWS',
        'Firebase',
      ],
      deliveryTime: '8 - 20 Weeks',
      scalability: 'Massive Scale Ready',
      icon: Icons.dashboard_customize_rounded,
    ),

    ServiceModel(
      name: 'eCommerce Development',
      category: 'Commerce Solutions',
      description:
          'Modern eCommerce platforms optimized for conversions, scalability, and customer experience.',
      fullDescription:
          'We develop powerful eCommerce websites and applications with seamless shopping experiences, secure payments, inventory systems, and scalable infrastructure.',
      imageUrl: [],
      features: [
        'Online Store Development',
        'Payment Gateway Integration',
        'Inventory Management',
        'Order Management',
        'Admin Dashboard',
        'Customer Analytics',
        'Multi-Vendor Systems',
        'Mobile Commerce',
        'Performance Optimization',
        'SEO Optimization',
      ],
      technologies: [
        'Flutter',
        'Shopify',
        'WooCommerce',
        'Node.js',
        'Stripe',
        'Firebase',
      ],
      deliveryTime: '4 - 12 Weeks',
      scalability: 'High Traffic Ready',
      icon: Icons.shopping_cart_rounded,
    ),
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
      CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeOutCubic),
    );
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _entranceCtrl.forward(),
    );
  }

  @override
  void dispose() {
    _entranceCtrl.dispose();
    _productScrollController.dispose();
    super.dispose();
  }

  void _scroll(bool isLeft, double viewportWidth) {
    final double move = viewportWidth * 0.78;
    final double target =
        isLeft
            ? (_productScrollController.offset - move).clamp(
              0.0,
              _productScrollController.position.maxScrollExtent,
            )
            : (_productScrollController.offset + move).clamp(
              0.0,
              _productScrollController.position.maxScrollExtent,
            );
    _productScrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 480),
      curve: Curves.easeInOutCubic,
    );
  }

  void _openProduct(BuildContext context, ServiceModel service) {
    kIsWeb
        ? context.go('/product/detail/${service.name.trim()}', extra: service)
        : context.push(
          '/product/detail/${service.name.trim()}',
          extra: service,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: isMobile ? 24 : 44),

              // ── HEADER ──────────────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: hPadding),
                child: _ProductHeader(isMobile: isMobile, screenW: screenW),
              ),

              SizedBox(height: isMobile ? 20 : 36),

              // ── CARD SCROLL AREA ────────────────────────────────
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final maxW = constraints.maxWidth;
                    final maxH = constraints.maxHeight;

                    final double cardW =
                        isMobile
                            ? (screenW < 300 ? screenW * 0.88 : maxW * 0.78)
                            : (isTablet ? 300.0 : 350.0);

                    final double cardH = maxH.clamp(160.0, 500.0);
                    final double arrowPad = isMobile ? 10.0 : 14.0;
                    final double arrowIcon = isMobile ? 18.0 : 22.0;

                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        // Card list
                        ListView.builder(
                          addAutomaticKeepAlives: true,
                          addSemanticIndexes: true,
                          addRepaintBoundaries: true,
                          controller: _productScrollController,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 40 : 60,
                            vertical: 10,
                          ),
                          itemCount: services.length,
                          itemBuilder: (ctx, i) {
                            final isDev = services[i];
                            final route = '/product/${isDev.name.trim()}';
                            final label = isDev.name;
                            return Padding(
                              padding: EdgeInsets.only(
                                right: isMobile ? 16 : 24,
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: cardW,
                                  height: cardH - 20,
                                  child: SeoLink(
                                    url: route,
                                    text: label,
                                    child: RepaintBoundary(
                                      child: ProductCard(
                                        service: isDev,
                                        onTap: () => _openProduct(ctx, isDev),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        // ── ARROWS ────────────────────────────────
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

              // ── PLATFORM PILLS ────────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: hPadding),
                child: _PlatformPills(isMobile: isMobile, screenW: screenW),
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

class _ProductHeader extends StatelessWidget {
  final bool isMobile;
  final double screenW;

  const _ProductHeader({required this.isMobile, required this.screenW});

  @override
  Widget build(BuildContext context) {
    final titleSize = screenW < 360 ? 20.0 : (isMobile ? 26.0 : 46.0);
    final subSize = screenW < 360 ? 11.0 : (isMobile ? 13.0 : 16.0);
    final labelSize = screenW < 360 ? 9.0 : 11.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 28,
              height: 1,
              color: AppTheme.primaryGreen.withValues(alpha: .35),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withValues(alpha: .08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppTheme.primaryGreen.withValues(alpha: .25),
                ),
              ),
              child: SeoText(
                "OUR SERVICES",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.primaryGreen,
                  fontWeight: FontWeight.w800,
                  fontSize: labelSize,
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
        FittedBox(
          fit: BoxFit.scaleDown,
          child: SeoHeading(
            "Powering Developers & Businesses",
            align: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textBlack,
              fontSize: titleSize,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.8,
              height: 1.1,
            ),
          ),
        ),
        SizedBox(height: isMobile ? 8 : 12),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SeoText(
            "We provide complete digital product development solutions designed to help businesses innovate, scale, automate, and succeed in the modern digital ecosystem.",
            align: TextAlign.center,
            maxLines: 2,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textGrey,
              fontSize: subSize,
              height: 1.6,
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

// ── Platform Pills ────────────────────────────────────────────────────────────

class _PlatformPills extends StatelessWidget {
  final bool isMobile;
  final double screenW;

  const _PlatformPills({required this.isMobile, required this.screenW});

  void _openAllProducts(BuildContext context) {
    kIsWeb ? context.go('/product/all') : context.push('/product/all');
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 10,
      children: [
        SeoLink(
          url: '/product',
          text: 'All Products',
          child: _PlatformPill(
            label: "All Products",
            icon: Icons.apps, // 🔥 clean generic icon
            onTap: () => _openAllProducts(context),
            screenW: screenW,
          ),
        ),
      ],
    );
  }
}

class _PlatformPill extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final double screenW;

  const _PlatformPill({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.screenW,
  });

  @override
  State<_PlatformPill> createState() => _PlatformPillState();
}

class _PlatformPillState extends State<_PlatformPill> {
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
          padding: EdgeInsets.symmetric(
            horizontal: widget.screenW < 360 ? 14 : 18,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: _hovered ? AppTheme.primaryGreen : AppTheme.cardLight,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: _hovered ? AppTheme.primaryGreen : AppTheme.borderLight,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: widget.screenW < 360 ? 14 : 16,
                color: _hovered ? Colors.white : AppTheme.primaryGreen,
              ),
              const SizedBox(width: 7),
              Text(
                widget.label,
                style: TextStyle(
                  color: _hovered ? Colors.white : AppTheme.textBlack,
                  fontSize: widget.screenW < 360 ? 11 : 13,
                  fontWeight: FontWeight.w700,
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
