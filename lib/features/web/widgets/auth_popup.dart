import 'dart:ui';

import 'package:flutter/material.dart';

import 'button.dart';

class AuthPopup extends StatelessWidget {
  const AuthPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 520, // ✅ CONTROLLED WIDTH
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: AssetImage('assets/images/auth_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 36,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: .55),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: .15),
                  ),
                ),
                child: _AuthForm(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AuthForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Create account',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Join us to save your favourite designs',
          style: TextStyle(
            color: Colors.white.withValues(alpha: .7),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 32),

        _InputField(label: 'Email', hint: 'Enter your mail'),
        const SizedBox(height: 16),
        _InputField(label: 'Password', obscure: true),
        const SizedBox(height: 16),
        _InputField(label: 'Confirm Password', obscure: true),
        const SizedBox(height: 28),

        AppButton(text: "Sign Up", onPressed: () {}),

        const SizedBox(height: 20),

        RichText(
          text: TextSpan(
            text: 'Already have an account? ',
            style: TextStyle(
              color: Colors.white.withValues(alpha: .7),
              fontSize: 13,
            ),
            children: const [
              TextSpan(
                text: 'Sign in',
                style: TextStyle(
                  color: Color(0xFF8B5CF6),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final String? hint;
  final bool obscure;

  const _InputField({required this.label, this.hint, this.obscure = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: .9),
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          obscureText: obscure,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
