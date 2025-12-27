import 'package:flutter/material.dart';

class AboutValuesSection extends StatelessWidget {
  const AboutValuesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 900;

    return Container(
      width: double.infinity,
      color: Colors.black,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : width * 0.1,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mission Section
          _SectionRow(
            title: "Our Mission",
            content:
                "Empowering brands to thrive in a digital world, we inspire imagination, collaboration, and excellence. Our goal is to elevate brands through impactful storytelling and innovative solutions.",
            isMobile: isMobile,
          ),
          const SizedBox(height: 60),

          // Approach Section
          _SectionRow(
            title: "Our Approach",
            content:
                "We embrace collaboration, working closely with our clients to understand their goals and challenges. Through open dialogue and creative exploration, we develop customized solutions that resonate with audiences and drive results.\n\nOur iterative process ensures that every aspect of our work is refined and perfected, delivering exceptional quality and value.",
            isMobile: isMobile,
          ),
          const SizedBox(height: 80),

          // Numbers Section
          _SectionRow(
            title: "In Numbers",
            isMobile: isMobile,
            customContent: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _StatItem(value: "10+", label: "Projects completed"),
                const SizedBox(width: 60),
                _StatItem(value: "98%", label: "Client Satisfaction"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionRow extends StatelessWidget {
  final String title;
  final String? content;
  final Widget? customContent;
  final bool isMobile;

  const _SectionRow({
    required this.title,
    this.content,
    this.customContent,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    // On mobile, stack them. On desktop, use a horizontal layout.
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TitleText(title),
          const SizedBox(height: 16),
          customContent ?? _BodyText(content!),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 200, // Fixed width for titles to keep them aligned
          child: _TitleText(title),
        ),
        const SizedBox(width: 40),
        Expanded(child: customContent ?? _BodyText(content!)),
      ],
    );
  }
}

class _TitleText extends StatelessWidget {
  final String text;
  const _TitleText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        letterSpacing: 0.5,
      ),
    );
  }
}

class _BodyText extends StatelessWidget {
  final String text;
  const _BodyText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 15,
        height: 1.7,
        color: Colors.grey.shade400,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 64, // Large prominent numbers
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: -2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade500,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}
