import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicesplatform/features/auth/auth_bloc.dart';

import '../../../core/bootstrap/bloc/app_bootstrap_bloc.dart';
import '../../../core/bootstrap/bloc/app_bootstrap_event.dart';
import 'button.dart';
import 'custom_snakbar.dart';

class AuthPopup extends StatefulWidget {
  const AuthPopup({super.key});

  @override
  State<AuthPopup> createState() => _AuthPopupState();
}

class _AuthPopupState extends State<AuthPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isSignUp = true;
  final TextEditingController nameController = TextEditingController(),
      emailController = TextEditingController(),
      passController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
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
    final size = MediaQuery.of(context).size;
    final viewInsets = MediaQuery.of(context).viewInsets;

    // Adaptive sizing
    final cardWidth = min(500.0, size.width * 0.9);

    // We adjust height if keyboard is visible to prevent overflow
    final bool isKeyboardOpen = viewInsets.bottom > 0;
    final double cardHeight =
        isKeyboardOpen
            ? min(600.0, size.height - viewInsets.bottom - 40)
            : min(720.0, size.height * 0.85);

    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) {
        return previous.status != current.status;
      },
      listener: (context, state) {
        final pageContext = Navigator.of(context, rootNavigator: true).context;

        if (state.status == AuthStatus.authenticated) {
          FocusScope.of(context).unfocus();

          showCustomSnakcbar(
            pageContext,
            "Authentication Successful",
            "Welcome ${state.user?.user?.email ?? ''}",
            Colors.green,
          );
          context.read<AppBootstrapBloc>().add(LoadUserProfile());
          Future.microtask(() {
            if (Navigator.of(context, rootNavigator: true).canPop()) {
              Navigator.of(context, rootNavigator: true).pop();
            }
          });
        }

        if (state.status == AuthStatus.failure) {
          showCustomSnakcbar(
            pageContext,
            "Authentication Failed",
            state.errorMessage ?? "Something went wrong",
            Colors.red,
          );
        }
      },

      builder: (context, state) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          backgroundColor: Colors.transparent,
          child: RepaintBoundary(
            // ✅ Performance Optimization
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                double motionBlurValue = (sin(_animation.value) * 6.0).abs();

                final transform =
                    Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(_animation.value);

                return Transform(
                  transform: transform,
                  alignment: Alignment.center,
                  child:
                      _animation.value <= pi / 2
                          ? _buildCard(
                            isSignUp: true,
                            motionBlur: motionBlurValue,
                            width: cardWidth,
                            height: cardHeight,
                            screenSize: size,
                            nameController: nameController,
                            emailController: emailController,
                            passController: passController,
                          )
                          : Transform(
                            transform: Matrix4.rotationY(pi),
                            alignment: Alignment.center,
                            child: _buildCard(
                              isSignUp: false,
                              motionBlur: motionBlurValue,
                              width: cardWidth,
                              height: cardHeight,
                              screenSize: size,
                              nameController: nameController,
                              emailController: emailController,
                              passController: passController,
                            ),
                          ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildCard({
    required bool isSignUp,
    required double motionBlur,
    required double width,
    required double height,
    required Size screenSize,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController passController,
  }) {
    // Dynamic scaling based on the calculated card height
    final bool isTight = height < 550;
    final double verticalPadding = isTight ? 16 : 40;
    final double headerSize = isTight ? 22 : 32;
    final double fieldSpacing = isTight ? 8 : 18;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        image: const DecorationImage(
          image: AssetImage('assets/images/auth_bg.png'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .5),
            blurRadius: 40,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: motionBlur, sigmaY: 0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 32,
                vertical: verticalPadding,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: .45),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: Colors.white.withValues(alpha: .12)),
              ),
              child: Column(
                children: [
                  // Header
                  Column(
                    children: [
                      Text(
                        isSignUp ? 'Create account' : 'Welcome back',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: headerSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: -1.0,
                        ),
                      ),
                      if (!isTight) const SizedBox(height: 8),
                      Text(
                        isSignUp
                            ? 'Join us to save your designs'
                            : 'Sign in to access your designs',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: .6),
                          fontSize: isTight ? 12 : 14,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(), // Pushes content to middle
                  // Form Fields
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isSignUp)
                        _InputField(
                          label: 'Name',
                          hint: 'Ex. John',
                          isTight: isTight,
                          controller: nameController,
                        ),
                      SizedBox(height: fieldSpacing),
                      _InputField(
                        label: 'Email',
                        hint: 'Ex. example@gmail.com',
                        isTight: isTight,
                        controller: emailController,
                      ),

                      SizedBox(height: fieldSpacing),
                      _InputField(
                        label: 'Password',
                        hint: 'Strong 6 characters strong Password',
                        obscure: true,
                        isTight: isTight,
                        controller: passController,
                      ),
                    ],
                  ),

                  const Spacer(), // Pushes actions to bottom
                  // Actions
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppButton(
                        text: isSignUp ? "Create Account" : "Sign In",
                        onPressed: () {
                          if (isSignUp) {
                            context.read<AuthBloc>().add(
                              AuthRegisterRequested(
                                name: nameController.text.trim(),
                                email: emailController.text.trim(),
                                password: passController.text.trim(),
                              ),
                            );
                          } else {
                            context.read<AuthBloc>().add(
                              AuthLoginRequested(
                                email: emailController.text.trim(),
                                password: passController.text.trim(),
                              ),
                            );
                          }
                        },
                      ),

                      SizedBox(height: isTight ? 12 : 24),
                      GestureDetector(
                        onTap: toggleMode,
                        behavior: HitTestBehavior.opaque,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text:
                                  isSignUp
                                      ? 'Already have an account? '
                                      : "Don't have an account? ",
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: .5),
                                fontSize: isTight ? 12 : 13,
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
                      ),
                    ],
                  ),
                ],
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
  final bool isTight;
  final TextEditingController controller;

  const _InputField({
    required this.label,
    this.hint,
    this.obscure = false,
    required this.isTight,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 4),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withValues(alpha: .18),
                  width: 1.2,
                ),
              ),
              child: TextField(
                obscureText: obscure,
                controller: controller,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                cursorColor: const Color(0xFF8B5CF6),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(
                    color: Colors.white.withValues(alpha: .35),
                    fontSize: 13,
                  ),
                  isDense: isTight, // ✅ Further reduces height
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: isTight ? 12 : 18,
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
