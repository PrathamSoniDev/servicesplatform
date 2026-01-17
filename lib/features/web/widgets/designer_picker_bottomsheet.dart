import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/widgets/custom_category_tab.dart';
import 'package:servicesplatform/features/web/widgets/design_lux_card.dart';

// --- IMPORTS FOR THE NEW CARD AND MODEL ---
import '../../../models/design_item_models.dart';

class DesignPickerBottomSheet extends StatefulWidget {
  const DesignPickerBottomSheet({super.key});

  @override
  State<DesignPickerBottomSheet> createState() =>
      _DesignPickerBottomSheetState();
}

class _DesignPickerBottomSheetState extends State<DesignPickerBottomSheet> {
  final TextEditingController _searchController = TextEditingController();

  /// 🔁 Reactive state
  final ValueNotifier<String> _selectedCategoryNotifier =
      ValueNotifier<String>("All");

  final ValueNotifier<String> _searchQueryNotifier =
      ValueNotifier<String>("");

  final List<String> _categories = [
    "All",
    "Medical",
    "Finance",
    "Health & Wellness",
    "Portfolio",
    "Ecommerce",
  ];

  /// ✅ Updated Mock Data using DesignItem Model
  final List<DesignItem> _allDesigns = [
    DesignItem(
      id: "1",
      categoryId: "cat1",
      categoryName: "Medical",
      title: "Medical Portal",
      subtitle: "Comprehensive healthcare dashboard for providers",
      bannerImage: "https://images.unsplash.com/photo-1576091160550-2173dba999ef?q=80&w=2070",
      images: [],
      likesCount: 120,
      viewsCount: 1500,
      colors: ["#4A90E2"],
      fonts: "Roboto",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    DesignItem(
      id: "2",
      categoryId: "cat2",
      categoryName: "Finance",
      title: "Fintech App",
      subtitle: "Modern banking and crypto tracking interface",
      bannerImage: "https://images.unsplash.com/photo-1551288049-bebda4e38f71?q=80&w=2070",
      images: [],
      likesCount: 85,
      viewsCount: 920,
      colors: ["#2ECC71"],
      fonts: "Inter",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    DesignItem(
      id: "3",
      categoryId: "cat3",
      categoryName: "Health & Wellness",
      title: "Health Tracker",
      subtitle: "Personalized fitness and nutrition coaching",
      bannerImage: "https://images.unsplash.com/photo-1517836357463-d25dfeac3438?q=80&w=2070",
      images: [],
      likesCount: 210,
      viewsCount: 3400,
      colors: ["#E74C3C"],
      fonts: "Poppins",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    DesignItem(
      id: "4",
      categoryId: "cat4",
      categoryName: "Portfolio",
      title: "Creative Portfolio",
      subtitle: "Minimalist showcase for digital artists",
      bannerImage: "https://images.unsplash.com/photo-1507238691740-187a5b1d37b8?q=80&w=1955",
      images: [],
      likesCount: 340,
      viewsCount: 5600,
      colors: ["#8E2DE2"],
      fonts: "Montserrat",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _selectedCategoryNotifier.dispose();
    _searchQueryNotifier.dispose();
    super.dispose();
  }

  List<DesignItem> _filterDesigns(
    String selectedCategory,
    String searchQuery,
  ) {
    return _allDesigns.where((design) {
      final matchesCategory =
          selectedCategory == "All" ||
          design.categoryName == selectedCategory;

      final matchesSearch = design.title!
          .toLowerCase()
          .contains(searchQuery.toLowerCase());

      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          height: size.height * 0.85,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 14),
              _buildHeader(),
              const SizedBox(height: 20),
              _buildSearchBar(),
              const SizedBox(height: 20),

              /// ✅ CATEGORY TABS
              ValueListenableBuilder<String>(
                valueListenable: _selectedCategoryNotifier,
                builder: (_, selectedCategory, __) {
                  return CustomCategoryTabs(
                    tabs: _categories,
                    selectedTab: selectedCategory,
                    onChanged: (value) => _selectedCategoryNotifier.value = value,
                  );
                },
              ),

              const SizedBox(height: 24),

              /// ✅ GRID (Using DesignLuxuryCard)
              Expanded(
                child: ValueListenableBuilder<String>(
                  valueListenable: _searchQueryNotifier,
                  builder: (_, searchQuery, __) {
                    return ValueListenableBuilder<String>(
                      valueListenable: _selectedCategoryNotifier,
                      builder: (_, selectedCategory, __) {
                        final designs = _filterDesigns(selectedCategory, searchQuery);

                        if (designs.isEmpty) {
                          return const Center(
                            child: Text(
                              "No designs found",
                              style: TextStyle(color: Colors.white54),
                            ),
                          );
                        }

                        return GridView.builder(
                          padding: const EdgeInsets.only(bottom: 40),
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 450,
                            mainAxisExtent: 300, // Adjusted for Luxury Card height
                            crossAxisSpacing: 24,
                            mainAxisSpacing: 24,
                          ),
                          itemCount: designs.length,
                          itemBuilder: (context, index) {
                            final item = designs[index];
                            return DesignLuxuryCard(
                              item: item,
                              onTap: () => Navigator.pop(context, item),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Select a Design",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close, color: Colors.white70),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: Colors.white),
        onChanged: (val) => _searchQueryNotifier.value = val,
        decoration: InputDecoration(
          hintText: "Search designs...",
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
          prefixIcon: const Icon(Icons.search, color: Colors.white54),
          border: InputBorder.none,
        ),
      ),
    );
  }
}