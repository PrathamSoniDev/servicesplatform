import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({super.key});

  /// 👉 DUMMY DATA (replace later with API)
  List<Map<String, String>> get products => [
        {
          'title': 'Developer Services',
          'type': 'developer',
          'desc': 'Web, App & Backend Development',
        },
        {
          'title': 'Design Services',
          'type': 'design',
          'desc': 'UI/UX, Branding & Graphics',
        },
        {
          'title': 'Marketing Services',
          'type': 'marketing',
          'desc': 'SEO, Ads & Growth',
        },
        {
          'title': 'Consulting',
          'type': 'consulting',
          'desc': 'Business & Tech Consulting',
        },
      ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    /// 👉 Responsive columns
    int crossAxisCount = 2;
    if (width > 1200) {
      crossAxisCount = 4;
    } else if (width > 800) {
      crossAxisCount = 3;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (context, index) {
            final product = products[index];

            return _ProductCard(
              title: product['title']!,
              desc: product['desc']!,
              onTap: () {
                context.go('/product/detail/${product['type']}');
              },
            );
          },
        ),
      ),
    );
  }
}

class _ProductCard extends StatefulWidget {
  final String title;
  final String desc;
  final VoidCallback onTap;

  const _ProductCard({
    required this.title,
    required this.desc,
    required this.onTap,
  });

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),

      child: GestureDetector(
        onTap: widget.onTap,

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              if (isHover)
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              else
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
            ],
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ICON
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.widgets, color: Colors.blue),
              ),

              const SizedBox(height: 16),

              /// TITLE
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              /// DESCRIPTION
              Text(
                widget.desc,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),

              const Spacer(),

              /// ARROW
              Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  Icons.arrow_forward,
                  color: isHover ? Colors.blue : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}