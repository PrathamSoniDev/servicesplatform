import 'package:flutter/material.dart';

class ProfessionalRoleSelector extends StatelessWidget {
  /// The controller that holds the selected role string
  final ValueNotifier<String> controller;
  
  /// The list of roles to display
  final List<String> roles;

  const ProfessionalRoleSelector({
    super.key,
    required this.controller,
    this.roles = const ["Client", "Designer", "Developer", "Founder"],
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: controller,
      builder: (context, selected, _) {
        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: roles.map((role) {
            final isSelected = selected == role;
            return GestureDetector(
              onTap: () => controller.value = role,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20, 
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  // Purple if selected, dark glass if not
                  color: isSelected 
                      ? const Color(0xFF8E2DE2) 
                      : Colors.white.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: isSelected 
                        ? const Color(0xFF8E2DE2) 
                        : Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Text(
                  role,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.white60,
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}