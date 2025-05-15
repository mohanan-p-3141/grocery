import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:grocery/screens/favorite_screen.dart';
import 'package:grocery/screens/my_orders_screen.dart';
import 'package:grocery/screens/shoping_bag_screen.dart';

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
        return const PlaceholderScreen(title: 'Address');
      case 6:
        return const PlaceholderScreen(title: 'Coupon');
      case 7:
        return const PlaceholderScreen(title: 'Customer Support');
      case 8:
        return const PlaceholderScreen(title: 'Settings');
      case 9:
        return const PlaceholderScreen(title: 'Wallet');
      case 10:
        return const PlaceholderScreen(title: 'Loyalty Points');
      case 11:
        return const PlaceholderScreen(title: 'Terms & Conditions');
      case 12:
        return const PlaceholderScreen(title: 'Privacy Policy');
      case 13:
        return const PlaceholderScreen(title: 'About Us');
      case 14:
        return const PlaceholderScreen(title: 'FAQ');
      case 15:
        return const PlaceholderScreen(title: 'Logged Out');
      default:
        return const PlaceholderScreen(title: 'Coming Soon...');
    }
  }

  void _onItemSelected(int index) {
    setState(() {
      selectedScreenIndex = index;
    });
    drawerController.toggle!();
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
