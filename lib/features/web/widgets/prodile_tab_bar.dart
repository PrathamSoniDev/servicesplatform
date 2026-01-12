import 'dart:ui';
import 'package:flutter/material.dart';

class ProfileTabBar extends StatelessWidget {
  final int selectedIndex;
  final List<String> tabs;
  final Function(int) onTabSelected;

  const ProfileTabBar({
    super.key,
    required this.selectedIndex,
    required this.tabs,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        height: 60, // Slightly taller for better touch targets and luxury feel
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: const Color(0xFF121212).withOpacity(0.8),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.08),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            // 🔹 1. ANIMATED BACKGROUND SLIDER
            AnimatedAlign(
              duration: const Duration(milliseconds: 350),
              curve: Curves.fastOutSlowIn,
              alignment: Alignment(
                -1 + (selectedIndex * (2 / (tabs.length - 1))),
                0,
              ),
              child: FractionallySizedBox(
                widthFactor: 1 / tabs.length,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blueAccent.withOpacity(0.9),
                        const Color(0xFF0052D4), // Deep premium blue
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 🔹 2. TAB ITEMS
            Row(
              children: List.generate(tabs.length, (index) {
                final bool isSelected = selectedIndex == index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => onTabSelected(index),
                    behavior: HitTestBehavior.opaque,
                    child: Center(
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[500],
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: 0.5,
                        ),
                        child: Text(tabs[index].toUpperCase()),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}