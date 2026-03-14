import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';
import 'package:servicesplatform/features/web/widgets/about_us_card.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double padding = Responsive.pagePadding(context);
    final bool isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      // Off-white background for the section
      color: const Color(0xFFF8F9FA), 
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 100),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isMobile 
              ? Column(
                  children: [
                    _buildRightSection(context, true),
                    const SizedBox(height: 60),
                    _buildLeftSection(context),
                  ],
                ) 
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 5, child: _buildLeftSection(context)),
                    const SizedBox(width: 80),
                    Expanded(flex: 5, child: _buildRightSection(context, false)),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildLeftSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeTransition(
          opacity: CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.4)),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "AI Changing\n",
                  style: TextStyle(
                    color: AppTheme.primaryGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.isMobile(context) ? 32 : 48,
                  ),
                ),
                TextSpan(
                  text: "Software Development",
                  style: TextStyle(
                    // Dark text for off-white background
                    color: const Color(0xFF1A1A1A), 
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.isMobile(context) ? 32 : 48,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),
        _buildAnimatedItem(context, "GenAI advances daily.", "AI's ability to write code is evolving at a dizzying pace.", true, 0.2),
        _buildAnimatedItem(context, "Integrated Ecosystems.", "Artificial intelligence is seamlessly merged into modern cloud development.", false, 0.4),
        _buildAnimatedItem(context, "Creative Freedom.", "Developers focus on architecture while AI handles the mundane syntax.", false, 0.6),
      ],
    );
  }

  Widget _buildRightSection(BuildContext context, bool isMobile) {
    return Center(
      child: SizedBox(
        height: 520,
        width: 450,
        child: Stack(
          children: [
            FadeTransition(
              opacity: CurvedAnimation(parent: _controller, curve: const Interval(0.1, 0.6)),
              child: Container(
                width: 380,
                height: 450,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  // Subtle border for light mode
                  border: Border.all(color: Colors.black.withOpacity(0.05)), 
                  image: const DecorationImage(
                    image: NetworkImage("https://images.unsplash.com/photo-1522071820081-009f0129c71c"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              right: isMobile ? 20 : 0,
              bottom: 20,
              child: AboutUsGlassCard(isMobile: isMobile, controller: _controller),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedItem(BuildContext context, String title, String desc, bool active, double start) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: _controller, curve: Interval(start, start + 0.3)),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(parent: _controller, curve: Interval(start, start + 0.3, curve: Curves.easeOut)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title, 
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: active ? AppTheme.primaryGreen : Colors.black.withOpacity(0.2),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                desc, 
                style: TextStyle(
                  fontSize: 16,
                  color: active ? Colors.black54 : Colors.black.withOpacity(0.1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}