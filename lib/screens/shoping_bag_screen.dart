import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:grocery/screens/zoom_drawer_wrapper.dart';

class ShoppingBagScreen extends StatelessWidget {
  final ZoomDrawerController controller;

  const ShoppingBagScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.green),
          onPressed: () {
            controller.toggle!(); // animate back to menu
          },
        ),
        title: const Text(
          'Shopping Bag',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '0 Items',
                style: TextStyle(color: Colors.green),
              ),
            ),
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/emptycart.webp', // Replace with your local image or use an SVG/icon
              height: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              'Empty Shopping Bag',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ZoomDrawerWrapper(
                            controller: controller,
                            isGuest: false,
                          ),
                        ),
                      );// go back to shopping (open drawer)
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text("Let's Shop"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
