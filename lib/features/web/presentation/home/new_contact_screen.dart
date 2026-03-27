import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Standard SaaS horizontal padding
    const double padding = 60.0; 

    return LayoutBuilder(builder: (context, constraints) {
      final isMobile = constraints.maxWidth < 950;
      final vh = constraints.maxHeight;

      return Container(
        width: double.infinity,
        height: vh, // Locks the screen height to prevent scrolling
        color: const Color(0xFF080808),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            /// 🌌 AMBIENCE: Subtle solid-color accent (No Blur)
            Positioned(
              top: -150,
              right: -150,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // Using a very faint solid color instead of a blur
                  color: Colors.blueAccent.withOpacity(0.03),
                ),
              ),
            ),

            /// 🔥 WATERMARK: Precision anchored text
            Positioned(
              bottom: -vh * 0.08, 
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.08),
                      Colors.white.withOpacity(0.01),
                      Colors.transparent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ).createShader(bounds),
                  child: const FittedBox(
                    fit: BoxFit.cover,
                    child: Text(
                      "SELLTECH",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        letterSpacing: -15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            /// MAIN CONTENT: Scaled to fit screen height
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: padding, vertical: 40),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: SizedBox(
                        width: constraints.maxWidth - (padding * 2),
                        child: isMobile 
                            ? _buildMobileLayout(context) 
                            : _buildDesktopLayout(context),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildModernHeader(context),
              const SizedBox(height: 60),
              _buildSaaSLinks(),
              const SizedBox(height: 60),
              _buildSocialTerminal(),
            ],
          ),
        ),
        const SizedBox(width: 80),
        const Expanded(
          flex: 5,
          child: _FlatInquiryConsole(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildModernHeader(context, center: true),
        const SizedBox(height: 40),
        const _FlatInquiryConsole(),
        const SizedBox(height: 40),
        _buildSocialTerminal(center: true),
      ],
    );
  }

  Widget _buildModernHeader(BuildContext context, {bool center = false}) {
    return Column(
      crossAxisAlignment: center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(2),
          ),
          child: const Text(
            "V1.0 NEXT-GEN",
            style: TextStyle(color: Colors.blueAccent, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 2),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "Let's Build the\nFuture Together.",
          textAlign: center ? TextAlign.center : TextAlign.start,
          style: const TextStyle(color: Colors.white, fontSize: 52, fontWeight: FontWeight.w800, height: 1.05, letterSpacing: -2.5),
        ),
        const SizedBox(height: 20),
        Text(
          "Enterprise solutions for modern commerce, engineering,\nand product design. Join the digital revolution.",
          textAlign: center ? TextAlign.center : TextAlign.start,
          style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 16, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildSaaSLinks() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _LinkColumn(title: "PLATFORM", links: ["Products", "About", "Career"]),
        _LinkColumn(title: "SUPPORT", links: ["Docs", "API Status", "Help"]),
        _LinkColumn(title: "LEGAL", links: ["Privacy", "Terms", "Compliance"]),
      ],
    );
  }

  Widget _buildSocialTerminal({bool center = false}) {
    return Row(
      mainAxisAlignment: center ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        const _TerminalIcon(Icons.terminal),
        const SizedBox(width: 24),
        const _TerminalIcon(Icons.public),
        const SizedBox(width: 24),
        const _TerminalIcon(Icons.layers),
        const SizedBox(width: 24),
        const _TerminalIcon(Icons.alternate_email),
      ],
    );
  }
}

class _LinkColumn extends StatelessWidget {
  final String title;
  final List<String> links;
  const _LinkColumn({required this.title, required this.links});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        const SizedBox(height: 18),
        ...links.map((link) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(link, style: TextStyle(color: Colors.white.withOpacity(0.35), fontSize: 13)),
            )),
      ],
    );
  }
}

class _FlatInquiryConsole extends StatelessWidget {
  const _FlatInquiryConsole();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        // Solid dark background for a sharp "Console" look
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("INQUIRE", style: TextStyle(color: Colors.blueAccent, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 2)),
          const SizedBox(height: 8),
          const Text("Start a conversation", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w700)),
          const SizedBox(height: 30),
          const _ModernInput(label: "NAME", icon: Icons.person_outline),
          const SizedBox(height: 20),
          const _ModernInput(label: "WORK EMAIL", icon: Icons.alternate_email),
          const SizedBox(height: 20),
          const _ModernInput(label: "PROJECT DETAILS", icon: Icons.chat_bubble_outline, maxLines: 2),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                elevation: 0,
              ),
              onPressed: () {},
              child: const Text("SEND MESSAGE", style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0.5)),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModernInput extends StatelessWidget {
  final String label;
  final IconData icon;
  final int maxLines;
  const _ModernInput({required this.label, required this.icon, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
        const SizedBox(height: 10),
        TextField(
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            prefixIcon: Icon(icon, color: Colors.white24, size: 18),
            filled: true,
            fillColor: Colors.black.withOpacity(0.3),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.1)), borderRadius: BorderRadius.circular(4)),
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent, width: 1.5)),
          ),
        ),
      ],
    );
  }
}

class _TerminalIcon extends StatelessWidget {
  final IconData icon;
  const _TerminalIcon(this.icon);

  @override
  Widget build(BuildContext context) {
    return Icon(icon, color: Colors.white.withOpacity(0.2), size: 20);
  }
}