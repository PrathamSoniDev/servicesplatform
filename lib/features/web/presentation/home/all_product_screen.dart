// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:servicesplatform/features/web/presentation/seo/seo_widget.dart';
// import 'package:servicesplatform/features/web/utils/app_theme.dart';
// import 'package:servicesplatform/features/web/utils/responsive.dart';
//
// class AllProductScreen extends StatelessWidget {
//   const AllProductScreen({super.key});
//
//   List<Map<String, dynamic>> get products => [
//         {
//           'title': 'Developer Services',
//           'type': 'developer',
//           'desc': 'Web, App & Backend Development',
//           'tags': ['Flutter', 'APIs', 'Backend'],
//           'icon': Icons.terminal_rounded,
//           'badge': 'DEV',
//         },
//         {
//           'title': 'Design Services',
//           'type': 'design',
//           'desc': 'UI/UX, Branding & Graphics',
//           'tags': ['Figma', 'Branding', 'Motion'],
//           'icon': Icons.palette_rounded,
//           'badge': 'UX',
//         },
//         {
//           'title': 'Marketing Services',
//           'type': 'marketing',
//           'desc': 'SEO, Ads & Growth Strategy',
//           'tags': ['SEO', 'Ads', 'Growth'],
//           'icon': Icons.trending_up_rounded,
//           'badge': 'MKT',
//         },
//         {
//           'title': 'Consulting',
//           'type': 'consulting',
//           'desc': 'Business & Tech Consulting',
//           'tags': ['Strategy', 'Tech', 'Audit'],
//           'icon': Icons.lightbulb_outline_rounded,
//           'badge': 'CON',
//         },
//         {
//           'title': 'Cloud & DevOps',
//           'type': 'cloud',
//           'desc': 'Infrastructure, CI/CD & Scaling',
//           'tags': ['AWS', 'Docker', 'CI/CD'],
//           'icon': Icons.cloud_queue_rounded,
//           'badge': 'OPS',
//         },
//         {
//           'title': 'Data & AI',
//           'type': 'ai',
//           'desc': 'ML Models, Analytics & Pipelines',
//           'tags': ['ML', 'Analytics', 'LLMs'],
//           'icon': Icons.auto_awesome_rounded,
//           'badge': 'AI',
//         },
//       ];
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final isMobile = Responsive.isMobile(context);
//
//     int crossAxisCount = 2;
//     if (width > 1200) {
//       crossAxisCount = 3;
//     } else if (width > 700) {
//       crossAxisCount = 2;
//     } else {
//       crossAxisCount = 1;
//     }
//
//     return SeoWrapper(
//       child: Scaffold(
//         backgroundColor: AppTheme.darkBackground,
//
//         /// ── APP BAR ──────────────────────────────────────────────────────
//         appBar: AppBar(
//           backgroundColor: AppTheme.darkBackground,
//           elevation: 0,
//           centerTitle: false,
//           leadingWidth: 80,
//           leading: Padding(
//             padding: const EdgeInsets.only(left: 16.0),
//             child: Center(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.05),
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: Colors.white.withOpacity(0.1)),
//                     ),
//                     child: IconButton(
//                       onPressed: () async {
//                         final bool didPop =
//                             await Navigator.of(context).maybePop();
//                         if (!didPop && context.mounted) {
//                           context.go('/');
//                         }
//                       },
//                       icon: const Icon(
//                         Icons.arrow_back_ios_new_rounded,
//                         color: Colors.white,
//                         size: 18,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           title: const SeoHeader(
//             child: SeoHeading("All Products"),
//           ),
//         ),
//
//         /// ── BODY ─────────────────────────────────────────────────────────
//         body: SeoBody(
//           child: Center(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(
//                 maxWidth: Responsive.maxContentWidth(context),
//               ),
//               child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: Padding(
//                   padding: Responsive.screenPadding(context),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 12),
//
//                       /// ── HERO HEADER ─────────────────────────────────────
//                       _HeroHeader(isMobile: isMobile),
//
//                       const SizedBox(height: 40),
//
//                       /// ── GRID ────────────────────────────────────────────
//                       GridView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: products.length,
//                         gridDelegate:
//                             SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: crossAxisCount,
//                           crossAxisSpacing: 20,
//                           mainAxisSpacing: 20,
//                           childAspectRatio: isMobile ? 1.05 : 0.95,
//                         ),
//                         itemBuilder: (context, index) {
//                           final p = products[index];
//                           return _ProductCard(
//                             title: p['title'] as String,
//                             desc: p['desc'] as String,
//                             tags: p['tags'] as List<String>,
//                             icon: p['icon'] as IconData,
//                             badge: p['badge'] as String,
//                             onTap: () {
//                               context.push('/product/detail/${p['type']}');
//                             },
//                           );
//                         },
//                       ),
//
//                       const SizedBox(height: 80),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────────────────────────────────────
// // HERO HEADER
// // ─────────────────────────────────────────────────────────────────────────────
// class _HeroHeader extends StatelessWidget {
//   final bool isMobile;
//   const _HeroHeader({required this.isMobile});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Label pill
//         Container(
//           padding:
//               const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
//           decoration: BoxDecoration(
//             color: AppTheme.primaryGreen.withOpacity(0.10),
//             borderRadius: BorderRadius.circular(30),
//             border: Border.all(
//                 color: AppTheme.primaryGreen.withOpacity(0.22)),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 6,
//                 height: 6,
//                 decoration: BoxDecoration(
//                   color: AppTheme.primaryGreen,
//                   shape: BoxShape.circle,
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 "SERVICES CATALOGUE",
//                 style: TextStyle(
//                   color: AppTheme.primaryGreen,
//                   fontSize: 11,
//                   fontWeight: FontWeight.w800,
//                   letterSpacing: 1.8,
//                 ),
//               ),
//             ],
//           ),
//         ),
//
//         const SizedBox(height: 20),
//
//         // Headline
//         Text(
//           "Everything you\nneed to ship.",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: isMobile ? 36 : 54,
//             fontWeight: FontWeight.w900,
//             height: 1.05,
//             letterSpacing: -1.5,
//           ),
//         ),
//
//         const SizedBox(height: 16),
//
//         // Subtext
//         Text(
//           "Explore our full suite of expert-led services built\nfor modern teams and ambitious products.",
//           style: TextStyle(
//             color: Colors.white.withOpacity(0.45),
//             fontSize: isMobile ? 14 : 16,
//             height: 1.6,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// // ─────────────────────────────────────────────────────────────────────────────
// // PRODUCT CARD  (mirrors BlogCard's dark aesthetic + LayoutBuilder tiers)
// // ─────────────────────────────────────────────────────────────────────────────
// class _ProductCard extends StatefulWidget {
//   final String title;
//   final String desc;
//   final List<String> tags;
//   final IconData icon;
//   final String badge;
//   final VoidCallback onTap;
//
//   const _ProductCard({
//     required this.title,
//     required this.desc,
//     required this.tags,
//     required this.icon,
//     required this.badge,
//     required this.onTap,
//   });
//
//   @override
//   State<_ProductCard> createState() => _ProductCardState();
// }
//
// class _ProductCardState extends State<_ProductCard> {
//   bool _hovered = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final isMobile = Responsive.isMobile(context);
//
//     return MouseRegion(
//       cursor: SystemMouseCursors.click,
//       onEnter: (_) {
//         if (!isMobile) setState(() => _hovered = true);
//       },
//       onExit: (_) {
//         if (!isMobile) setState(() => _hovered = false);
//       },
//       child: GestureDetector(
//         onTap: widget.onTap,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 280),
//           clipBehavior: Clip.antiAlias,
//           transform: Matrix4.identity()
//             ..translate(0.0, _hovered && !isMobile ? -4.0 : 0.0),
//           transformAlignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: const Color(0xFF111111),
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(
//               color: _hovered
//                   ? AppTheme.primaryGreen.withOpacity(0.65)
//                   : Colors.white.withOpacity(0.07),
//               width: 1.5,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.40),
//                 blurRadius: 14,
//                 offset: const Offset(0, 6),
//               ),
//               if (_hovered)
//                 BoxShadow(
//                   color: AppTheme.primaryGreen.withOpacity(0.16),
//                   blurRadius: 32,
//                   spreadRadius: 2,
//                   offset: const Offset(0, 10),
//                 ),
//             ],
//           ),
//           child: LayoutBuilder(
//             builder: (context, box) {
//               final w = box.maxWidth;
//               final h = box.maxHeight;
//
//               // Tier 1 – micro
//               if (h < 110 || w < 120) {
//                 return _ProdMicro(icon: widget.icon);
//               }
//               // Tier 2 – minimal
//               if (h < 180 || w < 180) {
//                 return _ProdMinimal(
//                   icon: widget.icon,
//                   title: widget.title,
//                   badge: widget.badge,
//                 );
//               }
//               // Tier 3 – compact
//               if (h < 280 || w < 240) {
//                 return _ProdCompact(
//                   icon: widget.icon,
//                   title: widget.title,
//                   badge: widget.badge,
//                   hovered: _hovered,
//                   cardH: h,
//                   cardW: w,
//                 );
//               }
//               // Tier 4/5 – full
//               return _ProdFull(
//                 icon: widget.icon,
//                 title: widget.title,
//                 desc: widget.desc,
//                 tags: widget.tags,
//                 badge: widget.badge,
//                 hovered: _hovered,
//                 cardH: h,
//                 cardW: w,
//                 isMobile: isMobile,
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // ─── TIER 1 – MICRO ───────────────────────────────────────────────────────────
// class _ProdMicro extends StatelessWidget {
//   final IconData icon;
//   const _ProdMicro({required this.icon});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: AppTheme.primaryGreen.withOpacity(0.10),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Icon(icon, color: AppTheme.primaryGreen, size: 20),
//       ),
//     );
//   }
// }
//
// // ─── TIER 2 – MINIMAL ─────────────────────────────────────────────────────────
// class _ProdMinimal extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String badge;
//   const _ProdMinimal(
//       {required this.icon, required this.title, required this.badge});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(12),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: AppTheme.primaryGreen.withOpacity(0.10),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Icon(icon, color: AppTheme.primaryGreen, size: 16),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(
//               title,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 13,
//                 fontWeight: FontWeight.w800,
//                 height: 1.2,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ─── TIER 3 – COMPACT ─────────────────────────────────────────────────────────
// class _ProdCompact extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String badge;
//   final bool hovered;
//   final double cardH;
//   final double cardW;
//   const _ProdCompact({
//     required this.icon,
//     required this.title,
//     required this.badge,
//     required this.hovered,
//     required this.cardH,
//     required this.cardW,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final double pad = cardW < 200 ? 12 : 16;
//     return Padding(
//       padding: EdgeInsets.all(pad),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _IconBox(icon: icon),
//               _BadgePill(badge: badge),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Expanded(
//             child: Text(
//               title,
//               maxLines: 3,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: cardW < 200 ? 13 : 15,
//                 fontWeight: FontWeight.w700,
//                 height: 1.25,
//               ),
//             ),
//           ),
//           if (cardH > 200) _ReadArrow(hovered: hovered, compact: true),
//         ],
//       ),
//     );
//   }
// }
//
// // ─── TIER 4/5 – FULL ──────────────────────────────────────────────────────────
// class _ProdFull extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String desc;
//   final List<String> tags;
//   final String badge;
//   final bool hovered;
//   final double cardH;
//   final double cardW;
//   final bool isMobile;
//
//   const _ProdFull({
//     required this.icon,
//     required this.title,
//     required this.desc,
//     required this.tags,
//     required this.badge,
//     required this.hovered,
//     required this.cardH,
//     required this.cardW,
//     required this.isMobile,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final bool showImage = cardH > 380;
//     final bool showDesc = cardH > 280 && cardW > 220;
//     final bool showTags = cardH > 320;
//     final double pad = cardW < 280 ? 14 : 20;
//     final double titleSz = cardW < 280 ? 14.0 : (isMobile ? 15.0 : 17.0);
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         /// ── Image / gradient area ────────────────────────────────────
//         if (showImage)
//           Expanded(
//             flex: cardH > 480 ? 5 : 4,
//             child: Stack(
//               fit: StackFit.expand,
//               children: [
//                 Container(
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [Color(0xFF0D2016), Color(0xFF000000)],
//                     ),
//                   ),
//                 ),
//                 Center(
//                   child: Icon(
//                     icon,
//                     color: AppTheme.primaryGreen.withOpacity(0.85),
//                     size: cardH * 0.10,
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   left: 0,
//                   right: 0,
//                   child: Container(
//                     height: 40,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           Colors.transparent,
//                           const Color(0xFF111111).withOpacity(0.95),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//         /// ── Divider ─────────────────────────────────────────────────
//         if (showImage)
//           Container(
//             height: 1,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   AppTheme.primaryGreen.withOpacity(hovered ? 0.55 : 0.12),
//                   Colors.transparent,
//                 ],
//               ),
//             ),
//           ),
//
//         /// ── Text content ─────────────────────────────────────────────
//         Padding(
//           padding: EdgeInsets.all(pad),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Icon + badge (when no image area)
//               if (!showImage) ...[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     _IconBox(icon: icon),
//                     _BadgePill(badge: badge),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//               ] else ...[
//                 _BadgePill(badge: badge),
//                 const SizedBox(height: 8),
//               ],
//
//               // Title
//               Text(
//                 title,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: titleSz,
//                   fontWeight: FontWeight.w700,
//                   height: 1.2,
//                   letterSpacing: -0.2,
//                 ),
//               ),
//
//               // Description
//               if (showDesc) ...[
//                 const SizedBox(height: 7),
//                 Text(
//                   desc,
//                   maxLines: cardH > 460 ? 3 : 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     color: Colors.white.withOpacity(0.45),
//                     fontSize: 12.5,
//                     height: 1.5,
//                   ),
//                 ),
//               ],
//
//               // Tags
//               if (showTags) ...[
//                 const SizedBox(height: 10),
//                 Wrap(
//                   spacing: 6,
//                   runSpacing: 6,
//                   children: tags
//                       .map((t) => _TagChip(label: t))
//                       .toList(),
//                 ),
//               ],
//
//               const SizedBox(height: 12),
//
//               // CTA
//               _ReadArrow(hovered: hovered, compact: false),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// // ─────────────────────────────────────────────────────────────────────────────
// // SHARED SMALL WIDGETS
// // ─────────────────────────────────────────────────────────────────────────────
//
// class _IconBox extends StatelessWidget {
//   final IconData icon;
//   const _IconBox({required this.icon});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: AppTheme.primaryGreen.withOpacity(0.10),
//         borderRadius: BorderRadius.circular(12),
//         border:
//             Border.all(color: AppTheme.primaryGreen.withOpacity(0.22), width: 1),
//       ),
//       child: Icon(icon, color: AppTheme.primaryGreen, size: 20),
//     );
//   }
// }
//
// class _BadgePill extends StatelessWidget {
//   final String badge;
//   const _BadgePill({required this.badge});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: AppTheme.primaryGreen.withOpacity(0.08),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: AppTheme.primaryGreen.withOpacity(0.22)),
//       ),
//       child: Text(
//         badge,
//         style: TextStyle(
//           color: AppTheme.primaryGreen,
//           fontSize: 9.5,
//           fontWeight: FontWeight.w800,
//           letterSpacing: 1.2,
//         ),
//       ),
//     );
//   }
// }
//
// class _TagChip extends StatelessWidget {
//   final String label;
//   const _TagChip({required this.label});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.05),
//         borderRadius: BorderRadius.circular(6),
//         border: Border.all(color: Colors.white.withOpacity(0.10)),
//       ),
//       child: Text(
//         label,
//         style: TextStyle(
//           color: Colors.white.withOpacity(0.50),
//           fontSize: 10.5,
//           fontWeight: FontWeight.w500,
//           letterSpacing: 0.2,
//         ),
//       ),
//     );
//   }
// }
//
// class _ReadArrow extends StatelessWidget {
//   final bool hovered;
//   final bool compact;
//   const _ReadArrow({required this.hovered, required this.compact});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           compact ? "View" : "View details",
//           style: TextStyle(
//             color: AppTheme.primaryGreen,
//             fontWeight: FontWeight.w600,
//             fontSize: compact ? 11 : 12.5,
//           ),
//         ),
//         const SizedBox(width: 4),
//         AnimatedSlide(
//           offset: hovered ? const Offset(0.25, 0) : Offset.zero,
//           duration: const Duration(milliseconds: 250),
//           child: Icon(
//             Icons.arrow_forward_rounded,
//             size: compact ? 13 : 14,
//             color: AppTheme.primaryGreen,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/features/web/presentation/seo/seo_widget.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';
import 'package:servicesplatform/models/service_model.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({super.key});

  List<ServiceModel> get services => [
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
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final width = MediaQuery.of(context).size.width;

    int crossAxisCount = 1;

    if (width > 1400) {
      crossAxisCount = 4;
    } else if (width > 1100) {
      crossAxisCount = 3;
    } else if (width > 700) {
      crossAxisCount = 2;
    }

    return SeoWrapper(
      child: Scaffold(
        backgroundColor: AppTheme.darkBackground,

        appBar: AppBar(
          backgroundColor: AppTheme.darkBackground,
          elevation: 0,

          leading: Padding(
            padding: const EdgeInsets.only(left: 14),
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
              ),
            ),
          ),

          title: SeoHeader(
            child: SeoHeading(
              "All Services",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: Responsive.scaleText(context, 20),
              ),
            ),
          ),
        ),

        body: SeoBody(
          child: Stack(
            children: [
              /// GLOW
              Positioned(
                top: -180,
                left: -180,
                child: _buildGlow(AppTheme.primaryGreen, 420, .08),
              ),

              Positioned(
                bottom: -240,
                right: -200,
                child: _buildGlow(Colors.blueAccent, 500, .05),
              ),

              /// CONTENT
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: Responsive.maxContentWidth(context),
                  ),
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      /// HERO
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: Responsive.screenPadding(context),
                          child: _HeroSection(isMobile: isMobile),
                        ),
                      ),

                      /// GRID
                      SliverPadding(
                        padding: Responsive.screenPadding(context),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final service = services[index];

                            return RepaintBoundary(
                              child: _ServiceCard(
                                service: service,
                                onTap: () {
                                  kIsWeb
                                      ? context.go(
                                        '/product/detail/${service.name.trim()}',
                                        extra: service,
                                      )
                                      : context.push(
                                        '/product/detail/${service.name.trim()}',
                                        extra: service,
                                      );
                                },
                              ),
                            );
                          }, childCount: services.length),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                mainAxisSpacing: 24,
                                crossAxisSpacing: 24,
                                childAspectRatio: isMobile ? .6 : .55,
                              ),
                        ),
                      ),

                      const SliverToBoxAdapter(child: SizedBox(height: 100)),
                    ],
                  ),
                ),
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

