// import 'dart:ui';

// import 'package:flutter/material.dart';

// import '../../utils/responsive.dart';
// import '../../widgets/button.dart';
// // Ensure this path matches where your responsive.dart file is located
// // import 'package:servicesplatform/core/features/web/widgets/app_button.dart';

// class ContactSection extends StatefulWidget {
//   const ContactSection({super.key});

//   @override
//   State<ContactSection> createState() => _ContactSectionState();
// }

// class _ContactSectionState extends State<ContactSection> {
//   // ─── CONTROLLERS ───
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _messageController = TextEditingController();

//   // ─── STATE ───
//   String _selectedOption = "Do you have your own design?";
//   String _selectedRole = "Select your role";

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _messageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Using your Responsive file breakpoints
//     final bool isDesktop = Responsive.isDesktop(context);
//     final double horizontalPadding = isDesktop ? 88 : 24;

//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(
//         vertical: 100,
//         horizontal: horizontalPadding,
//       ),
//       color: Colors.black,
//       child: Column(
//         children: [
//           // ─── CENTERED HEADER ───
//           const Text(
//             "Get in Touch",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 48,
//               fontWeight: FontWeight.bold,
//               letterSpacing: -1,
//             ),
//           ),
//           const SizedBox(height: 16),
//           ConstrainedBox(
//             constraints: const BoxConstraints(maxWidth: 600),
//             child: Text(
//               "Ready to start your project? Fill out the form below and we'll get back to you within 24 hours.",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.white.withOpacity(0.7),
//                 fontSize: 16,
//                 height: 1.5,
//               ),
//             ),
//           ),
//           const SizedBox(height: 60),

//           // ─── FORM CONTENT ───
//           ConstrainedBox(
//             constraints: const BoxConstraints(maxWidth: 1100),
//             child: Column(
//               children: [
//                 // 1. Name & Email Row
//                 if (isDesktop)
//                   Row(
//                     children: [
//                       Expanded(
//                         child: _buildGlassField(
//                           "Your name",
//                           "Enter your name",
//                           _nameController,
//                         ),
//                       ),
//                       const SizedBox(width: 32),
//                       Expanded(
//                         child: _buildGlassField(
//                           "Your e-mail",
//                           "Enter your mail",
//                           _emailController,
//                         ),
//                       ),
//                     ],
//                   )
//                 else ...[
//                   _buildGlassField(
//                     "Your name",
//                     "Enter your name",
//                     _nameController,
//                   ),
//                   const SizedBox(height: 24),
//                   _buildGlassField(
//                     "Your e-mail",
//                     "Enter your mail",
//                     _emailController,
//                   ),
//                 ],

//                 const SizedBox(height: 32),

