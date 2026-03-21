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

    final double titleSize = isMobile ? 38 : (size.width * 0.06).clamp(60, 88);
    final double subTitleSize = isMobile ? 15 : 19;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: size.height,
            maxHeight: size.height,
          ),

          /// ✅ THEME
          color: AppTheme.darkBackground,

          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 60,
            vertical: size.height * 0.05,
          ),
          child: Center(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
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

                  /// SECOND LINE
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
                        const SizedBox(width: 15),

                        Icon(
                          Icons.fingerprint,
                          size: isMobile ? 60 : 110,

                          /// ✅ THEME COLOR
                          color: AppTheme.neonGreen,

                          shadows: [
                            Shadow(
                              color: AppTheme.neonGreen.withOpacity(.35),
                              blurRadius: 25,
                            ),
                          ],
                        ),

                        const SizedBox(width: 15),

                        Text(
                          "human +",
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontSize: titleSize,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(width: 15),

                        Icon(
                          Icons.auto_awesome,
                          color: AppTheme.neonGreen,
                          size: isMobile ? 50 : 90,
                          shadows: [
                            Shadow(
                              color: AppTheme.neonGreen.withOpacity(.7),
                              blurRadius: 30,
                            ),
                          ],
                        ),

                        const SizedBox(width: 15),

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

                  const SizedBox(height: 30),

                  /// SUBTITLE
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: isMobile ? 400 : 650),
                    child: Text(
                      "We help you map the skills you need, track the skills you have, and close your gaps to thrive in a GenAI world.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: subTitleSize,
                        color: Colors.white.withOpacity(.6),
                        height: 1.5,
                        letterSpacing: .3,
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  /// CTA BUTTON
                  AppButton(
                    text: "Contact Us",
                    onPressed: () {},
                    type: AppButtonType.outline,

                    /// ✅ THEME COLORS
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

                  SizedBox(height: size.height * 0.05),
                ],
              ),
            ),
          ),
        ),

        /// APP BAR
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