class _HeroSection extends StatelessWidget {
  final bool isMobile;

  const _HeroSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppTheme.primaryGreen.withValues(alpha: .08),
            border: Border.all(
              color: AppTheme.primaryGreen.withValues(alpha: .15),
            ),
          ),
          child: SeoText(
            "PREMIUM DIGITAL SOLUTIONS",
            style: TextStyle(
              color: AppTheme.primaryGreen,
              fontWeight: FontWeight.w800,
              fontSize: 11,
              letterSpacing: 1.7,
            ),
          ),
        ),

        SizedBox(height: isMobile ? 26 : 36),

        SeoHeading(
          "Enterprise Services\nBuilt To Scale",
          align: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: isMobile ? 42 : 74,
            fontWeight: FontWeight.w900,
            height: .95,
            letterSpacing: -3,
          ),
        ),

        const SizedBox(height: 24),

        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: SeoText(
            "Explore scalable SaaS platforms, enterprise software solutions, mobile applications, cloud infrastructure, and modern digital ecosystems engineered for startups and businesses.",
            align: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: .62),
              fontSize: isMobile ? 14 : 17,
              height: 1.9,
            ),
          ),
        ),

        SizedBox(height: isMobile ? 50 : 70),
      ],
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final ServiceModel service;
  final VoidCallback onTap;

  const _ServiceCard({required this.service, required this.onTap});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final service = widget.service;
    final isMobile = Responsive.isMobile(context);

    return MouseRegion(
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
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 320),
          transform: Matrix4.identity()..translate(0.0, hovered ? -6.0 : 0.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color(0xFF111111),
            border: Border.all(
              color:
                  hovered
                      ? AppTheme.primaryGreen.withValues(alpha: .45)
                      : Colors.white.withValues(alpha: .06),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .30),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),

              if (hovered)
                BoxShadow(
                  color: AppTheme.primaryGreen.withValues(alpha: .15),
                  blurRadius: 40,
                  spreadRadius: 1,
                ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TOP
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppTheme.primaryGreen.withValues(alpha: .10),
                        Colors.black,
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: -50,
                        left: -50,
                        child: Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.primaryGreen.withValues(alpha: .08),
                          ),
                        ),
                      ),

                      Center(
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 300),
                          scale: hovered ? 1.08 : 1,
                          child: Container(
                            width: 100,
                            height: 100,
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
                                  color: AppTheme.primaryGreen.withValues(
                                    alpha: .25,
                                  ),
                                  blurRadius: 30,
                                ),
                              ],
                            ),
                            child: Icon(
                              service.icon,
                              size: 46,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 22,
                        right: 22,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white.withValues(alpha: .06),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: .08),
                            ),
                          ),
                          child: SeoText(
                            service.category.toUpperCase(),
                            style: TextStyle(
                              color: AppTheme.primaryGreen,
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// CONTENT
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SeoHeading(
                        service.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 24,
                          height: 1.2,
                        ),
                      ),

                      const SizedBox(height: 14),

                      SeoText(
                        service.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: .58),
                          fontSize: 14,
                          height: 1.8,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children:
                            service.technologies
                                .take(3)
                                .map(
                                  (tech) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white.withValues(
                                        alpha: .04,
                                      ),
                                      border: Border.all(color: Colors.white12),
                                    ),
                                    child: SeoText(
                                      tech,
                                      style: TextStyle(
                                        color: Colors.white.withValues(
                                          alpha: .70,
                                        ),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),

                      const Spacer(),

                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color:
                                    hovered
                                        ? AppTheme.primaryGreen
                                        : Colors.white.withValues(alpha: .05),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SeoText(
                                    "Explore Solution",
                                    style: TextStyle(
                                      color:
                                          hovered ? Colors.black : Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14,
                                    ),
                                  ),

                                  const SizedBox(width: 10),

                                  AnimatedSlide(
                                    duration: const Duration(milliseconds: 220),
                                    offset:
                                        hovered
                                            ? const Offset(.2, 0)
                                            : Offset.zero,
                                    child: Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 18,
                                      color:
                                          hovered
                                              ? Colors.black
                                              : AppTheme.primaryGreen,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
