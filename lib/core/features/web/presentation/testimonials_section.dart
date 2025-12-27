import 'package:flutter/material.dart';

import '../models/testimonial_model.dart';
import '../utils/responsive.dart';
import '../widgets/testimonial_card.dart';

class TestimonialSection extends StatefulWidget {
  const TestimonialSection({super.key});

  @override
  State<TestimonialSection> createState() => _TestimonialSectionState();
}

class _TestimonialSectionState extends State<TestimonialSection> {
  late final ScrollController _scrollController;

  static const double _cardWidth = 360;
  static const double _cardSpacing = 32;

  final testimonials = const [
    TestimonialModel(
      name: "Sara Johnson",
      role: "Creative Studios",
      message:
          "They perfectly captured our restaurant’s vibe. The online ordering system works flawlessly!",
      imageUrl: "https://randomuser.me/api/portraits/women/44.jpg",
      rating: 4.5,
    ),
    TestimonialModel(
      name: "Sara Johnson",
      role: "TechStart Inc",
      message:
          "Outstanding service from start to finish. Our new portfolio website has already generated multiple client leads.",
      imageUrl: "https://randomuser.me/api/portraits/men/32.jpg",
      rating: 4.5,
    ),
    TestimonialModel(
      name: "Sara Johnson",
      role: "TechStart Inc",
      message:
          "Outstanding service from start to finish. Our new portfolio website has already generated multiple client leads.",
      imageUrl: "https://randomuser.me/api/portraits/men/32.jpg",
      rating: 4.5,
    ),
    TestimonialModel(
      name: "Sara Johnson",
      role: "TechStart Inc",
      message:
          "Outstanding service from start to finish. Our new portfolio website has already generated multiple client leads.",
      imageUrl: "https://randomuser.me/api/portraits/men/32.jpg",
      rating: 4.5,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollBy(double offset) {
    if (!_scrollController.hasClients) return;

    final target = (_scrollController.offset + offset).clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );

    _scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 80,
        horizontal: isDesktop ? 120 : 20,
      ),
      color: Colors.black,
      child: Column(
        children: [
          const Text(
            "What our clients say",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            "Real feedback from businesses we’ve helped grow.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.grey.shade400),
          ),
          const SizedBox(height: 60),

          /// ✅ SAFE STACK (arrows inside hit-test area)
          SizedBox(
            height: 250,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ListView.separated(
                    controller: _scrollController,
                    primary: false,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: testimonials.length,
                    separatorBuilder:
                        (_, __) => const SizedBox(width: _cardSpacing),
                    itemBuilder: (_, index) {
                      return Container(
                        //width: _cardWidth,
                        padding: EdgeInsets.only(top: 30),
                        child: TestimonialCard(data: testimonials[index]),
                      );
                    },
                  ),
                ),

                if (isDesktop)
                  Positioned(
                    left: 0,
                    child: _ArrowButton(
                      icon: Icons.chevron_left,
                      onTap: () => _scrollBy(-(_cardWidth + _cardSpacing)),
                    ),
                  ),

                if (isDesktop)
                  Positioned(
                    right: 0,
                    child: _ArrowButton(
                      icon: Icons.chevron_right,
                      onTap: () => _scrollBy(_cardWidth + _cardSpacing),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _ArrowButton({required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .35),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 32),
      ),
    );
  }
}
