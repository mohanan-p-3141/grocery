// menu_screen.dart
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  final Function(int) onItemSelected;

  const MenuScreen({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[700],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 20),
          child: ListView(
            padding: const EdgeInsets.only(top: 50),
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.green),
                ),
                const SizedBox(height: 20),
                _buildMenuItem(Icons.home, "Home", 0),
                _buildMenuItem(Icons.category, "All Categories", 1),
                _buildMenuItem(Icons.shopping_bag,"Shopping Bag", 2),
                _buildMenuItem(Icons.favorite,"Favorite", 3),
                _buildMenuItem(Icons.note,"My Orders", 4),
                _buildMenuItem(Icons.location_on,"Track Orders", 5),
                _buildMenuItem(Icons.location_city,"Address", 6),
                _buildMenuItem(Icons.payment,"Coupon",7),
                _buildMenuItem(Icons.messenger, "Customer Support", 8),
                _buildMenuItem(Icons.share_outlined, "Refer & Earn", 9),
                _buildMenuItem(Icons.settings, "Settings", 10),
                _buildMenuItem(Icons.wallet, "Wallet", 11),
                _buildMenuItem(Icons.star_border, "Loyality Point",12),
                _buildMenuItem(Icons.note, "Terms & Conditions",13),
                _buildMenuItem(Icons.notes, "Privacy Policy", 14),
                _buildMenuItem(Icons.circle, "About Us", 15),
                _buildMenuItem(Icons.message, "FAQ", 16),
                _buildMenuItem(Icons.logout, "Logout", 17),
              ],
            ),
          ),
        ),
      );
    
  }

  Widget _buildMenuItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () => onItemSelected(index),
    );
  }
}
