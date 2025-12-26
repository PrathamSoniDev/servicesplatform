import 'package:flutter/material.dart';
import 'package:servicesplatform/core/features/web/utils/app_theme.dart';

import '../model/testimonial_model.dart';
import 'rating_stars.dart';

class TestimonialCard extends StatelessWidget {
  final TestimonialModel data;

  const TestimonialCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 450,
      height: 230, // 🔑 fixed height like reference
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Card body
          Container(
            padding: const EdgeInsets.fromLTRB(24, 36, 24, 20),
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9), // 🔑 reference gray
              borderRadius: BorderRadius.circular(28), // 🔑 rounder corners
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 56),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            data.role,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Rating
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RatingStars(rating: data.rating),
                        const SizedBox(height: 4),
                        Text(
                          "${data.rating.toStringAsFixed(1)}/5 ratings",
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // Quote
                Text(
                  "“${data.message}”",
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.6,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          // 🔵 Avatar (reference style)
          Positioned(
            top: -22,
            left: 24,
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primary, // 🔑 purple
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: const Icon(Icons.person, color: Colors.white, size: 28),
            ),
          ),
        ],
      ),
    );
  }
}
