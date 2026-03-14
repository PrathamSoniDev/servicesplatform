import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';
import 'package:servicesplatform/features/web/widgets/product_card.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  late Animation<double> _snapAnimation;
  
  double _scrollValue = 0.0; 

  final List<Map<String, String>> productData = [
    {
      "title": "Empower Your Career",
      "desc": "Join an elite community of developers. Hone your skills with real-world GenAI projects and land your dream role in tech.",
    },
    {
      "title": "Scale Your Business",
      "desc": "Build an elite tech workforce. We help companies integrate GenAI workflows and hire the top 1% of technical talent.",
    },
  ];

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..addListener(() {
        setState(() {
          _scrollValue = _snapAnimation.value;
        });
      });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  void _handleVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _scrollValue -= details.delta.dy / 400;
      _scrollValue = _scrollValue.clamp(0.0, 1.0);
    });
  }

  void _handleVerticalDragEnd(DragEndDetails details) {
    double targetValue = _scrollValue > 0.5 ? 1.0 : 0.0;
    _snapAnimation = Tween<double>(
      begin: _scrollValue,
      end: targetValue,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.elasticOut,
    ));
    _rotationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    final isMobile = Responsive.isMobile(context);
    final screenWidth = MediaQuery.of(context).size.width;
    int activeIndex = _scrollValue > 0.5 ? 1 : 0;

    return Container(
      width: double.infinity,
      height: 800,
      color: const Color(0xFFF7F7F7),
      child: Stack(
        children: [
          // LEFT SIDE: Pure Information (Non-interfering with page scroll)
          Positioned(
            left: padding,
            top: 0,
            bottom: 0,
            child: Center(
              child: SizedBox(
                width: isMobile ? screenWidth * 0.8 : 450,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAnimatedText(productData[activeIndex]["title"]!, true),
                    const SizedBox(height: 24),
                    _buildAnimatedText(productData[activeIndex]["desc"]!, false),
                  ],
                ),
              ),
            ),
          ),

          // RIGHT SIDE: Interative Orbit Area
          // We limit the GestureDetector to the right 50% of the screen
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: isMobile ? screenWidth : screenWidth * 0.5,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent, // Allows clicks but catches drags
              onVerticalDragUpdate: _handleVerticalDragUpdate,
              onVerticalDragEnd: _handleVerticalDragEnd,
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  // The Circular Orbit Path
                  Positioned(
                    right: -150,
                    child: Container(
                      width: 600,
                      height: 600,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.borderColor.withOpacity(0.05),
                          width: 2,
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          OrbitingCard(
                            index: 0,
                            scrollValue: _scrollValue,
                            isPrimary: true,
                          ),
                          OrbitingCard(
                            index: 1,
                            scrollValue: _scrollValue,
                            isPrimary: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedText(String text, bool isTitle) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, anim) => FadeTransition(
        opacity: anim,
        child: SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(anim),
          child: child,
        ),
      ),
      child: Text(
        text,
        key: ValueKey(text),
        style: isTitle
            ? TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: AppTheme.darkBackground, letterSpacing: -1)
            : TextStyle(fontSize: 18, color: AppTheme.textSecondary, height: 1.6),
      ),
    );
  }
}