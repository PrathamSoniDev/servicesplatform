import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import 'package:servicesplatform/features/web/widgets/product_card.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';
import 'product_detail_screen.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  void openProduct(BuildContext context, bool isDeveloper) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        transitionDuration: const Duration(milliseconds: 450),
        reverseTransitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (context, animation, _) {
          return FadeTransition(
            opacity: animation,
            child: ProductDetailScreen(isDeveloper: isDeveloper),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,

      /// ✅ ALWAYS WHITE BACKGROUND
      color: AppTheme.bgOffWhite, // or Colors.white

      padding: const EdgeInsets.symmetric(vertical: 100),
      child: Column(
        children: [

          /// ✅ TITLE (always dark text)
          Text(
            "Powering Developers & Businesses",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: isMobile ? 28 : 48,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1,
                  color: AppTheme.textBlack,
                ),
          ),

          const SizedBox(height: 16),

          /// ✅ SUBTITLE
          Text(
            "Whether you're a developer looking to level up your skills\nor a company building high-performance teams — we've got you covered.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: isMobile ? 14 : 18,
                  height: 1.6,
                  color: AppTheme.textGrey,
                ),
          ),

          const SizedBox(height: 60),

          /// ✅ MOBILE → Horizontal Scroll
          if (isMobile)
            SizedBox(
              height: 260,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  ProductCard(
                    isDeveloper: true,
                    onTap: () => openProduct(context, true),
                  ),
                  const SizedBox(width: 16),

                  ProductCard(
                    isDeveloper: false,
                    onTap: () => openProduct(context, false),
                  ),
                  const SizedBox(width: 16),

                  ProductCard(
                    isDeveloper: true,
                    onTap: () => openProduct(context, true),
                  ),
                ],
              ),
            )

          /// ✅ WEB / TABLET → Grid Layout
          else
            Wrap(
              spacing: 40,
              runSpacing: 40,
              alignment: WrapAlignment.center,
              children: [
                ProductCard(
                  isDeveloper: true,
                  onTap: () => openProduct(context, true),
                ),
                ProductCard(
                  isDeveloper: false,
                  onTap: () => openProduct(context, false),
                ),
                ProductCard(
                  isDeveloper: true,
                  onTap: () => openProduct(context, true),
                ),
              ],
            ),
        ],
      ),
    );
  }
}