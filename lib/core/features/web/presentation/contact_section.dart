import 'dart:ui';
import 'package:flutter/material.dart';
// Ensure this path matches where your responsive.dart file is located
import 'package:servicesplatform/core/features/web/utils/responsive.dart';
import 'package:servicesplatform/core/features/web/widgets/button.dart'; 
// import 'package:servicesplatform/core/features/web/widgets/app_button.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  // ─── CONTROLLERS ───
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  
  // ─── STATE ───
  String _selectedOption = "Do you have your own design?";
  String _selectedRole = "Select your role";

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Using your Responsive file breakpoints
    final bool isDesktop = Responsive.isDesktop(context);
    final double horizontalPadding = isDesktop ? 88 : 24;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 100, horizontal: horizontalPadding),
      color: Colors.black,
      child: Column(
        children: [
          // ─── CENTERED HEADER ───
          const Text(
            "Get in Touch",
            style: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              "Ready to start your project? Fill out the form below and we'll get back to you within 24 hours.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 60),

          // ─── FORM CONTENT ───
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Column(
              children: [
                // 1. Name & Email Row
                if (isDesktop)
                  Row(
                    children: [
                      Expanded(child: _buildGlassField("Your name", "Enter your name", _nameController)),
                      const SizedBox(width: 32),
                      Expanded(child: _buildGlassField("Your e-mail", "Enter your mail", _emailController)),
                    ],
                  )
                else ...[
                  _buildGlassField("Your name", "Enter your name", _nameController),
                  const SizedBox(height: 24),
                  _buildGlassField("Your e-mail", "Enter your mail", _emailController),
                ],

                const SizedBox(height: 32),

                // 2. Role/Options & Message Row
                if (isDesktop)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            _buildGlassDropdown("Your role"),
                            const SizedBox(height: 40),
                            _buildRadioOption("Do you have any liked design?"),
                            _buildRadioOption("Do you have your own design?"),
                            _buildRadioOption("I want a custom design"),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32),
                      Expanded(
                        child: _buildGlassField("Message *", "Tell us about your project", _messageController, maxLines: 9),
                      ),
                    ],
                  )
                else ...[
                  _buildGlassDropdown("Your role"),
                  const SizedBox(height: 32),
                  _buildGlassField("Message *", "Tell us about your project", _messageController, maxLines: 6),
                  const SizedBox(height: 32),
                  _buildRadioOption("Do you have any liked design?"),
                  _buildRadioOption("Do you have your own design?"),
                  _buildRadioOption("I want a custom design"),
                ],

                const SizedBox(height: 60),

                // 3. Submit Button
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      text: "Submit",
                      enableGlow: true,
                      color: const Color(0xFF8E2DE2), // Matches the Purple design
                      onPressed: () {
                        // Access your data here:
                        // print(_nameController.text);
                        // print(_selectedOption);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── COMPONENT BUILDERS ───

  Widget _buildGlassField(String label, String hint, TextEditingController controller, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.15)),
              ),
              child: TextField(
                controller: controller,
                maxLines: maxLines,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.2)),
                  contentPadding: const EdgeInsets.all(18),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGlassDropdown(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.15)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              dropdownColor: const Color(0xFF1A1A1A),
              value: _selectedRole,
              icon: const Icon(Icons.expand_more, color: Colors.white54),
              items: ["Select your role", "Designer", "Developer", "Client"]
                  .map((val) => DropdownMenuItem(
                        value: val,
                        child: Text(val, style: const TextStyle(color: Colors.white)),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _selectedRole = v!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRadioOption(String title) {
    bool isSelected = _selectedOption == title;
    return GestureDetector(
      onTap: () => setState(() => _selectedOption = title),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFF8E2DE2) : Colors.white30,
                  width: 2,
                ),
              ),
              child: Center(
                child: isSelected 
                  ? Container(width: 10, height: 10, decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF8E2DE2)))
                  : null,
              ),
            ),
            const SizedBox(width: 12),
            Text(title, style: TextStyle(color: isSelected ? Colors.white : Colors.white60, fontSize: 15)),
          ],
        ),
      ),
    );
  }
}