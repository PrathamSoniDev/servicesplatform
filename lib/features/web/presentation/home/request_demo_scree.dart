import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servicesplatform/features/web/utils/responsive.dart';
import 'package:go_router/go_router.dart';

/// ✅ SEO IMPORT
import 'package:servicesplatform/features/web/presentation/seo/seo_widget.dart';

class RequestDemoScreen extends StatelessWidget {
  const RequestDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SeoWrapper( // 🔥 SEO ROOT
      child: Scaffold(
        body: SeoBody( // 🔥 SEO BODY
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFF3F6FF), Color(0xFFE8EEFE)],
              ),
            ),
            child: SafeArea(
              child: Stack(
                children: [

                  /// 🔥 BACK BUTTON (FIXED)
                  Positioned(
                    top: 20,
                    left: Responsive.pagePadding(context),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop(); // ✅ proper back
                        } else {
                          context.go('/'); // ✅ fallback for web
                        }
                      },
                    ),
                  ),

                  /// MAIN CONTENT
                  SingleChildScrollView(
                    padding: Responsive.screenPadding(context),
                    child: Responsive.centered(
                      context: context,
                      child: Responsive.isMobile(context)
                          ? Column(
                              children: [
                                _buildHeroSide(context),
                                const SizedBox(height: 40),
                                _buildFormSide(context),
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 5, child: _buildHeroSide(context)),
                                const SizedBox(width: 50),
                                Expanded(flex: 6, child: _buildFormSide(context)),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// ✅ HERO SIDE (SEO HEADER)
  Widget _buildHeroSide(BuildContext context) {
    return SeoHeader( // 🔥 IMPORTANT FOR SEO
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),

          SeoText(
            "CONTACT SALES",
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
              letterSpacing: 1.2,
            ),
          ),

          const SizedBox(height: 10),

          SeoHeading(
            "Request a demo",
            style: GoogleFonts.playfairDisplay(
              fontSize: Responsive.isMobile(context) ? 40 : 56,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: const Color(0xFF1A1A40),
            ),
          ),

          const SizedBox(height: 20),

          SeoText(
            "Deliver Breakthrough Customer Experiences With The Most Powerful CX Solution Built For Arab Brands.",
            style: GoogleFonts.inter(
              fontSize: 18,
              color: Colors.black54,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 40),

          /// IMAGE SEO
          Center(
            child: SeoImage(
              src: "https://dummyimage.com/300x200/blue/white",
              alt: "Demo request illustration",
              width: 300,
              height: 200,
            ),
          ),

          const SizedBox(height: 60),

          SeoText(
            "Brands who used Lucidya enjoyed improvements in many ways",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 20),

          Wrap(
            spacing: 15,
            runSpacing: 15,
            children: [
              _buildStatCard("3x", "Improvement in positive sentiment"),
              _buildStatCard("4x", "Growth in new followers"),
              _buildStatCard("39%", "Decrease in response time"),
            ],
          )
        ],
      ),
    );
  }

  /// FORM SIDE
  Widget _buildFormSide(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SeoHeading(
            "Request a demo by filling the form",
            style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 30),

          _buildFormGrid(context),

          const SizedBox(height: 20),

          _buildTextField("Message", "Write your message here!", maxLines: 4),

          const SizedBox(height: 20),

          Row(
            children: [
              Checkbox(value: true, onChanged: (val) {}, activeColor: Colors.indigo),
              const Expanded(
                child: Text(
                  "Please subscribe me to the Lucidya newsletter",
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 55,
            child: SeoButtonLink( // 🔥 SEO LINK BUTTON
              url: "/contact",
              text: "Send to sales",
              onPressed: () {},
            ),
          ),

          const SizedBox(height: 20),

          const Center(
            child: Text(
              "By clicking submit you agree to Privacy Policy",
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFormGrid(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Wrap(
        runSpacing: 20,
        spacing: 20,
        children: [
          _buildSizedInput(constraints, "First Name", "First name"),
          _buildSizedInput(constraints, "Last Name", "Last name"),
          _buildSizedInput(constraints, "Work email", "mail@company.com"),
          _buildSizedInput(constraints, "Job title", "Ex: sales manager"),
          _buildSizedInput(constraints, "Country", "Saudi Arabia", isDropdown: true),
          _buildSizedInput(constraints, "Phone number", "+966 56 1234567"),
          _buildSizedInput(constraints, "Company name", "Example: Lucidya"),
          _buildSizedInput(constraints, "Number of employees", "Choose from list", isDropdown: true),
        ],
      );
    });
  }

  Widget _buildSizedInput(BoxConstraints constraints, String label, String hint, {bool isDropdown = false}) {
    double width = constraints.maxWidth > 500
        ? (constraints.maxWidth / 2) - 10
        : constraints.maxWidth;

    return SizedBox(
      width: width,
      child: _buildTextField(label, hint, isDropdown: isDropdown),
    );
  }

  Widget _buildTextField(String label, String hint, {int maxLines = 1, bool isDropdown = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SeoText(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextFormField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: isDropdown ? const Icon(Icons.keyboard_arrow_down) : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String value, String desc) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SeoHeading(value),
          const SizedBox(height: 8),
          SeoText(desc),
        ],
      ),
    );
  }
}