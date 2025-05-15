import 'package:flutter/material.dart';
import 'package:grocery/provider/favorite_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'zoom_drawer_wrapper.dart';

class FavoriteScreen extends StatelessWidget {
  final ZoomDrawerController controller;
  const FavoriteScreen({super.key, required this.controller, required List favoriteProducts});

  @override
  Widget build(BuildContext context) {
    final favoriteProducts = context.watch<FavoriteProvider>().favorites;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.green),
          onPressed: () {
            controller.toggle!();
          },
        ),
        title: const Text(
          'Favorite',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '${favoriteProducts.length} Items',
                style: const TextStyle(color: Colors.green),
              ),
            ),
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: favoriteProducts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/emptycart.webp', height: 150),
                  const SizedBox(height: 20),
                  const Text('No Favorite Items', style: TextStyle(color: Colors.grey, fontSize: 16)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ZoomDrawerWrapper(controller: controller, isGuest: false)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text("Let's Shop"),
                    ),
                  )
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: product.image != null
                        ? Image.network(product.image, width: 50, height: 50, fit: BoxFit.cover)
                        : const Icon(Icons.image_not_supported, size: 50),
                    title: Text(product.name ?? 'Unnamed Product'),
                    subtitle: Text('₹${product.price ?? '--'}'),
                    trailing: const Icon(Icons.favorite, color: Colors.red),
                  ),
                );
              },
            ),
    );
  }
}