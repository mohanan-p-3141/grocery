import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

class FAQScreen extends StatelessWidget {
  final ZoomDrawerController controller;
  const FAQScreen({super.key, required this.controller});

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
          'FAQs',
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _faqItem(
              question: "What is this app about?",
              answer:
                  "This app is designed to help users manage their tasks, save time, and boost productivity through smart features and a clean interface.",
            ),
            const SizedBox(height: 20),
            _faqItem(
              question: "How do I create an account?",
              answer:
                  "You can create an account by signing up using your email address or phone number. Follow the simple registration process on the login screen.",
            ),
            const SizedBox(height: 20),
            _faqItem(
              question: "Is my data safe?",
              answer:
                  "Yes, we prioritize your privacy and security. All your data is encrypted and securely stored. We do not share your data with third parties.",
            ),
            const SizedBox(height: 20),
            _faqItem(
              question: "Can I use the app offline?",
              answer:
                  "Some features are available offline. However, to sync your data or use cloud-based services, an internet connection is required.",
            ),
            const SizedBox(height: 20),
            _faqItem(
              question: "How can I contact support?",
              answer:
                  "You can reach our support team by emailing us at support@example.com. We're here to help you 24/7.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _faqItem({required String question, required String answer}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          answer,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    );
  }
}
