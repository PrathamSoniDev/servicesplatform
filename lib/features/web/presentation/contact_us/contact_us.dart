// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:servicesplatform/core/app_router.dart';
// import 'package:servicesplatform/features/web/presentation/common/footer_section.dart';
// import 'package:servicesplatform/features/web/presentation/home/hero_section.dart';
// import 'package:servicesplatform/features/web/utils/responsive.dart';
// import 'package:servicesplatform/features/web/widgets/professional_role_selector_tab.dart';
// import 'package:servicesplatform/features/web/widgets/top_nav_bar.dart';
// import 'package:servicesplatform/features/web/widgets/button.dart';
// import 'package:servicesplatform/features/web/widgets/designer_picker_bottomsheet.dart';
// import 'package:servicesplatform/models/design_item_models.dart';

// import '../../../../core/bootstrap/bloc/app_bootstrap_bloc.dart';
// import '../../../../core/bootstrap/bloc/app_bootstrap_state.dart';
// import '../../../../core/hero/hero_mapper.dart';
// import '../home/custom_shimmer.dart';

// class ContactUs extends StatefulWidget {
//   const ContactUs({super.key});

//   @override
//   State<ContactUs> createState() => _ContactUsState();
// }

// class _ContactUsState extends State<ContactUs> {
//   // ─── CONTROLLERS ───
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _messageController = TextEditingController();

//   // ─── STATE NOTIFIERS ───
//   final ValueNotifier<String> _selectedRoleNotifier = ValueNotifier("Founder");
//   final ValueNotifier<String> _selectedOptionNotifier = ValueNotifier("I want a custom design");
//   final ValueNotifier<DesignItem?> _selectedDesignNotifier = ValueNotifier<DesignItem?>(null);

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _messageController.dispose();
//     _selectedRoleNotifier.dispose();
//     _selectedOptionNotifier.dispose();
//     _selectedDesignNotifier.dispose();
//     super.dispose();
//   }

//   Future<void> _openDesignPicker(BuildContext context) async {
//     final result = await showGeneralDialog<dynamic>(
//       context: context,
//       barrierDismissible: false,
//       barrierLabel: "Dismiss",
//       barrierColor: Colors.black.withOpacity(0.7),
//       transitionDuration: const Duration(milliseconds: 400),
//       pageBuilder: (context, anim1, anim2) {
//         return Center(
//           child: ConstrainedBox(
//             constraints: const BoxConstraints(maxWidth: 1100, maxHeight: 800),
//             child: const Material(
//               color: Colors.transparent,
//               child: DesignPickerBottomSheet(),
//             ),
//           ),
//         );
//       },
//       transitionBuilder: (context, anim1, anim2, child) {
//         return BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 15 * anim1.value, sigmaY: 15 * anim1.value),
//           child: FadeTransition(
//             opacity: anim1,
//             child: ScaleTransition(
//               scale: CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
//               child: child,
//             ),
//           ),
//         );
//       },
//     );

//     if (result != null && result is DesignItem) {
//       _selectedDesignNotifier.value = result;
//       _selectedOptionNotifier.value = "Do you have any liked design?";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               children: [
//                 BlocBuilder<AppBootstrapBloc, AppBootstrapState>(
//                   builder: (context, state) {
//                     if (state.status == AppBootstrapStatus.loading) {
//                       return const AdaptiveShimmer(layout: ShimmerLayout.hero);
//                     }
//                     if (state.status == AppBootstrapStatus.success) {
//                       final data = state.data!;
//                       final hero = data.heroes.firstWhere(
//                         (h) => h.key == 'contact' && h.isActive,
//                         orElse: () => data.heroes.first,
//                       );

