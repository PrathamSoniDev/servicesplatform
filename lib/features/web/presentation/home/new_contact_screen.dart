import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import '../../utils/responsive.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    final isMobile = Responsive.isMobile(context);
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height, // Strictly no scrolling
      decoration: const BoxDecoration(color: AppTheme.darkBackground),
      child: Stack(
        children: [
          /// 1. WATERMARK BACKGROUND (SELLTECH)
          Positioned(
            bottom: -size.height * 0.02,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Colors.white, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds),
                child: Text(
                  "SELLTECH",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? size.width * 0.22 : size.width * 0.18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -size.width * 0.01,
                    height: 0.8,
                  ),
                ),
              ),
            ),
          ),

          /// 2. MAIN INTERFACE
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: padding,
              vertical: isMobile ? 20 : 40,
            ),
            child: isMobile 
                ? _buildMobileLayout(context, size) 
                : _buildDesktopLayout(context, size),
          ),
        ],
      ),
    );
  }

  /// DESKTOP LAYOUT
  Widget _buildDesktopLayout(BuildContext context, Size size) {
    return Row(
      children: [
        /// LEFT SIDE: Branding & Links
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBrandHeader(context),
              const SizedBox(height: 40),
              _buildFooterGrid(),
              const SizedBox(height: 50),
              _buildSocialRow(),
            ],
          ),
        ),

        const SizedBox(width: 50),

        /// RIGHT SIDE: Form lifted to stay above Selltech
        Expanded(
          flex: 1,
          child: Align(
            alignment: const Alignment(0, -0.3),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: _ContactFormCard(isMobile: false),
            ),
          ),
        ),
      ],
    );
  }

  /// MOBILE LAYOUT (Compact, terms/footer removed)
  Widget _buildMobileLayout(BuildContext context, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center, // Keeps form centered
      children: [
        _buildBrandHeader(context, center: true),
        const SizedBox(height: 30),
        _ContactFormCard(isMobile: true),
        const SizedBox(height: 30),
        _buildSocialRow(center: true),
      ],
    );
  }

  Widget _buildBrandHeader(BuildContext context, {bool center = false}) {
    return Column(
      crossAxisAlignment: center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        const Text(
          "NEXT-GEN SOLUTIONS",
          style: TextStyle(
            color: Colors.blueAccent,
            letterSpacing: 4,
            fontWeight: FontWeight.w800,
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "SELLTECH",
          style: TextStyle(
            color: Colors.white,
            fontSize: 38,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "Innovating digital commerce.",
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  Widget _buildFooterGrid() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _FooterLink("Products"),
            _FooterLink("About us"),
            _FooterLink("Career"),
            _FooterLink("Blogs"),
          ],
        ),
        const SizedBox(width: 40),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _FooterLink("Resources"),
            _FooterLink("Blogs"),
            _FooterLink("Terms & Policy"),
            _FooterLink("Help & Support"),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialRow({bool center = false}) {
    return Row(
      mainAxisAlignment: center ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: const [
        _SocialIcon(Icons.code),
        SizedBox(width: 20),
        _SocialIcon(Icons.alternate_email),
        SizedBox(width: 20),
        _SocialIcon(Icons.link),
        SizedBox(width: 20),
        _SocialIcon(Icons.camera_alt),
      ],
    );
  }
}

class _ContactFormCard extends StatelessWidget {
  final bool isMobile;
  const _ContactFormCard({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: EdgeInsets.all(isMobile ? 24 : 32),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Inquire Now",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField(Icons.person_outline, "Full Name"),
              const SizedBox(height: 12),
              _buildTextField(Icons.email_outlined, "Email Address"),
              const SizedBox(height: 12),
              _buildTextField(Icons.phone_outlined, "Phone Number"),
              const SizedBox(height: 24),
              
              Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [Colors.white, Color(0xFFF0F0F0)],
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "SUBMIT ENQUIRY",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              // Terms & Privacy removed for Mobile to save space
              if (!isMobile) ...[
                const SizedBox(height: 14),
                const Center(
                  child: Text(
                    "By submitting, you agree to our Terms & Privacy.",
                    style: TextStyle(color: Colors.white24, fontSize: 9),
                  ),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(IconData icon, String hint) {
    return SizedBox(
      height: 48,
      child: TextField(
        style: const TextStyle(color: Colors.white, fontSize: 13),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white38, size: 16),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white24, fontSize: 13),
          filled: true,
          fillColor: Colors.white.withOpacity(0.02),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white38),
          ),
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String text;
  const _FooterLink(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white.withOpacity(0.5),
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  const _SocialIcon(this.icon);

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: Colors.white.withOpacity(0.7),
      size: 16,
    );
  }
}