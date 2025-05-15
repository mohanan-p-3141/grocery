import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class HomeScreen extends StatefulWidget {
  final ZoomDrawerController controller;
  final bool isGuest;

  const HomeScreen({super.key, required this.controller, required this.isGuest});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showSearch = false;
  int cartCount = 0;
  Set<int> favoriteIndexes = {};
  List<Map<String, String>> favoriteProducts = [];

  final TextEditingController _searchController = TextEditingController();
  String _locationMessage = "Fetching location...";
  bool _isDeliverable = false;

// Define serviceable areas
final List<String> _serviceableAreas = ['Bengaluru', 'Chennai', 'Mumbai', 'Delhi', 'Marungur'];

bool _checkServiceability(String? locality) {
  return locality != null && _serviceableAreas.contains(locality);
}

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  void _toggleDrawer() {
    if (widget.controller.toggle != null) {
      widget.controller.toggle!();
    } else {
      print("ERROR: ZoomDrawerController.toggle is null");
    }
  }

  Future<void> _fetchLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = "Location services are disabled.";
        _isDeliverable = false;
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationMessage = "Location permission denied.";
          _isDeliverable = false;
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage = "Location permission permanently denied.";
        _isDeliverable = false;
      });
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      String address = '${place.locality},${place.administrativeArea},${place.country}';
      String city = placemarks.first.locality ?? "";
      String area = placemarks.first.subLocality ?? "";
      
      String fullLocation = "$area, $city";

      if (_serviceableAreas.contains(city)) {
        setState(() {
          _locationMessage = "Delivering to $fullLocation";
        });
      } else {
        setState(() {
          _locationMessage = "Do not deliver in your location";
        });
      }
    } else {
      setState(() {
        _locationMessage = "Unable to fetch location.";
      });
    }
  }

  final List<Map<String, String>> categories = [
    {'name': 'Fruits', 'image': 'https://img.icons8.com/emoji/96/apple-emoji.png'},
    {'name': 'Meat', 'image': 'https://img.icons8.com/emoji/96/cut-of-meat.png'},
    {'name': 'Breakfast', 'image': 'https://img.icons8.com/emoji/96/croissant.png'},
    {'name': 'Beverages', 'image': 'https://img.icons8.com/emoji/96/soft-drink.png'},
    {'name': 'Health', 'image': 'https://img.icons8.com/emoji/96/pill.png'},
    {'name': 'Cleaning', 'image': 'https://img.icons8.com/emoji/96/soap.png'},
    {'name': 'Personal', 'image': 'https://img.icons8.com/emoji/96/lotion-bottle.png'},
  ];

  final List<Map<String, String>> products = [
    {
      'name': 'Detergent',
      'image': 'https://via.placeholder.com/150?text=Detergent',
      'price': '5.00',
      'discount': '-5.00 \$',
    },
    {
      'name': 'Yogurt',
      'image': 'https://via.placeholder.com/150?text=Yogurt',
      'price': '2.00',
      'discount': '-20.0 %',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.network('https://img.icons8.com/color/48/grocery-store.png'),
          onPressed: _toggleDrawer,
        ),
        title: _showSearch
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
              )
            : const Text(''), // Provide a default title when not searching

        actions: [
          IconButton(
            icon: Icon(_showSearch ? Icons.close : Icons.search),
            onPressed: () => setState(() => _showSearch = !_showSearch),
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: _isDeliverable ? () {} : null,
              ),
              if (cartCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$cartCount',
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 1,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              _locationMessage,
              style: TextStyle(
                fontSize: 14,
                color: _locationMessage.startsWith("Delivering")
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https://via.placeholder.com/600x200?text=Eat+Healthy+Eat+Organic',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "Popular Categories",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),

            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(categories[index]['image']!),
                        ),
                        const SizedBox(height: 4),
                        Text(categories[index]['name']!, style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Daily Needs",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text("View All", style: TextStyle(color: Colors.green)),
                ],
              ),
            ),

            GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: products.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (_, index) {
                final product = products[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.network(
                              product['image']!,
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            left: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                product['discount']!,
                                style: const TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(product['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            icon: Icon(
                              favoriteIndexes.contains(index)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: favoriteIndexes.contains(index) ? Colors.red : null,
                            ),
                            onPressed: () {
                              setState(() {
                                if (favoriteIndexes.contains(index)) {
                                  favoriteIndexes.remove(index);
                                  favoriteProducts.removeWhere((item) => item['name'] == product['name']);
                                } else {
                                  favoriteIndexes.add(index);
                                  favoriteProducts.add(product);
                                }
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_shopping_cart),
                            onPressed: () {
                              setState(() => cartCount++);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
