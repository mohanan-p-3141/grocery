import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/src/drawer_controller.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class TrackOrderScreen extends StatefulWidget {
  final ZoomDrawerController controller;
  const TrackOrderScreen({super.key, required this.controller});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _orderIdController = TextEditingController();
  String? _phoneNumber;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _orderIdController.dispose();
    super.dispose();
  }

  void _searchOrder() {
    final orderId = _orderIdController.text.trim();

    if (orderId.isEmpty || _phoneNumber == null || _phoneNumber!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter valid order ID and phone number"),
        ),
      );
      return;
    }

    // TODO: Call your API or logic here
    debugPrint("Searching for Order ID: $orderId and Phone: $_phoneNumber");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Track Order',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          onPressed: () {
            widget.controller.toggle!();
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.green),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.green),
            onPressed: () {
              _orderIdController.clear();
              _phoneNumber = null;
              setState(() {});
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              children: [
                TextField(
                  controller: _orderIdController,
                  decoration: InputDecoration(
                    hintText: 'Order ID',
                    prefixIcon: const Icon(Icons.receipt_long),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                IntlPhoneField(
                  initialCountryCode: 'IN',
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (phone) {
                    _phoneNumber = phone.completeNumber;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _searchOrder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Search Order",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Column(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 80,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Enter your order ID & phone number\nto get delivery updates',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
