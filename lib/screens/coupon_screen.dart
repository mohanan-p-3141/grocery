import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/src/drawer_controller.dart';

class CouponScreen extends StatelessWidget {
  final ZoomDrawerController controller;
  const CouponScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.green),
          onPressed: () {
            controller.toggle!();
          },
        ),
        title: const Text("Coupon", style: TextStyle(color: Colors.green)),
        backgroundColor: Colors.white,
        elevation: 0,
        
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20), // Padding from top-left
        child: GestureDetector(
          onTap: () {
            Clipboard.setData(const ClipboardData(text: 'FOODIE50'));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Coupon code copied!'),
                duration: const Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          },
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
            decoration: BoxDecoration(
              color: const Color(0xFF006241),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: 16),
                const Icon(Icons.local_offer, color: Colors.white, size: 36),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Foodie",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "50.0\$ off",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Valid until 30 Oct, 2025",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
