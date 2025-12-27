import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servicesplatform/core/app_router.dart';
import 'package:servicesplatform/features/web/presentation/common/footer_section.dart';
import 'package:servicesplatform/features/web/widgets/top_nav_bar.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedRole;
  int _selectedDesignOption = 0; // 0: None, 1: Liked, 2: Own, 3: Custom

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  final List<String> _roles = [
    'Product Designer',
    'Developer',
    'Founder',
    'Other',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _buildHeroAndFormSection(context),
                _buildContactInfoSection(context),
                const FooterSection(),
              ],
            ),
          ),
          TopNavBar(
            activeIndex: 5,
            onHome: () => context.go(AppRouter.home),
            onDesigns:
                () => context.go(
                  AppRouter.home,
                ), // Scroll handling could be improved if needed
            onAbout: () => context.go(AppRouter.aboutUs),
            onTestimonials: () => context.go(AppRouter.home),
            onBlog: () => context.go(AppRouter.blog),
            onContact: () {}, // Already here
          ),
        ],
      ),
    );
  }

  Widget _buildHeroAndFormSection(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Stack(
      children: [
        // Background Image
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            height: isMobile ? 300 : 500, // Reduced height for image
            child: Image.asset(
              'assets/images/image 18.png',
              fit: BoxFit.contain,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
        // Content
        Container(
          padding: EdgeInsets.only(
            top: 120, // Navbar space
            left: isMobile ? 20 : 100,
            right: isMobile ? 20 : 100,
            bottom: 80,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ─── Header ───
              Text(
                "Love to hear from you",
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: isMobile ? 32 : 56,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.1,
                ),
              ),
              Text(
                "Get in touch",
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: isMobile ? 32 : 56,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFFFFFF), // Can add gradient if needed
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Ready to bring your digital vision to life? Contact us today and let's start\nbuilding something amazing together.",
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: isMobile ? 14 : 18,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 60),

              // ─── Form ───
              Container(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row 1: Name & Email
                      if (isMobile) ...[
                        _buildTextField(
                          "Your name",
                          "Enter your name",
                          _nameController,
                        ),
                        const SizedBox(height: 24),
                        _buildTextField(
                          "Your e-mail",
                          "Enter your mail",
                          _emailController,
                        ),
                      ] else
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                "Your name",
                                "Enter your name",
                                _nameController,
                              ),
                            ),
                            const SizedBox(width: 40),
                            Expanded(
                              child: _buildTextField(
                                "Your e-mail",
                                "Enter your mail",
                                _emailController,
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 24),
                      if (!isMobile)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left Column
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Role
                                  _buildDropdownField(
                                    "Your role",
                                    "Select your role",
                                  ),
                                  const SizedBox(height: 40),

                                  // Radio Buttons
                                  _buildRadioOption(
                                    "Do you have any liked design?",
                                    1,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildRadioOption(
                                    "Do you have your own design?",
                                    2,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildRadioOption(
                                    "I want a custom design",
                                    3,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 40),
                            // Right Column
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel("Message *"),
                                  const SizedBox(height: 12),
                                  TextFormField(
                                    controller: _messageController,
                                    maxLines: 9,
                                    style: GoogleFonts.outfit(
                                      color: Colors.white,
                                    ),
                                    decoration: _inputDecoration(
                                      "Tell us about your project",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      else ...[
                        _buildDropdownField("Your role", "Select your role"),
                        const SizedBox(height: 24),
                        _buildLabel("Message *"),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _messageController,
                          maxLines: 5,
                          style: GoogleFonts.outfit(color: Colors.white),
                          decoration: _inputDecoration(
                            "Tell us about your project",
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildRadioOption("Do you have any liked design?", 1),
                        const SizedBox(height: 16),
                        _buildRadioOption("Do you have your own design?", 2),
                        const SizedBox(height: 16),
                        _buildRadioOption("I want a custom design", 3),
                      ],

                      const SizedBox(height: 40),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8B3DFF), // Purple
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            "Send",
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfoSection(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        // Use the second background image here if needed, or stick to dark
        color: Colors.black, // Fallback
        image: DecorationImage(
          image: AssetImage(
            'assets/images/contact_bg_1.png',
          ), // Using the second image provided
          fit: BoxFit.cover,
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: isMobile ? 20 : 100,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child:
              isMobile
                  ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildContactTitle(),
                      const SizedBox(height: 40),
                      _buildInfoItem(Icons.phone_outlined, "+91- 98765 56789"),
                      const SizedBox(height: 20),
                      _buildInfoItem(
                        Icons.email_outlined,
                        "hello@servicesplatform.com",
                      ),
                    ],
                  )
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: _buildContactTitle()),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildInfoItem(
                              Icons.phone_outlined,
                              "+91- 98765 56789",
                            ),
                            const SizedBox(height: 30),
                            _buildInfoItem(
                              Icons.email_outlined,
                              "hello@servicesplatform.com",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }

  Widget _buildContactTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Contact\nInformation",
          style: GoogleFonts.outfit(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Have a question or ready to start your\nproject? We're here to help!",
          style: GoogleFonts.outfit(
            fontSize: 18,
            color: Colors.white70,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 28),
        const SizedBox(width: 20),
        Text(
          text,
          style: GoogleFonts.outfit(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 12),
        TextFormField(
          controller: controller,
          style: GoogleFonts.outfit(color: Colors.white),
          decoration: _inputDecoration(hint),
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: _selectedRole,
          dropdownColor: const Color(0xFF1E1E1E),
          style: GoogleFonts.outfit(color: Colors.white),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
          decoration: _inputDecoration(hint),
          items:
              _roles.map((role) {
                return DropdownMenuItem(value: role, child: Text(role));
              }).toList(),
          onChanged: (val) {
            setState(() {
              _selectedRole = val;
            });
          },
        ),
      ],
    );
  }

  Widget _buildRadioOption(String text, int value) {
    final isSelected = _selectedDesignOption == value;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedDesignOption = value;
        });
      },
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? const Color(0xFF8B3DFF) : Colors.white54,
                width: 2,
              ),
            ),
            padding: const EdgeInsets.all(4),
            child:
                isSelected
                    ? Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF8B3DFF),
                      ),
                    )
                    : null,
          ),
          const SizedBox(width: 16),
          Text(
            text,
            style: GoogleFonts.outfit(fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.outfit(
        fontSize: 14,
        color: Colors.white70,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.transparent,
      hintText: hint,
      hintStyle: GoogleFonts.outfit(color: Colors.white24),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white24, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white, width: 1),
      ),
    );
  }
}
