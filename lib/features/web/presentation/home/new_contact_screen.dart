import 'package:flutter/material.dart';
import '../../utils/responsive.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    final isMobile = Responsive.isMobile(context);

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Container(
        width: double.infinity,
        color: Colors.black,
        padding: EdgeInsets.symmetric(
          horizontal: padding,
          vertical: isMobile ? 40 : 80,
        ),
        child: Stack(
          children: [

            /// MAIN CONTENT
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: isMobile
                      ? _buildMobileLayout()
                      : _buildDesktopLayout(),
                ),
              ],
            ),

            /// BIG BACKGROUND BRAND TEXT
            Align(
              alignment: Alignment.bottomCenter,
              child: IgnorePointer(
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.black,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ).createShader(bounds),
                  child: Text(
                    "SELLTECH",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 110 : 220,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -6,
                      height: 0.8, // makes it touch bottom
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// DESKTOP LAYOUT
  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// LEFT COMPANY
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [

              Text(
                "SELLTECH",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),

              SizedBox(height: 8),

              Text(
                "Techworkz Pvt. Ltd.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),

              SizedBox(height: 40),

              Column(
                children: [
                  _SocialIcon(Icons.code),
                  SizedBox(height: 16),
                  _SocialIcon(Icons.alternate_email),
                  SizedBox(height: 16),
                  _SocialIcon(Icons.work),
                  SizedBox(height: 16),
                  _SocialIcon(Icons.facebook),
                  SizedBox(height: 16),
                  _SocialIcon(Icons.camera_alt),
                ],
              ),
            ],
          ),
        ),

        /// LINKS
        const Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FooterLink("Products"),
              _FooterLink("About us"),
              _FooterLink("Career"),
              _FooterLink("Blogs"),
            ],
          ),
        ),

        /// RESOURCES
        const Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FooterLink("Resources"),
              _FooterLink("Blogs"),
              _FooterLink("Terms & Policy"),
              _FooterLink("Help & Support"),
            ],
          ),
        ),

        /// SUBSCRIBE
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "Subscribe to get updates",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),

              const SizedBox(height: 20),

              Row(
                children: [

                  const Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Enter your email-id",
                        hintStyle: TextStyle(color: Colors.white38),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white24),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 20),

                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white38),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                    ),
                    onPressed: () {},
                    child: const Text("Subscribe now"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// MOBILE LAYOUT
  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [

        Text(
          "SELLTECH",
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 8),

        Text(
          "Techworkz Pvt. Ltd.",
          style: TextStyle(color: Colors.white70),
        ),

        SizedBox(height: 30),

        _FooterLink("Products"),
        _FooterLink("About us"),
        _FooterLink("Career"),
        _FooterLink("Blogs"),

        SizedBox(height: 30),

        _FooterLink("Resources"),
        _FooterLink("Terms & Policy"),
        _FooterLink("Help & Support"),

        SizedBox(height: 40),

        Text(
          "Subscribe to get updates",
          style: TextStyle(color: Colors.white),
        ),

        SizedBox(height: 20),

        TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter your email-id",
            hintStyle: TextStyle(color: Colors.white38),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white24),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String text;

  const _FooterLink(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 15,
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
      color: Colors.white70,
      size: 20,
    );
  }
}