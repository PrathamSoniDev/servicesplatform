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
import 'package:servicesplatform/features/web/widgets/designer_picker_bottomsheet.dart';
import 'package:servicesplatform/features/web/widgets/professional_role_selector_tab.dart';
import 'package:servicesplatform/models/design_item_models.dart';
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
  final ValueNotifier<String> _selectedRoleNotifier = ValueNotifier("Founder");
  final ValueNotifier<String> _selectedOptionNotifier = ValueNotifier("I want a custom design");
  final ValueNotifier<DesignItem?> _selectedDesignNotifier = ValueNotifier<DesignItem?>(null);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    _selectedRoleNotifier.dispose();
    _selectedOptionNotifier.dispose();
    _selectedDesignNotifier.dispose();
    super.dispose();
  }

  Future<void> _openDesignPicker(BuildContext context) async {
    final result = await showGeneralDialog<dynamic>(
      context: context,
      barrierDismissible: false,
      barrierLabel: "DesignPicker",
      barrierColor: Colors.black.withOpacity(0.7),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, anim1, anim2) {
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100, maxHeight: 800),
            child: const Material(
              color: Colors.transparent,
              child: DesignPickerBottomSheet(),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15 * anim1.value, sigmaY: 15 * anim1.value),
          child: FadeTransition(
            opacity: anim1,
            child: ScaleTransition(
              scale: CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
              child: child,
            ),
          ),
        );
      },
    );

    if (result != null && result is DesignItem) {
      _selectedDesignNotifier.value = result;
      _selectedOptionNotifier.value = "Do you have any liked design?";
    }
  }

  @override
  Widget build(BuildContext context) {
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
              _buildHeader(),
              const SizedBox(height: 60),
              const _SectionLabel(label: "I AM A..."),
              const SizedBox(height: 12),
              
              ProfessionalRoleSelector(
                controller: _selectedRoleNotifier, 
                roles: const ["Founder", "Product Designer", "Developer", "Other"],
              ),
              
              const SizedBox(height: 40),
              _buildFormGrid(isDesktop),
              const SizedBox(height: 60),
              _buildSubmitAction(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Center(
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
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Ready to start your project? Fill out the form below.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormGrid(bool isDesktop) {
    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildLeftColumn()),
          const SizedBox(width: 40),
          Expanded(child: _buildRightColumn(7)),
        ],
      );
    }
    return Column(
      children: [
        _buildLeftColumn(),
        const SizedBox(height: 24),
        _buildRightColumn(5),
      ],
    );
  }

  Widget _buildLeftColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(label: "YOUR NAME"),
        const SizedBox(height: 8),
        _buildField("Full Name", "Enter your name", _nameController),
        const SizedBox(height: 32),
        const _SectionLabel(label: "PROJECT STATUS"),
        const SizedBox(height: 8),
        _buildRadioOption("Do you have any liked design?"),
        _buildRadioOption("Do you have your own design?"),
        _buildRadioOption("I want a custom design"),
      ],
    );
  }

  Widget _buildRightColumn(int lines) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(label: "YOUR E-MAIL"),
        const SizedBox(height: 8),
        _buildField("Email Address", "Enter your mail", _emailController),
        const SizedBox(height: 32),
        const _SectionLabel(label: "MESSAGE *"),
        const SizedBox(height: 8),
        _buildField("Message", "Tell us about your project", _messageController, maxLines: lines),
      ],
    );
  }

  Widget _buildRadioOption(String title) {
    return ValueListenableBuilder<String>(
      valueListenable: _selectedOptionNotifier,
      builder: (context, selected, _) {
        final bool isSelected = selected == title;
        return InkWell(
          onTap: () {
            _selectedOptionNotifier.value = title;
            if (title == "Do you have any liked design?") {
              _openDesignPicker(context);
            }
          },
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
                Expanded(
                  child: ValueListenableBuilder<DesignItem?>(
                    valueListenable: _selectedDesignNotifier,
                    builder: (context, design, _) {
                      String label = title;
                      if (title == "Do you have any liked design?" && design != null) {
                        label = "Selected: ${design.title}";
                      }
                      return Text(
                        label,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.white54,
                          fontSize: 14,
                          fontWeight: (title == "Do you have any liked design?" && design != null) 
                            ? FontWeight.bold 
                            : FontWeight.normal,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildField(String label, String hint, TextEditingController controller, {int maxLines = 1}) {
    return _AnimatedInputField(
      controller: controller,
      hint: hint,
      maxLines: maxLines,
    );
  }

  Widget _buildSubmitAction() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: AppButton(
          text: "Submit",
          enableGlow: true,
          onPressed: () {
             debugPrint("Name: ${_nameController.text}");
             debugPrint("Role: ${_selectedRoleNotifier.value}");
             debugPrint("Option: ${_selectedOptionNotifier.value}");
          },
        ),
      ),
    );
  }
}

// ─── SHARED INTERNAL WIDGETS ───

class _AnimatedInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;

  const _AnimatedInputField({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
  });

  @override
  State<_AnimatedInputField> createState() => _AnimatedInputFieldState();
}

class _AnimatedInputFieldState extends State<_AnimatedInputField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        // Becomes slightly lighter on focus
        color: _isFocused ? Colors.white.withOpacity(0.06) : Colors.white.withOpacity(0.02),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          // Transitions from dark/transparent to Light Grey
          color: _isFocused ? Colors.white.withOpacity(0.5) : Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        maxLines: widget.maxLines,
        style: const TextStyle(color: Colors.white, fontSize: 15),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.2), fontSize: 14),
          contentPadding: const EdgeInsets.all(18),
          border: InputBorder.none,
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
        CustomPaint(size: const Size(28, 4), painter: _TaperedDashPainter()),
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.4),
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}

class _TaperedDashPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
      ).createShader(Offset.zero & size)
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height / 2)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}