//                 // 2. Role/Options & Message Row
//                 if (isDesktop)
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: Column(
//                           children: [
//                             _buildGlassDropdown("Your role"),
//                             const SizedBox(height: 40),
//                             _buildRadioOption("Do you have any liked design?"),
//                             _buildRadioOption("Do you have your own design?"),
//                             _buildRadioOption("I want a custom design"),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(width: 32),
//                       Expanded(
//                         child: _buildGlassField(
//                           "Message *",
//                           "Tell us about your project",
//                           _messageController,
//                           maxLines: 9,
//                         ),
//                       ),
//                     ],
//                   )
//                 else ...[
//                   _buildGlassDropdown("Your role"),
//                   const SizedBox(height: 32),
//                   _buildGlassField(
//                     "Message *",
//                     "Tell us about your project",
//                     _messageController,
//                     maxLines: 6,
//                   ),
//                   const SizedBox(height: 32),
//                   _buildRadioOption("Do you have any liked design?"),
//                   _buildRadioOption("Do you have your own design?"),
//                   _buildRadioOption("I want a custom design"),
//                 ],

//                 const SizedBox(height: 60),

//                 // 3. Submit Button
//                 Center(
//                   child: SizedBox(
//                     width: double.infinity,
//                     child: AppButton(
//                       text: "Submit",
//                       enableGlow: true,
//                       // color: const Color(
//                       //   0xFF8E2DE2,
//                       // ), // Matches the Purple design
//                       onPressed: () {
//                         // Access your data here:
//                         // print(_nameController.text);
//                         // print(_selectedOption);
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ─── COMPONENT BUILDERS ───

//   Widget _buildGlassField(
//     String label,
//     String hint,
//     TextEditingController controller, {
//     int maxLines = 1,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(color: Colors.white70, fontSize: 14),
//         ),
//         const SizedBox(height: 10),
//         ClipRRect(
//           borderRadius: BorderRadius.circular(12),
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.05),
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.white.withOpacity(0.15)),
//               ),
//               child: TextField(
//                 controller: controller,
//                 maxLines: maxLines,
//                 style: const TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                   hintText: hint,
//                   hintStyle: TextStyle(color: Colors.white.withOpacity(0.2)),
//                   contentPadding: const EdgeInsets.all(18),
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildGlassDropdown(String label) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(color: Colors.white70, fontSize: 14),
//         ),
//         const SizedBox(height: 10),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 18),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.05),
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.white.withOpacity(0.15)),
//           ),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton<String>(
//               isExpanded: true,
//               dropdownColor: const Color(0xFF1A1A1A),
//               value: _selectedRole,
//               icon: const Icon(Icons.expand_more, color: Colors.white54),
//               items:
//                   ["Select your role", "Designer", "Developer", "Client"]
//                       .map(
//                         (val) => DropdownMenuItem(
//                           value: val,
//                           child: Text(
//                             val,
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       )
//                       .toList(),
//               onChanged: (v) => setState(() => _selectedRole = v!),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildRadioOption(String title) {
//     bool isSelected = _selectedOption == title;
//     return GestureDetector(
//       onTap: () => setState(() => _selectedOption = title),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 10),
//         child: Row(
//           children: [
//             Container(
//               width: 22,
//               height: 22,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: isSelected ? const Color(0xFF8E2DE2) : Colors.white30,
//                   width: 2,
//                 ),
//               ),
//               child: Center(
//                 child:
//                     isSelected
//                         ? Container(
//                           width: 10,
//                           height: 10,
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Color(0xFF8E2DE2),
//                           ),
//                         )
//                         : null,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Text(
//               title,
//               style: TextStyle(
//                 color: isSelected ? Colors.white : Colors.white60,
//                 fontSize: 15,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'dart:ui';
import 'package:flutter/material.dart';
import '../../widgets/button.dart';

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

  // ─── STATE NOTIFIERS ───
  final ValueNotifier<String> _selectedRoleNotifier = ValueNotifier("Client");
  final ValueNotifier<String> _selectedOptionNotifier = ValueNotifier("I want a custom design");

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    _selectedRoleNotifier.dispose();
    _selectedOptionNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery for a more fluid responsive experience
    final Size size = MediaQuery.of(context).size;
    final bool isDesktop = size.width > 950;
    final double horizontalPadding = size.width * (isDesktop ? 0.08 : 0.05);

    return Container(
      width: double.infinity,
      color: Colors.black,
      padding: EdgeInsets.symmetric(vertical: 100, horizontal: horizontalPadding),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── MODERN HEADER ───
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 650),
                  child: Column(
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Colors.white, Color(0xFF9E9E9E)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ).createShader(bounds),
                        child: const Text(
                          "Get in Touch",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 52,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -2.5,
                            height: 1.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Ready to start your project? Fill out the form below and we'll get back to you within 24 hours.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 60),

              // ─── 1. ROLE SELECTOR ───
              const _SectionLabel(label: "I AM A..."),
              const SizedBox(height: 12),
              _buildProfessionalRoleSelector(),
              
              const SizedBox(height: 40),

              // ─── 2. THE GRID FORM ───
              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _SectionLabel(label: "YOUR NAME"),
                          const SizedBox(height: 8),
                          _buildGlassField("Full Name", "Enter your name", _nameController),
                          const SizedBox(height: 32),
                          const _SectionLabel(label: "PROJECT STATUS"),
                          const SizedBox(height: 8),
                          _buildRadioOption("Do you have any liked design?"),
                          _buildRadioOption("Do you have your own design?"),
                          _buildRadioOption("I want a custom design"),
                        ],
                      ),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _SectionLabel(label: "YOUR E-MAIL"),
                          const SizedBox(height: 8),
                          _buildGlassField("Email Address", "Enter your mail", _emailController),
                          const SizedBox(height: 32),
                          const _SectionLabel(label: "MESSAGE *"),
                          const SizedBox(height: 8),
                          _buildGlassField(
                            "Message",
                            "Tell us about your project",
                            _messageController,
                            maxLines: 7,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _SectionLabel(label: "YOUR NAME"),
                    const SizedBox(height: 8),
                    _buildGlassField("Full Name", "Enter your name", _nameController),
                    const SizedBox(height: 24),
                    const _SectionLabel(label: "YOUR E-MAIL"),
                    const SizedBox(height: 8),
                    _buildGlassField("Email Address", "Enter your mail", _emailController),
                    const SizedBox(height: 24),
                    const _SectionLabel(label: "PROJECT STATUS"),
                    const SizedBox(height: 4),
                    _buildRadioOption("Do you have any liked design?"),
                    _buildRadioOption("Do you have your own design?"),
                    _buildRadioOption("I want a custom design"),
                    const SizedBox(height: 24),
                    const _SectionLabel(label: "MESSAGE *"),
                    const SizedBox(height: 8),
                    _buildGlassField("Message", "Tell us about your project", _messageController, maxLines: 5),
                  ],
                ),

              const SizedBox(height: 60),

              // ─── 3. SUBMIT ACTION ───
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: AppButton(
                    text: "Submit",
                    enableGlow: true,
                    onPressed: () {
                      // Handle Submission Logic
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── WIDGET BUILDERS ───

  Widget _buildProfessionalRoleSelector() {
    final roles = ["Client", "Designer", "Developer", "Founder"];
    return ValueListenableBuilder<String>(
      valueListenable: _selectedRoleNotifier,
      builder: (context, selected, _) {
        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: roles.map((role) {
            final isSelected = selected == role;
            return GestureDetector(
              onTap: () => _selectedRoleNotifier.value = role,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF8E2DE2) : Colors.white.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF8E2DE2) : Colors.white.withOpacity(0.1),
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

  Widget _buildGlassField(String label, String hint, TextEditingController controller, {int maxLines = 1}) {
    return _AnimatedInputField(
      controller: controller,
      hint: hint,
      maxLines: maxLines,
    );
  }

  Widget _buildRadioOption(String title) {
    return ValueListenableBuilder<String>(
      valueListenable: _selectedOptionNotifier,
      builder: (context, selected, _) {
        final isSelected = selected == title;
        return InkWell(
          onTap: () => _selectedOptionNotifier.value = title,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? const Color(0xFF8E2DE2) : Colors.white.withOpacity(0.3),
                      width: isSelected ? 5 : 1.5,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.white54,
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AnimatedInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;

  const _AnimatedInputField({
    required this.controller,
    required this.hint,
    required this.maxLines,
  });

  @override
  State<_AnimatedInputField> createState() => _AnimatedInputFieldState();
}

class _AnimatedInputFieldState extends State<_AnimatedInputField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: _isFocused ? const Color(0xFF8E2DE2).withOpacity(0.8) : Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Focus(
        onFocusChange: (focus) => setState(() => _isFocused = focus),
        child: TextField(
          controller: widget.controller,
          maxLines: widget.maxLines,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          cursorColor: const Color(0xFF8E2DE2),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.2), fontSize: 13),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 4,
          decoration: const BoxDecoration(color: Color(0xFF8E2DE2), shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.4),
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}