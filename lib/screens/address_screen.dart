import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/src/drawer_controller.dart';
import 'package:grocery/provider/address_provider.dart';
import 'package:grocery/screens/add_address_screen.dart';
import 'package:grocery/screens/zoom_drawer_wrapper.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  final ZoomDrawerController controller;
  const AddressScreen({super.key, required this.controller});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToShop() {
    // Implement navigation to your Home/Shop screen
    debugPrint("Navigating to Shop...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Address",
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.green),
          onPressed: () {
            widget.controller.toggle!();
          },
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddAddressScreen()),
              );
            },
            icon: const Icon(Icons.add, color: Colors.grey),
            label: const Text("Add New", style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Consumer<AddressProvider>(
            builder: (context, provider, _) {
              if (provider.addresses.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, size: 90, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        const Text(
                          "No Address Found",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => ZoomDrawerWrapper(
                                      controller: widget.controller,
                                      isGuest: false,
                                    ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Let's Shop"),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: provider.addresses.length,
                itemBuilder: (context, index) {
                  final address = provider.addresses[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(
                        Icons.location_on,
                        color: Colors.green,
                      ),
                      title: Text(address.name),
                      subtitle: Text(
                        '${address.fullLocation}\n'
                        'Street: ${address.street}, House: ${address.houseNo}, Floor: ${address.floorNo}\n'
                        'Phone: ${address.phone}',
                      ),
                      isThreeLine: true,
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'edit') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => AddAddressScreen(
                                      editIndex: index,
                                      existing: address,
                                    ),
                              ),
                            );
                          } else if (value == 'delete') {
                            provider.deleteAddress(index);
                          }
                        },
                        itemBuilder:
                            (context) => const [
                              PopupMenuItem(value: 'edit', child: Text('Edit')),
                              PopupMenuItem(
                                value: 'delete',
                                child: Text('Delete'),
                              ),
                            ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
