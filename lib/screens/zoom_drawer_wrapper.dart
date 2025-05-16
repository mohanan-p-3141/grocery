import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:grocery/screens/aboutus_screen.dart';
import 'package:grocery/screens/address_screen.dart';
import 'package:grocery/screens/coupon_screen.dart';
import 'package:grocery/screens/customer_support_screen.dart';
import 'package:grocery/screens/faq_screen.dart';
import 'package:grocery/screens/favorite_screen.dart';
import 'package:grocery/screens/login_screen.dart';
import 'package:grocery/screens/loyality_point_screen.dart';
import 'package:grocery/screens/my_orders_screen.dart';
import 'package:grocery/screens/privacy_policy_screen.dart';
import 'package:grocery/screens/refer_and_earn_screen.dart';
import 'package:grocery/screens/settings_screen.dart';
import 'package:grocery/screens/shoping_bag_screen.dart';
import 'package:grocery/screens/terms_condition.dart';
import 'package:grocery/screens/track_order_screen.dart';
import 'package:grocery/screens/wallet_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'all_categories_screen.dart';
import 'home_screen.dart';
import 'menu_screen.dart';

// Placeholder screens for the remaining items
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title, style: const TextStyle(fontSize: 22))),
    );
  }
}

class ZoomDrawerWrapper extends StatefulWidget {
  const ZoomDrawerWrapper({
    super.key,
    required ZoomDrawerController controller,
    required bool isGuest,
  });

  @override
  State<ZoomDrawerWrapper> createState() => _ZoomDrawerWrapperState();
}

class _ZoomDrawerWrapperState extends State<ZoomDrawerWrapper> {
  final ZoomDrawerController drawerController = ZoomDrawerController();
  int selectedScreenIndex = 0;

  Widget _getScreenForIndex(int index) {
    switch (index) {
      case 0:
        return HomeScreen(controller: drawerController, isGuest: false);
      case 1:
        return AllCategoriesScreen(controller: drawerController);
      case 2:
        return ShoppingBagScreen(controller: drawerController);
      case 3:
        return FavoriteScreen(
          controller: drawerController,
          favoriteProducts: [],
        );
      case 4:
        return MyOrdersScreen(controller: drawerController);
      case 5:
        return TrackOrderScreen(controller: drawerController);
      case 6:
        return AddressScreen(controller: drawerController);
      case 7:
        return  CouponScreen(controller:drawerController);
      case 8:
        return CustomerSupportScreen(controller: drawerController);
      case 9:
        return ReferAndEarnScreen(controller: drawerController, referralCode: '',userName: '',);
      case 10:
        return SettingsScreen(controller: drawerController);
      case 11:
        return WalletScreen(controller: drawerController);
      case 12:
        return LoyaltyPointScreen(controller: drawerController);
      case 13:
        return TermsAndConditionsScreen(controller: drawerController);
      case 14:
        return PrivacyPolicyScreen(controller: drawerController);
      case 15:
        return AboutUsScreen(controller: drawerController);
      case 16:
        return FAQScreen(controller: drawerController);
      case 17:
        return const PlaceholderScreen(title: 'Logged Out');
      default:
        return const PlaceholderScreen(title: 'Coming Soon...');
    }
  }
  void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.help_outline, size: 48, color: Colors.green),
              const SizedBox(height: 12),
              const Text(
                'Are you sure you want to sign out?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        // Clear user data here
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.clear();

                        // Close dialog
                        Navigator.of(context).pop();

                        // Navigate to Login screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => LoginScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Yes'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.green),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'No',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}


void _onItemSelected(int index) {
  if (index == 17) { // Assuming Logout is the last item in the list
    _showLogoutDialog(context);
  } else {
    setState(() {
      selectedScreenIndex = index;
    });
    drawerController.toggle!(); // Close the drawer
  }
}


  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: drawerController,
      style: DrawerStyle.style1,
      menuScreen: MenuScreen(onItemSelected: _onItemSelected),
      mainScreen: _getScreenForIndex(selectedScreenIndex),
      borderRadius: 24.0,
      angle: -12.0,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      showShadow: true,
      menuBackgroundColor: Colors.green,
    );
  }
}
