import 'package:flutter/material.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 800;

    return Container(
      width: double.infinity,
      color: Colors.black,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 1. Corrected Position of the Purple Ring (Far Left)
          Positioned(
            top: -100,
            left: 100, // Moved further left to match the cropped look in image
            child: Opacity(
              opacity: 0.8,
              child: Image.asset(
                "assets/images/about_small_ring.png",
                width: 400,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24 : 0,
              vertical: 100,
            ),
            child: Column(
              children: [
                // Header
                const Text(
                  "Our Services",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Comprehensive digital solutions tailored to your business needs.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
                ),
                const SizedBox(height: 80),

                // 2. Grid with Background Image Effect
                Stack(
                  children: [
                    // The "Tech Circle" Background Image (Positioned behind cards)
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Opacity(
                        opacity: 0.5,
                        child: Image.asset(
                          "assets/images/about_left_service.png", // Replace with your tech asset name
                          width: 500,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Opacity(
                        opacity: 0.5,
                        child: Image.asset(
                          "assets/images/about_left_service.png",
                          width: 500,
                        ),
                      ),
                    ),

                    // The Responsive Grid
                    isMobile
                        ? Column(children: _buildCards())
                        : GridView.count(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(vertical: 100),
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          childAspectRatio: 1.1,
                          mainAxisSpacing: 30,
                          crossAxisSpacing: 30,
                          children: _buildCards(),
                        ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCards() {
    return const [
      Padding(
        padding: EdgeInsets.all(40),
        child: _ServiceCard(
          title: "Web Design &\nDevelopment",
          description:
              "Custom websites built with modern technologies, responsive design, and optimized for performance.",
        ),
      ),
      Padding(
        padding: EdgeInsets.all(40),
        child: _ServiceCard(
          title: "App Design &\nDevelopment",
          description:
              "Native and cross-platform mobile applications that deliver seamless user experiences.",
        ),
      ),
      Padding(
        padding: EdgeInsets.all(40),
        child: _ServiceCard(
          title: "Digital\nMarketing",
          description:
              "SEO, social media marketing, and content strategies to grow your online presence.",
        ),
      ),
      Padding(
        padding: EdgeInsets.all(40),
        child: _ServiceCard(
          title: "Custom\nSolutions",
          description:
              "Tailored digital solutions designed specifically for your unique business needs.",
        ),
      ),
    ];
  }
}

class _ServiceCard extends StatefulWidget {
  final String title;
  final String description;

  const _ServiceCard({required this.title, required this.description});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        height: 50,
        width: 50,
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        decoration: BoxDecoration(
          // 3. Semi-transparent background to let the tech image show through slightly
          color: const Color(0xFF0A0A0A).withValues(alpha: .9),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color:
                isHovered
                    ? Colors.blue.withValues(alpha: .5)
                    : Colors.white.withValues(alpha: 0.05),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color:
                  isHovered
                      ? Colors.blue.withValues(alpha: .15)
                      : Colors.transparent,
              blurRadius: 40,
              spreadRadius: 5,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 14,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
