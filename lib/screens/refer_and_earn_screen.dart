import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/src/drawer_controller.dart';
import 'package:share_plus/share_plus.dart';

class ReferAndEarnScreen extends StatelessWidget {
  final String referralCode;
  final String userName;
  final ZoomDrawerController controller;

  const ReferAndEarnScreen({
    super.key,
    required this.referralCode,
    required this.userName,
    required this.controller,
  });

  void copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Referral code copied!")));
  }

  void shareReferralCode(String code) {
    Share.share(
      "Join GroFresh using my referral code: $code and get exciting offers!",
    );
  }

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
        title: const Text(
          "Refer & Earn",
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset(
              "assets/images/refer.jpg", // You should add this asset
              height: 250,
            ),
            const SizedBox(height: 20),
            const Text(
              "Invite friend and businesses",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Copy your code, share it with your friends",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      referralCode,
                      style: const TextStyle(
                        fontSize: 16,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => copyToClipboard(context, referralCode),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                    ),
                    child: const Text("Copy"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => shareReferralCode(referralCode),
              child: Column(
                children: [
                  const Icon(Icons.share, size: 32, color: Colors.green),
                  const SizedBox(height: 8),
                  const Text("OR SHARE", style: TextStyle(color: Colors.green)),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.shade100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue),
                      SizedBox(width: 8),
                      Text(
                        "How it works ?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  buildStep("1", "Invite your friends & businesses"),
                  const SizedBox(height: 10),
                  buildStep("2", "They register GroFresh with special offer"),
                  const SizedBox(height: 10),
                  buildStep("3", "You made your earning!"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStep(String number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: Colors.green,
          child: Text(number, style: const TextStyle(color: Colors.white)),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
      ],
    );
  }
}
