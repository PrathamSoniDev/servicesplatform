import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/responsive.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Lines
        Positioned.fill(
          child: Opacity(
            opacity: 0.6,
            child: Transform.flip(
              flipX: true,
              child: Image.asset(
                'assets/images/background_lines.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: 100,
            horizontal: Responsive.isDesktop(context) ? 80 : 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Builder(
                builder: (context) {
                  if (Responsive.isDesktop(context)) {
                    return const _DesktopLayout();
                  }
                  return const _MobileLayout();
                },
              ),
              const SizedBox(height: 100),

              // Bottom CTA
              Container(
                constraints: const BoxConstraints(maxWidth: double.infinity),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 30,
                ),

                decoration: BoxDecoration(
                  color: const Color(0xFF52188E), // Deep purple from image
                  borderRadius: BorderRadius.circular(100), // Pill shape
                ),
                child:
                    Responsive.isDesktop(context)
                        ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "We're passionate about creating digital experiences that help businesses \ngrow and succeed in the modern world.", // Added newline to match image roughly
                                textAlign: TextAlign.left,
                                style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  height: 1.4,
                                ),
                              ),
                            ),
                            const SizedBox(width: 40),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.white,
                                  shadowColor: Colors.transparent,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 22,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text(
                                  "Learn more",
                                  style: GoogleFonts.outfit(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                        : Column(
                          children: [
                            Text(
                              "We're passionate about creating digital experiences that help businesses grow.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(height: 30),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.white,
                                  shadowColor: Colors.transparent,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 20,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text(
                                  "Learn more",
                                  style: GoogleFonts.outfit(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. About Us (Text Left, Image Right)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: _TextBlock(
                title: "About us",
                description:
                    "We're a team of passionate developers \n and designers committed to delivering \n exceptional digital solutions that help \n businesses thrive online.",
                align: CrossAxisAlignment.start,
              ),
            ),
            const SizedBox(width: 60),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/about_us.png',
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 120),

        // 2. Why Choose Us (Image Left, Text Right)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/why_choose_us.png',
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 60),
            Expanded(
              child: _TextBlock(
                title: "Why choose us",
                description:
                    "Competitive pricing, top-notch quality,\n dedicated support, and a commitment \n to your success make us the ideal \n partner for your digital journey.",
                align: CrossAxisAlignment.start,
              ),
            ),
          ],
        ),
        const SizedBox(height: 120),

        // 3. How We Work (Text Left, Image Right)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: _TextBlock(
                title: "How we work",
                description:
                    "From discovery to deployment, we \n follow a proven process ensuring \n quality, transparency, and timely \n delivery at every step of your project.",
                align: CrossAxisAlignment.start,
              ),
            ),
            const SizedBox(width: 60),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/how_we_work.png',
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. About Us
        _TextBlock(
          title: "About us",
          description:
              "We're a team of passionate developers and designers committed to delivering exceptional digital solutions that help businesses thrive online.",
          align: CrossAxisAlignment.center,
        ),
        const SizedBox(height: 20),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset('assets/images/about_us.png', fit: BoxFit.cover),
        ),
        const SizedBox(height: 80),

        // 2. Why Choose Us
        _TextBlock(
          title: "Why choose us",
          description:
              "Competitive pricing, top-notch quality, dedicated support, and a commitment to your success make us the ideal partner for your digital journey.",
          align: CrossAxisAlignment.center,
        ),
        const SizedBox(height: 20),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/images/why_choose_us.png',
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 80),

        // 3. How We Work
        _TextBlock(
          title: "How we work",
          description:
              "From discovery to deployment, we follow a proven process ensuring quality, transparency, and timely delivery at every step of your project.",
          align: CrossAxisAlignment.center,
        ),
        const SizedBox(height: 20),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/images/how_we_work.png',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

class _TextBlock extends StatelessWidget {
  final String title;
  final String description;
  final CrossAxisAlignment align;

  const _TextBlock({
    required this.title,
    required this.description,
    this.align = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: align,
      children: [
        Text(
          title,
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
          textAlign:
              align == CrossAxisAlignment.center
                  ? TextAlign.center
                  : TextAlign.left,
        ),
        const SizedBox(height: 16),
        Text(
          description,
          style: GoogleFonts.outfit(
            color: Colors.grey[400],
            fontSize: 18,
            height: 1.6,
          ),
          textAlign:
              align == CrossAxisAlignment.center
                  ? TextAlign.center
                  : TextAlign.left,
        ),
      ],
    );
  }
}
