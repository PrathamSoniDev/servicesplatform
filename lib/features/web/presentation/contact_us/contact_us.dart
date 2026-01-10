import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:servicesplatform/core/app_router.dart';
import 'package:servicesplatform/features/web/presentation/common/footer_section.dart';
import 'package:servicesplatform/features/web/presentation/home/hero_section.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';
import 'package:servicesplatform/features/web/widgets/top_nav_bar.dart';
import 'package:servicesplatform/features/web/widgets/button.dart'; 

import '../../../../core/bootstrap/bloc/app_bootstrap_bloc.dart';
import '../../../../core/bootstrap/bloc/app_bootstrap_state.dart';
import '../../../../core/hero/hero_mapper.dart';
import '../home/custom_shimmer.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  // ─── CONTROLLERS ───
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // ─── STATE NOTIFIERS ───
  final ValueNotifier<String> _selectedRoleNotifier = ValueNotifier("Founder");
  final ValueNotifier<String> _selectedOptionNotifier = ValueNotifier("I want a custom design");

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    _selectedRoleNotifier.dispose();
    _selectedOptionNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // 1. DYNAMIC HERO SECTION
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

                // 2. THE MODERN CONTACT FORM
                _buildModernFormSection(context),

                const FooterSection(),
              ],
            ),
          ),

          // 3. NAVIGATION
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

  Widget _buildModernFormSection(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    final double horizontalPadding = MediaQuery.of(context).size.width * (isDesktop ? 0.08 : 0.05);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 80, horizontal: horizontalPadding),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionLabel(label: "I AM A..."),
              const SizedBox(height: 16),
              _buildProfessionalRoleSelector(),

              const SizedBox(height: 48),

              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _SectionLabel(label: "YOUR NAME"),
                          const SizedBox(height: 10),
                          _buildGlassField("Full Name", "Enter your name", _nameController),
                          const SizedBox(height: 32),
                          const _SectionLabel(label: "PROJECT STATUS"),
                          const SizedBox(height: 12),
                          _buildRadioOption("Do you have any liked design?"),
                          _buildRadioOption("Do you have your own design?"),
                          _buildRadioOption("I want a custom design"),
                        ],
                      ),
                    ),
                    const SizedBox(width: 48),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _SectionLabel(label: "YOUR E-MAIL"),
                          const SizedBox(height: 10),
                          _buildGlassField("Email Address", "Enter your email", _emailController),
                          const SizedBox(height: 32),
                          const _SectionLabel(label: "MESSAGE *"),
                          const SizedBox(height: 10),
                          _buildGlassField(
                            "Message",
                            "Tell us about your project details...",
                            _messageController,
                            maxLines: 7,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _SectionLabel(label: "YOUR NAME"),
                    const SizedBox(height: 8),
                    _buildGlassField("Full Name", "Enter your name", _nameController),
                    const SizedBox(height: 24),
                    const _SectionLabel(label: "YOUR E-MAIL"),
                    const SizedBox(height: 8),
                    _buildGlassField("Email Address", "Enter your email", _emailController),
                    const SizedBox(height: 24),
                    const _SectionLabel(label: "PROJECT STATUS"),
                    const SizedBox(height: 8),
                    _buildRadioOption("Do you have any liked design?"),
                    _buildRadioOption("Do you have your own design?"),
                    _buildRadioOption("I want a custom design"),
                    const SizedBox(height: 24),
                    const _SectionLabel(label: "MESSAGE *"),
                    const SizedBox(height: 8),
                    _buildGlassField("Message", "Tell us about your project", _messageController, maxLines: 5),
                  ],
                ),

              const SizedBox(height: 60),

              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: AppButton(
                    text: "Send Message",
                    enableGlow: true,
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfessionalRoleSelector() {
    final roles = ["Founder", "Product Designer", "Developer", "Other"];
    return ValueListenableBuilder<String>(
      valueListenable: _selectedRoleNotifier,
      builder: (context, selected, _) {
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: roles.map((role) {
            final isSelected = selected == role;
            return GestureDetector(
              onTap: () => _selectedRoleNotifier.value = role,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF8E2DE2) : Colors.white.withOpacity(0.03),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF8E2DE2) : Colors.white.withOpacity(0.08),
                    width: 1,
                  ),
                ),
                child: Text(
                  role,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.white54,
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildGlassField(String label, String hint, TextEditingController controller, {int maxLines = 1}) {
    return _AnimatedInputField(
      controller: controller,
      hint: hint,
      maxLines: maxLines,
    );
  }

  Widget _buildRadioOption(String title) {
    return ValueListenableBuilder<String>(
      valueListenable: _selectedOptionNotifier,
      builder: (context, selected, _) {
        final isSelected = selected == title;
        return InkWell(
          onTap: () => _selectedOptionNotifier.value = title,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? const Color(0xFF8E2DE2) : Colors.white.withOpacity(0.2),
                      width: isSelected ? 6 : 1.5,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.white60,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ─── INTERNAL HELPER WIDGETS ───

class _AnimatedInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;

  const _AnimatedInputField({
    required this.controller,
    required this.hint,
    required this.maxLines,
  });

  @override
  State<_AnimatedInputField> createState() => _AnimatedInputFieldState();
}

class _AnimatedInputFieldState extends State<_AnimatedInputField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final Color focusGrey = Colors.white.withOpacity(0.4);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(_isFocused ? 0.05 : 0.02),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _isFocused ? focusGrey : Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Focus(
        onFocusChange: (focus) => setState(() => _isFocused = focus),
        child: TextField(
          controller: widget.controller,
          maxLines: widget.maxLines,
          style: const TextStyle(color: Colors.white, fontSize: 15),
          cursorColor: focusGrey, 
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.2), fontSize: 14),
            contentPadding: const EdgeInsets.all(18),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // UPDATED: Tapered Pointed Dash
        CustomPaint(
          size: const Size(28, 4), // Width 28, Height 4
          painter: _TaperedDashPainter(),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.4), 
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}

/// Custom Painter to draw a dash that tapers to a point on the right
class _TaperedDashPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Offset.zero & size)
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..moveTo(0, 0) // Top left
      ..lineTo(0, size.height) // Bottom left
      ..lineTo(size.width, size.height / 2) // Middle right (Point)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}