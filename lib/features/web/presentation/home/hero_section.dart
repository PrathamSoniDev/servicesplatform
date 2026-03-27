import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';
import 'package:servicesplatform/features/web/widgets/button.dart';
import 'package:servicesplatform/features/web/widgets/custom_app_bar.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onAboutTap;
  final VoidCallback onProductTap;
  final VoidCallback onBlogTap;
  final VoidCallback onContactTap;

  const HeroSection({
    super.key,
    required this.onHomeTap,
    required this.onAboutTap,
    required this.onProductTap,
    required this.onBlogTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final size = MediaQuery.of(context).size;

    /// ✅ NEW: detect small desktop / tablet
    final isSmallDesktop = size.width < 1100 && !isMobile;

    /// ✅ FIXED FONT SCALING
    final double titleSize = isMobile
        ? 34
        : isSmallDesktop
            ? 48
            : (size.width * 0.06).clamp(60, 88);

    final double subTitleSize = isMobile ? 14 : (isSmallDesktop ? 16 : 19);

    /// ✅ IMPORTANT: AppBar height space
    const double appBarHeight = 80;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: size.height,

          color: AppTheme.darkBackground,

          /// ✅ FIX: Added top padding to avoid collision
          padding: EdgeInsets.only(
            top: appBarHeight + 20,
            left: isMobile ? 20 : 60,
            right: isMobile ? 20 : 60,
            bottom: 20,
          ),

          child: Center(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  /// TOP HEADING
                  Text(
                    "The future\nof development",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontSize: titleSize,
                          height: 1.0,
                          color: Colors.white.withOpacity(.35),
                          fontWeight: FontWeight.w600,
                          letterSpacing: -1.0,
                        ),
                  ),

                  const SizedBox(height: 15),

                  /// SECOND LINE (Responsive Safe)
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "is",
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontSize: titleSize,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(width: 10),

                        Icon(
                          Icons.fingerprint,
                          size: isMobile ? 50 : (isSmallDesktop ? 70 : 110),
                          color: AppTheme.neonGreen,
                          shadows: [
                            Shadow(
                              color: AppTheme.neonGreen.withOpacity(.35),
                              blurRadius: 25,
                            ),
                          ],
                        ),

                        const SizedBox(width: 10),

                        Text(
                          "human +",
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontSize: titleSize,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                        ),

                        const SizedBox(width: 10),

                        Icon(
                          Icons.auto_awesome,
                          color: AppTheme.neonGreen,
                          size: isMobile ? 40 : (isSmallDesktop ? 60 : 90),
                          shadows: [
                            Shadow(
                              color: AppTheme.neonGreen.withOpacity(.7),
                              blurRadius: 30,
                            ),
                          ],
                        ),

                        const SizedBox(width: 10),

                        Text(
                          "AI",
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontSize: titleSize,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// SUBTITLE
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: isMobile ? 400 : (isSmallDesktop ? 500 : 650)),
                    child: Text(
                      "We help you map the skills you need, track the skills you have, and close your gaps to thrive in a GenAI world.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: subTitleSize,
                            color: Colors.white.withOpacity(.6),
                            height: 1.5,
                          ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// CTA BUTTON
                  AppButton(
                    text: "Contact Us",
                    onPressed: () {},
                    type: AppButtonType.outline,
                    color: Colors.white,
                    textColor: Colors.white,
                    borderRadius: 10,
                    borderWidth: 1.5,
                    enableGlow: false,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 16,
                    ),
                  ),

                  SizedBox(height: size.height * 0.03),
                ],
              ),
            ),
          ),
        ),

        /// APP BAR (ON TOP)
        CustomAppBar(
          onHomeTap: onHomeTap,
          onAboutTap: onAboutTap,
          onProductTap: onProductTap,
          onBlogTap: onBlogTap,
          onContactTap: onContactTap,
        ),
      ],
    );
  }
}