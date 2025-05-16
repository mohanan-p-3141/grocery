import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class AllCategoriesScreen extends StatefulWidget {
  final ZoomDrawerController controller;
  const AllCategoriesScreen({super.key, required this.controller});

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  // Category list and their respective subcategories
  final List<String> categories = [
    "Fruits and Vegetables",
    "Meat and Fish",
    "Breakfast",
    "Beverages",
    "Health Care",
    "Cleaning",
    "Personal Care",
    "Cooking",
  ];

  final Map<String, List<String>> subCategories = {
    "Fruits and Vegetables": ["All", "Fruits", "Vegetables"],
    "Meat and Fish": ["All", "Chicken", "Beef", "Fish"],
    "Breakfast": ["All", "Breads & Cereals", "Dairy"],
    "Beverages": ["All", "Juice", "Tea & Coffee", "Soft Drinks"],
    "Health Care": ["All", "Antiseptics"],
    "Cleaning": ["All", "Cleaning Supplies"],
    "Personal Care": ["All", "Women's Care"],
    "Cooking": ["All", "Spices", "Daily Cookings"],
  };

  String selectedCategory = "Fruits and Vegetables";

  @override
  Widget build(BuildContext context) {
    final subItems = subCategories[selectedCategory] ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "All Categories",
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.green),
          onPressed: () {
            widget.controller.toggle!();
          },
        ),
      ),
      body: Row(
        children: [
          // Left side: Categories
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                String category = categories[index];
                bool isSelected = category == selectedCategory;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                  child: _buildCategoryItem(category, isSelected: isSelected),
                );
              },
            ),
          ),

          // Right side: Subcategories
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: subItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(subItems[index]),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // Optional: Add navigation or action here
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Tapped on ${subItems[index]}")),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String title, {bool isSelected = false}) {
    return Card(
      color: isSelected ? Colors.green : Colors.white,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
