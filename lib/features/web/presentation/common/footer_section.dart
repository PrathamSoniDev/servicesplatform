import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/responsive.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return const _DesktopFooter();
    }
    return const _MobileFooter();
  }
}

class _DesktopFooter extends StatelessWidget {
  const _DesktopFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.black,
        // Gradient glow effect at bottom left
        gradient: RadialGradient(
          center: Alignment.bottomLeft,
          radius: 1.6,
          colors: [
            Color(0xFF6020C0), // Slightly adjusted purple
            Colors.black,
          ],
          stops: [0.0, 0.6],
        ),
      ),
      padding: const EdgeInsets.only(top: 80, bottom: 40, left: 80, right: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Column 1: Links
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FooterLink("Explore designs"),
                  _FooterLink("About us"),
                  _FooterLink("Contact us"),
                ],
              ),

              // Column 2: Links
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FooterLink("Blogs"),
                  _FooterLink("Terms & Policy"),
                  _FooterLink("Help & Support"),
                ],
              ),

              // Column 3: Subscribe
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Subscribe to get updates on our latest designs\nand offers.",
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Subscribe Input
                  Container(
                    width: 350,
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 4,
                      top: 4,
                      bottom: 4,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white24),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Enter your email-id",
                              hintStyle: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white10,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 14,
                            ),
                            side: const BorderSide(color: Colors.white12),
                          ),
                          child: Text(
                            "Subscribe now",
                            style: GoogleFonts.outfit(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 100),

          // Bottom Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Follow us on",
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 20),
                  _SocialIcon(
                    Icons.code,
                  ), // GitHub (using generic if font_awesome not added)
                  const SizedBox(width: 16),
                  _SocialIcon(Icons.close), // X
                  const SizedBox(width: 16),
                  _SocialIcon(Icons.work), // LinkedIn
                  const SizedBox(width: 16),
                  _SocialIcon(Icons.facebook), // Facebook
                  const SizedBox(width: 16),
                  _SocialIcon(Icons.camera_alt), // Instagram
                ],
              ),

              Text(
                "© 2025 Sourcume. All rights reserved",
                style: GoogleFonts.outfit(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MobileFooter extends StatelessWidget {
  const _MobileFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.black,
        gradient: RadialGradient(
          center: Alignment.bottomLeft,
          radius: 1.2,
          colors: [Color(0xFF6020C0), Colors.black],
          stops: [0.0, 0.6],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Subscribe to get updates on our latest designs and offers.",
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Enter your email-id",
              hintStyle: TextStyle(color: Colors.grey[600]),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.white24),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.white),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.white12,
                  ),
                  child: const Text(
                    "Subscribe",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _FooterLink("Explore designs"),
                    _FooterLink("About us"),
                    _FooterLink("Contact us"),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _FooterLink("Blogs"),
                    _FooterLink("Terms & Policy"),
                    _FooterLink("Help & Support"),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),

          Text(
            "Follow us on",
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _SocialIcon(Icons.code),
              const SizedBox(width: 16),
              _SocialIcon(Icons.close),
              const SizedBox(width: 16),
              _SocialIcon(Icons.work),
              const SizedBox(width: 16),
              _SocialIcon(Icons.facebook),
              const SizedBox(width: 16),
              _SocialIcon(Icons.camera_alt),
            ],
          ),

          const SizedBox(height: 40),
          Text(
            "© 2025 Sourcume. All rights reserved",
            style: GoogleFonts.outfit(color: Colors.white70, fontSize: 13),
          ),
        ],
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
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () {},
        child: Text(
          text,
          style: GoogleFonts.outfit(color: Colors.grey[300], fontSize: 16),
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
    return Icon(icon, color: Colors.white, size: 24);
  }
}
