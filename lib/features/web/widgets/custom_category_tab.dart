import 'package:flutter/material.dart';

class CustomCategoryTabs extends StatelessWidget {
  final List<String> tabs;
  final String selectedTab;
  final ValueChanged<String> onChanged;

  // 🎨 Fully customizable
  final Color selectedBgColor;
  final Color unselectedBgColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final Color borderColor;
  final double borderRadius;
  final EdgeInsets padding;
  final TextStyle? textStyle;

  const CustomCategoryTabs({
    super.key,
    required this.tabs,
    required this.selectedTab,
    required this.onChanged,
    this.selectedBgColor = const Color(0xFF8E2DE2),
    this.unselectedBgColor = const Color(0x0DFFFFFF),
    this.selectedTextColor = Colors.white,
    this.unselectedTextColor = Colors.white70,
    this.borderColor = const Color(0x1AFFFFFF),
    this.borderRadius = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tabs.map((tab) {
          final bool isSelected = tab == selectedTab;

          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => onChanged(tab),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: padding,
                decoration: BoxDecoration(
                  color: isSelected ? selectedBgColor : unselectedBgColor,
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(color: borderColor),
                ),
                child: Text(
                  tab,
                  style: textStyle ??
                      TextStyle(
                        color:
                            isSelected ? selectedTextColor : unselectedTextColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
