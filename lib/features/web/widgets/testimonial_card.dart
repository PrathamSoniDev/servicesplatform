import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../models/testimonial_model.dart';
import '../utils/app_theme.dart';
import 'rating_stars.dart';

class TestimonialCard extends StatelessWidget {
  final TestimonialModel data;

  const TestimonialCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // Determine if the screen is small to adjust width logic if necessary
    final double cardWidth =
        MediaQuery.of(context).size.width > 1024
            ? MediaQuery.of(context).size.width / 3.5
            : MediaQuery.of(context).size.width * 0.8;

    return SizedBox(
      width: cardWidth,
      height: 250, // Increased slightly to accommodate glass spacing
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ─── THE GLASS BODY ───
          ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: BackdropFilter(
              // sigmaX and Y determine the "bluriness" of the glass
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 20),
                decoration: BoxDecoration(
                  // Semi-transparent white background
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(28),
                  // Border mimics light hitting the edge of glass
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1.5,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.15),
                      Colors.white.withOpacity(0.05),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Header (Name, Role, Rating) ---
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 56), // Placeholder for the avatar
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                data.role,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Rating component
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            RatingStars(rating: data.rating),
                            const SizedBox(height: 4),
                            Text(
                              "${data.rating.toStringAsFixed(1)}/5",
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // --- The Quote ---
                    Expanded(
                      child: Text(
                        "“${data.message}”",
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color: Colors.white.withOpacity(0.9),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ─── FLOATING AVATAR ───
          Positioned(
            top: -22,
            left: 24,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // Soft glow shadow behind avatar
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
                border: Border.all(
                  color: Colors.white.withOpacity(0.8),
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                backgroundColor: AppTheme.primary,
                child: const Icon(Icons.person, color: Colors.white, size: 28),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
