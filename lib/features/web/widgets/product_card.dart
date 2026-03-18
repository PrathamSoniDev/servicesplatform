import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final bool isDeveloper;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.isDeveloper,
    required this.onTap,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {

  bool hover = false;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: widget.onTap,

      child: Hero(
        tag: widget.isDeveloper ? "dev_prod" : "biz_prod",

        child: MouseRegion(
          onEnter: (_) => setState(() => hover = true),
          onExit: (_) => setState(() => hover = false),

          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),

            width: 320,
            padding: const EdgeInsets.all(28),

            decoration: BoxDecoration(
              color: const Color(0xFF111111),
              borderRadius: BorderRadius.circular(24),

              border: Border.all(color: Colors.white10),

              boxShadow: [
                if (hover)
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 25,
                    offset: const Offset(0, 12),
                  )
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Icon(
                  widget.isDeveloper
                      ? Icons.terminal
                      : Icons.business_center,
                  color: const Color(0xFF27AE60),
                  size: 40,
                ),

                const SizedBox(height: 24),

                Text(
                  widget.isDeveloper
                      ? "Developer Platform"
                      : "Business Platform",

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Explore powerful tools designed to help engineers grow and companies hire better.",
                  style: TextStyle(
                    color: Colors.white60,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  "View Details →",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}