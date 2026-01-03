import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'button.dart';

class AuthPopup extends StatefulWidget {
  const AuthPopup({super.key});

  @override
  State<AuthPopup> createState() => _AuthPopupState();
}

class _AuthPopupState extends State<AuthPopup> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isSignUp = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: pi).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutBack,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleMode() {
    if (isSignUp) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {
      isSignUp = !isSignUp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      backgroundColor: Colors.transparent,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          double motionBlurValue = (sin(_animation.value) * 6.0).abs();
          
          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(_animation.value);

          return Transform(
            transform: transform,
            alignment: Alignment.center,
            child: _animation.value <= pi / 2
                ? _buildCard(isSignUp: true, motionBlur: motionBlurValue)
                : Transform(
                    transform: Matrix4.rotationY(pi),
                    alignment: Alignment.center,
                    child: _buildCard(isSignUp: false, motionBlur: motionBlurValue),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildCard({required bool isSignUp, required double motionBlur}) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 500,
        minHeight: 600,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          image: const DecorationImage(
            image: AssetImage('assets/images/auth_bg.png'),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 40,
              offset: const Offset(0, 15),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: motionBlur, sigmaY: 0),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.12),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isSignUp ? 'Create account' : 'Welcome back',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -1.0,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      isSignUp
                          ? 'Join us to save your favourite designs'
                          : 'Sign in to access your favorite designs',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 40),
                    _InputField(
                      label: 'Email', 
                      hint: 'email@example.com',
                    ),
                    const SizedBox(height: 20),
                    _InputField(
                      label: 'Password',
                      hint: 'Enter your password',
                      obscure: true,
                    ),
                    if (isSignUp) ...[
                      const SizedBox(height: 20),
                      _InputField(
                        label: 'Confirm Password',
                        hint: 'Repeat your password',
                        obscure: true,
                      ),
                    ],
                    const SizedBox(height: 40),
                    AppButton(
                      text: isSignUp ? "Create Account" : "Sign In",
                      onPressed: () {},
                    ),
                    const SizedBox(height: 32),
                    GestureDetector(
                      onTap: toggleMode,
                      behavior: HitTestBehavior.opaque,
                      child: RichText(
                        text: TextSpan(
                          text: isSignUp
                              ? 'Already have an account? '
                              : "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: isSignUp ? 'Sign in' : 'Sign up',
                              style: const TextStyle(
                                color: Color(0xFFA78BFA),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
      ),
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
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        // Glass Morphism Text Field Container
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            // Adds a second layer of blur specifically for the input box for extra "depth"
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              decoration: BoxDecoration(
                // Subtle white tint for the glass effect
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  // Sharp luxury outline
                  color: Colors.white.withOpacity(0.18),
                  width: 1.2,
                ),
              ),
              child: TextField(
                obscureText: obscure,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                cursorColor: const Color(0xFF8B5CF6),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.35),
                    fontSize: 14,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}