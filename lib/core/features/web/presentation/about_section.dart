/*import 'package:flutter/material.dart';
import 'package:servicesplatform/core/features/web/utils/responsive.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Lines (Flipped)
        Positioned.fill(
          child: Opacity(
            opacity: 0.6,
            child: Transform.flip(
              flipX: true,
              child: Image.asset(
                'assets/images/background_lines.png',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                //height: double.infinity,
                //width: double.infinity,
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          // color: Colors.black, // Ensure transparent for background
          // Add padding for better spacing on large screens
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Main Content Row
              Builder(
                builder: (context) {
                  if (Responsive.isDesktop(context)) {
                    return const _DesktopLayout();
                  }
                  return const _MobileLayout();
                },
              ),

              const SizedBox(height: 100),

              // Bottom Call to Action Banner
              Container(
                constraints: const BoxConstraints(maxWidth: 1000),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  color: const Color(
                    0xFF1A1A1A,
                  ), // Dark grey/brownish tone from image
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "We're passionate about creating digital experiences that help businesses grow and succeed in the modern world.",
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 18,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 20,
                        ),
                        side: const BorderSide(color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Learn more",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Column 1: About us
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "About us",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "We're a team of passionate developers and designers committed to delivering exceptional digital solutions that help businesses thrive online.",
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 60),

        // Column 2: How we work (Pushed down)
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 150.0,
            ), // Visual offset from design
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "How we work",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "From discovery to deployment, we follow a proven process ensuring quality, transparency, and timely delivery at every step of your project.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 60),

        // Column 3: Why choose us
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "Why choose us",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Competitive pricing, top-notch quality, dedicated support, and a commitment to your success make us the ideal partner for your digital journey.",
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ],
          ),
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
        // Block 1
        const Text(
          "About us",
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "We're a team of passionate developers and designers committed to delivering exceptional digital solutions that help businesses thrive online.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[400], fontSize: 16),
        ),
        const SizedBox(height: 48),

        // Block 2
        const Text(
          "How we work",
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "From discovery to deployment, we follow a proven process ensuring quality, transparency, and timely delivery at every step of your project.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[400], fontSize: 16),
        ),
        const SizedBox(height: 48),

        // Block 3
        const Text(
          "Why choose us",
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Competitive pricing, top-notch quality, dedicated support, and a commitment to your success make us the ideal partner for your digital journey.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[400], fontSize: 16),
        ),
      ],
    );
  }
}*/
import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      color: Colors.black,
      child: const Center(
        child: Text(
          "ABOUT",
          style: TextStyle(
            color: Colors.white,
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
