import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery/screens/zoom_drawer_wrapper.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  final ZoomDrawerController controller;
  const TermsAndConditionsScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.green),
          onPressed: () {
            controller.toggle!(); 
          },
        ),
        title: Text(
          'Terms & Conditions',
          style: GoogleFonts.poppins(
            color: Colors.green.shade800,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: const Color(0xFFF7F7F7),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Introduction',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'These Terms and Conditions govern your use of our app. By accessing or using the application, you agree to be bound by these terms. Please read them carefully.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 24),

            Text(
              'User Obligations',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You agree to use the application only for lawful purposes. You must not use the app in any way that breaches any applicable law or regulation.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 24),

            Text(
              'Privacy Policy',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your privacy is important to us. Please read our Privacy Policy carefully to understand how we collect, use, and protect your information.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 24),

            Text(
              'Limitation of Liability',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'We shall not be liable for any damages arising out of the use or inability to use the application, even if we have been advised of the possibility of such damages.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 24),

            Text(
              'Changes to Terms',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'We reserve the right to update or modify these terms at any time without prior notice. Continued use of the application signifies your acceptance of the updated terms.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
