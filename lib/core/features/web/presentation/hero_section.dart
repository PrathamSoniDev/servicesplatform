import 'package:flutter/material.dart';
import 'package:servicesplatform/core/features/web/utils/responsive.dart';
import 'package:servicesplatform/core/features/web/utils/app_theme.dart';
import 'package:servicesplatform/core/features/web/widgets/button.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    final double heroHeight = isMobile ? 600 : 700;
    final double jellySize = isMobile
        ? 420
        : isTablet
            ? 600
            : 780;

    final double titleFontSize = isMobile
        ? 36
        : isTablet
            ? 46
            : 54;

    return Container(
      height: heroHeight,
      width: double.infinity,
      color: Colors.black,
      child: Stack(
        alignment: Alignment.center,
        children: [
        
          Container(
            width: jellySize * 1.4,
            height: jellySize * 1.4,
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Color(0x662E004F),
                  Colors.transparent,
                ],
                radius: 0.55,
              ),
            ),
          ),

         
          Transform.translate(
            offset: const Offset(0, -30),
            child: SizedBox(
              width: jellySize,
              height: jellySize,
              child: Image.asset(
                'assets/gif/jelly.gif',
                fit: BoxFit.contain,
              ),
            ),
          ),

          
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: isMobile ? 20 : 35),

              // LINE 1
              Text(
                "Your Digital Journey",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontSize: titleFontSize),
              ),

              const SizedBox(height: 4),

              // LINE 2 (GRADIENT)
              ShaderMask(
                shaderCallback: (bounds) {
                  return const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFFE6D7FF),
                      Color(0xFF8B5CF6),
                    ],
                  ).createShader(bounds);
                },
                child: Text(
                  "Starts Here",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(
                        fontSize: titleFontSize,
                        color: Colors.white,
                      ),
                ),
              ),

              SizedBox(height: isMobile ? 80 : 150),

              // SUBTITLE
              Text(
                "Unlock bespoke web & app services at unbeatable prices",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white60),
              ),

              const SizedBox(height: 26),

              //  BUTTONS 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton(
                    text: "View Designs",
                    onPressed: () {},
                    color: AppTheme.primary,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 26 : 36,
                      vertical: isMobile ? 14 : 18,
                    ),
                    enableGlow: true,
                  ),

                  const SizedBox(width: 18),

                  AppButton(
                    text: "Book Us →",
                    type: AppButtonType.outline,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 26 : 36,
                      vertical: isMobile ? 14 : 18,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