//                       return HeroSection(
//                         title: hero.headingText,
//                         subtitle: hero.subHeadingText,
//                         imagePath: resolveAssetUrl(hero.assetUrl),
//                         gradientText: hero.gradientText,
//                         showGradient: hero.gradientText != null,
//                         isOverlayMode: true,
//                         contentAlignment: hero.isContentLeft
//                             ? HeroContentAlignment.left
//                             : hero.isContentRight
//                                 ? HeroContentAlignment.right
//                                 : HeroContentAlignment.center,
//                       );
//                     }
//                     return const SizedBox(height: 100);
//                   },
//                 ),
//                 _buildModernFormSection(context),
//                 const FooterSection(),
//               ],
//             ),
//           ),
//           TopNavBar(
//             activeIndex: 5,
//             onHome: () => context.go(AppRouter.home),
//             onDesigns: () => context.go(AppRouter.home),
//             onAbout: () => context.push(AppRouter.aboutUs),
//             onTestimonials: () => context.go(AppRouter.home),
//             onBlog: () => context.push(AppRouter.blog),
//             onContact: () {},
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildModernFormSection(BuildContext context) {
//     final bool isDesktop = Responsive.isDesktop(context);
//     final double horizontalPadding = MediaQuery.of(context).size.width * (isDesktop ? 0.08 : 0.05);

//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(vertical: 80, horizontal: horizontalPadding),
//       child: Center(
//         child: ConstrainedBox(
//           constraints: const BoxConstraints(maxWidth: 1100),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const _SectionLabel(label: "I AM A..."),
//               const SizedBox(height: 16),
              
//               // ✅ CUSTOM ROLE SELECTOR WIDGET
//               ProfessionalRoleSelector(
//                 controller: _selectedRoleNotifier,
//                 roles: const ["Founder", "Product Designer", "Developer", "Other"],
//               ),
              
//               const SizedBox(height: 48),
//               if (isDesktop)
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(child: _buildLeftColumn()),
//                     const SizedBox(width: 48),
//                     Expanded(child: _buildRightColumn(7)),
//                   ],
//                 )
//               else
//                 Column(
//                   children: [
//                     _buildLeftColumn(),
//                     const SizedBox(height: 32),
//                     _buildRightColumn(5),
//                   ],
//                 ),
//               const SizedBox(height: 60),
//               Center(
//                 child: ConstrainedBox(
//                   constraints: const BoxConstraints(maxWidth: 400),
//                   child: AppButton(
//                     text: "Send Message",
//                     enableGlow: true,
//                     onPressed: () {
//                       // Add your validation and submission logic here
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLeftColumn() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const _SectionLabel(label: "YOUR NAME"),
//         const SizedBox(height: 10),
//         _buildAnimatedField("Full Name", "Enter your name", _nameController),
//         const SizedBox(height: 32),
//         const _SectionLabel(label: "PROJECT STATUS"),
//         const SizedBox(height: 12),
//         _buildRadioOption("Do you have any liked design?"),
//         _buildRadioOption("Do you have your own design?"),
//         _buildRadioOption("I want a custom design"),
//       ],
//     );
//   }

//   Widget _buildRightColumn(int lines) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const _SectionLabel(label: "YOUR E-MAIL"),
//         const SizedBox(height: 10),
//         _buildAnimatedField("Email Address", "Enter your email", _emailController),
//         const SizedBox(height: 32),
//         const _SectionLabel(label: "MESSAGE *"),
//         const SizedBox(height: 10),
//         _buildAnimatedField(
//           "Message",
//           "Tell us about your project details...",
//           _messageController,
//           maxLines: lines,
//         ),
//       ],
//     );
//   }

//   Widget _buildAnimatedField(String label, String hint, TextEditingController controller, {int maxLines = 1}) {
//     return _AnimatedInputField(
//       controller: controller,
//       hint: hint,
//       maxLines: maxLines,
//     );
//   }

//   Widget _buildRadioOption(String title) {
//     return ValueListenableBuilder<String>(
//       valueListenable: _selectedOptionNotifier,
//       builder: (context, selected, _) {
//         final isSelected = selected == title;
//         return InkWell(
//           onTap: () {
//             _selectedOptionNotifier.value = title;
//             if (title == "Do you have any liked design?") {
//               _openDesignPicker(context);
//             }
//           },
//           borderRadius: BorderRadius.circular(8),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             child: Row(
//               children: [
//                 AnimatedContainer(
//                   duration: const Duration(milliseconds: 200),
//                   width: 20,
//                   height: 20,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: isSelected ? const Color(0xFF8E2DE2) : Colors.white.withOpacity(0.2),
//                       width: isSelected ? 6 : 1.5,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 14),
//                 Expanded(
//                   child: ValueListenableBuilder<DesignItem?>(
//                     valueListenable: _selectedDesignNotifier,
//                     builder: (context, design, _) {
//                       String label = title;
//                       if (title == "Do you have any liked design?" && design != null) {
//                         label = "Selected: ${design.title}";
//                       }
//                       return Text(
//                         label,
//                         style: TextStyle(
//                           color: isSelected ? Colors.white : Colors.white60,
//                           fontSize: 15,
//                           fontWeight: (title == "Do you have any liked design?" && design != null) 
//                               ? FontWeight.bold 
//                               : FontWeight.normal,
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// // ─── INTERNAL HELPER WIDGETS ───

// class _AnimatedInputField extends StatefulWidget {
//   final TextEditingController controller;
//   final String hint;
//   final int maxLines;

//   const _AnimatedInputField({
//     required this.controller,
//     required this.hint,
//     this.maxLines = 1,
//   });

//   @override
//   State<_AnimatedInputField> createState() => _AnimatedInputFieldState();
// }

// class _AnimatedInputFieldState extends State<_AnimatedInputField> {
//   final FocusNode _focusNode = FocusNode();
//   bool _isFocused = false;

//   @override
//   void initState() {
//     super.initState();
//     _focusNode.addListener(() {
//       setState(() => _isFocused = _focusNode.hasFocus);
//     });
//   }

//   @override
//   void dispose() {
//     _focusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 250),
//       decoration: BoxDecoration(
//         // Turns light grey-ish/white focus background
//         color: _isFocused ? Colors.white.withOpacity(0.06) : Colors.white.withOpacity(0.02),
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(
//           // Outline becomes light grey on focus
//           color: _isFocused ? Colors.white.withOpacity(0.4) : Colors.white.withOpacity(0.1),
//           width: 1,
//         ),
//       ),
//       child: TextField(
//         controller: widget.controller,
//         focusNode: _focusNode,
//         maxLines: widget.maxLines,
//         style: const TextStyle(color: Colors.white, fontSize: 15),
//         cursorColor: Colors.white,
//         decoration: InputDecoration(
//           hintText: widget.hint,
//           hintStyle: TextStyle(color: Colors.white.withOpacity(0.2), fontSize: 14),
//           contentPadding: const EdgeInsets.all(18),
//           border: InputBorder.none,
//         ),
//       ),
//     );
//   }
// }

// class _SectionLabel extends StatelessWidget {
//   final String label;
//   const _SectionLabel({required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         CustomPaint(
//           size: const Size(28, 4),
//           painter: _TaperedDashPainter(),
//         ),
//         const SizedBox(width: 10),
//         Text(
//           label,
//           style: TextStyle(
//             color: Colors.white.withOpacity(0.4),
//             fontSize: 12,
//             fontWeight: FontWeight.w800,
//             letterSpacing: 1.5,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _TaperedDashPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..shader = const LinearGradient(
//         colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
//       ).createShader(Offset.zero & size)
//       ..style = PaintingStyle.fill;

//     final Path path = Path()
//       ..moveTo(0, 0)
//       ..lineTo(0, size.height)
//       ..lineTo(size.width, size.height / 2)
//       ..close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/core/app_router.dart';
import 'package:servicesplatform/features/web/presentation/common/footer_section.dart';
import 'package:servicesplatform/features/web/presentation/home/contact_section.dart';
import 'package:servicesplatform/features/web/presentation/home/hero_section.dart';
// Import the file where your ContactSection widget lives
import 'package:servicesplatform/features/web/widgets/top_nav_bar.dart';

import '../../../../core/bootstrap/bloc/app_bootstrap_bloc.dart';
import '../../../../core/bootstrap/bloc/app_bootstrap_state.dart';
import '../../../../core/hero/hero_mapper.dart';
import '../home/custom_shimmer.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // ─── HERO SECTION (From Bloc) ───
                BlocBuilder<AppBootstrapBloc, AppBootstrapState>(
                  builder: (context, state) {
                    if (state.status == AppBootstrapStatus.loading) {
                      return const AdaptiveShimmer(layout: ShimmerLayout.hero);
                    }
                    if (state.status == AppBootstrapStatus.success) {
                      final data = state.data!;
                      final hero = data.heroes.firstWhere(
                        (h) => h.key == 'contact' && h.isActive,
                        orElse: () => data.heroes.first,
                      );

                      return HeroSection(
                        title: hero.headingText,
                        subtitle: hero.subHeadingText,
                        imagePath: resolveAssetUrl(hero.assetUrl),
                        gradientText: hero.gradientText,
                        showGradient: hero.gradientText != null,
                        isOverlayMode: true,
                        contentAlignment: hero.isContentLeft
                            ? HeroContentAlignment.left
                            : hero.isContentRight
                                ? HeroContentAlignment.right
                                : HeroContentAlignment.center,
                      );
                    }
                    return const SizedBox(height: 100);
                  },
                ),

                // ─── CONTACT FORM SECTION (Your separate file) ───
                const ContactSection(),

                // ─── FOOTER ───
                const FooterSection(),
              ],
            ),
          ),
          
          // ─── NAV BAR ───
          TopNavBar(
            activeIndex: 5,
            onHome: () => context.go(AppRouter.home),
            onDesigns: () => context.go(AppRouter.home),
            onAbout: () => context.push(AppRouter.aboutUs),
            onTestimonials: () => context.go(AppRouter.home),
            onBlog: () => context.push(AppRouter.blog),
            onContact: () {},
          ),
        ],
      ),
    );
  }
}