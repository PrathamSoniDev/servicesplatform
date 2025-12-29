import 'package:flutter/material.dart';

class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 800;

    return Container(
      color: Colors.black,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 1. Purple Glow Background (Top Right)
          Positioned(
            top: -50,
            right: 150,
            child: Opacity(
              opacity: 0.6,
              child: Image.asset(
                "assets/images/about_small_ring.png", // Reusing your existing ring asset
                width: 400,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24 : width * 0.1,
              vertical: 100,
            ),
            child: Column(
              children: [
                // 2. Header Section
                const Text(
                  "Our Proven Process :\nDelivering Excellence at Every Step",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: 800,
                  child: Text(
                    "Great results don't happen by accident. At Siri Solutions, we follow a carefully crafted approach that blends expertise with collaboration to deliver IT solutions that drive real business impact.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                ),
                const SizedBox(height: 80),

                // 3. Process Cards Grid
                LayoutBuilder(
                  builder: (context, constraints) {
                    return GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: isMobile ? 1 : 2,
                      childAspectRatio:
                          isMobile
                              ? 1.3
                              : 1.5, // Adjusted aspect ratio for card content
                      mainAxisSpacing: 40,
                      crossAxisSpacing: 40,
                      children: _buildProcessSteps(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildProcessSteps() {
    return const [
      _ProcessCard(
        number: "01",
        title: "Discovery &\nConsultation",
        description:
            "We learn about your business, goals, and requirements through detailed consultation.",
        imagePath:
            "assets/images/process1.png", // Replace with your actual image paths
      ),
      _ProcessCard(
        number: "02",
        title: "Designs &\nPlannings",
        description:
            "Our team creates stunning designs that align with your brand and user expectations.",
        imagePath: "assets/images/process2.png",
      ),
      _ProcessCard(
        number: "03",
        title: "Development &\nImplementation",
        description:
            "We build your solution using cutting-edge technologies and best practices.",
        imagePath: "assets/images/process2.png",
      ),
      _ProcessCard(
        number: "04",
        title: "Testing &\nQuality Assurance",
        description:
            "Rigorous testing ensures everything works perfectly across all devices.",
        imagePath: "assets/images/process2.png",
      ),
      _ProcessCard(
        number: "05",
        title: "Deployment &\nLaunch",
        description:
            "We launch your project and ensure a smooth transition to production.",
        imagePath: "assets/images/process2.png",
      ),
      _ProcessCard(
        number: "06",
        title: "Maintenance &\nSupport",
        description:
            "Ongoing maintenance and support to keep your digital assets running smoothly.",
        imagePath: "assets/images/process2.png",
      ),
    ];
  }
}

class _ProcessCard extends StatefulWidget {
  final String number;
  final String title;
  final String description;
  final String imagePath;

  const _ProcessCard({
    required this.number,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  State<_ProcessCard> createState() => _ProcessCardState();
}

class _ProcessCardState extends State<_ProcessCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Image Area
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // Border Effect: Subtle white/purple glow on hover
                border: Border.all(
                  color:
                      isHovered
                          ? Colors.white.withValues(alpha: 0.2)
                          : Colors.transparent,
                  width: 1,
                ),
                // Shadow Effect: Deepens and glows slightly on hover
                boxShadow: [
                  BoxShadow(
                    color:
                        isHovered
                            ? Colors.purple.withValues(alpha: 0.15)
                            : Colors.black.withValues(alpha: 0.2),
                    blurRadius: isHovered ? 20 : 10,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // 1. Background Image (Upscales on Hover)
                    AnimatedScale(
                      scale: isHovered ? 1.1 : 1.0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOutQuart,
                      child: Image.asset(
                        widget.imagePath,
                        fit: BoxFit.cover,
                        // Apply the darken effect directly to the image
                        color: Colors.black.withValues(alpha: 0.2),
                        colorBlendMode: BlendMode.darken,
                      ),
                    ),

                    // 2. Gradient Overlay (Stays Static)
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.1),
                            Colors.black.withValues(alpha: 0.8),
                          ],
                        ),
                      ),
                    ),

                    // 3. Text Content (Stays Static)
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Number Badge
                          Text(
                            widget.number,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Title
                          Text(
                            widget.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Description Text Below Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              widget.description,
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
