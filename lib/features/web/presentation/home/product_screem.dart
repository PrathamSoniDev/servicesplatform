import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/widgets/product_card.dart';
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
    return Container(
      width: double.infinity,
      // Off-white background (very light grey/blue tint for a modern look)
      color: const Color(0xFFF8F9FB), 
      padding: const EdgeInsets.symmetric(vertical: 100),
      child: Column(
        children: [
          const Text(
            "Choose Your Adventure",
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1D1D1F), // Dark charcoal/black text
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "We build elite tech teams for companies\nand enhance developer skills.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54, // Soft grey text
              fontSize: 18,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 80),
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