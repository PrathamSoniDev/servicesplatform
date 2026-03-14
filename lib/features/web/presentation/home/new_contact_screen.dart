import 'package:flutter/material.dart';
import 'package:servicesplatform/features/web/utils/app_theme.dart';
import '../../utils/responsive.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final padding = Responsive.pagePadding(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 100),
      child: Center(
        child: Container(
          width: Responsive.isDesktop(context) ? 600 : double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                "Contact Us",
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              const SizedBox(height: 40),

              const TextField(
                decoration: InputDecoration(
                  hintText: "Name",
                ),
              ),

              const SizedBox(height: 20),

              const TextField(
                decoration: InputDecoration(
                  hintText: "Email",
                ),
              ),

              const SizedBox(height: 20),

              const TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Message",
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGreen,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
                onPressed: () {},
                child: const Text("Send Message"),
              )
            ],
          ),
        ),
      ),
    );
  }
}