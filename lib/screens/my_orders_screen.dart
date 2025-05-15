import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/src/drawer_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key? key, required ZoomDrawerController controller}) : super(key: key);

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _visible = false;

  // Zoom animation variables
  bool _isMenuOpen = false;
  double _scale = 1.0;
  double _xOffset = 0.0;
  double _yOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void toggleZoomEffect() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
      if (_isMenuOpen) {
        _scale = 0.88;
        _xOffset = 220;
        _yOffset = 100;
      } else {
        _scale = 1.0;
        _xOffset = 0;
        _yOffset = 0;
      }
    });
  }

  Widget _buildEmptyOrders() {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: _visible ? 1.0 : 0.0,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/emptycart.webp', // Use your image path
                height: 150,
              ),
              const SizedBox(height: 20),
              Text(
                'No Order History',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Buy something to see your order here.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Navigate to shopping screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF006241),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(
                  "Let's Shop",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildZoomContent() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      transform: Matrix4.translationValues(_xOffset, _yOffset, 0)..scale(_scale),
      decoration: BoxDecoration(
        borderRadius: _isMenuOpen ? BorderRadius.circular(20) : BorderRadius.zero,
        boxShadow: _isMenuOpen
            ? [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 20,
                  offset: Offset(-5, 10),
                )
              ]
            : [],
      ),
      child: ClipRRect(
        borderRadius: _isMenuOpen ? BorderRadius.circular(20) : BorderRadius.zero,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: toggleZoomEffect,
            ),
            title: Text(
              'My Orders',
              style: GoogleFonts.poppins(
                  color: const Color(0xFF006241), fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: Column(
            children: [
              TabBar(
                controller: _tabController,
                labelColor: const Color(0xFF006241),
                unselectedLabelColor: Colors.grey,
                labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                indicatorColor: const Color(0xFF006241),
                indicatorWeight: 2.5,
                tabs: const [
                  Tab(text: 'Ongoing'),
                  Tab(text: 'History'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildEmptyOrders(),
                    _buildEmptyOrders(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Optional: Add a blurred background or menu panel here
        Container(color: Colors.grey.shade200), // Menu BG

        _buildZoomContent(),
      ],
    );
  }
}
