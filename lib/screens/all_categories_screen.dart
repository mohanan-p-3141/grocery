import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/src/drawer_controller.dart';

class AllCategoriesScreen extends StatelessWidget {
  final ZoomDrawerController controller;
  const AllCategoriesScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:IconButton(icon:const Icon(Icons.menu),
        onPressed: (){
          controller.toggle!();
        },),title:  const Text("All Categories"),
        backgroundColor: Colors.green,
      ),
      body: Row(
        children: [
          // Left side categories list (vertically scrollable)
          Expanded(
            flex: 1,
            child: ListView(
              children: [
                _buildCategoryItem("Fruits and Vegetables", isSelected: true),
                _buildCategoryItem("Meat and Fish"),
                _buildCategoryItem("Breakfast"),
                _buildCategoryItem("Beverages"),
                _buildCategoryItem("Health Care"),
                _buildCategoryItem("Cleaning"),
                _buildCategoryItem("Personal Care"),
              ],
            ),
          ),

          // Right side subcategories
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ListTile(title: Text("All"), trailing: Icon(Icons.chevron_right)),
                ListTile(title: Text("Fruits"), trailing: Icon(Icons.chevron_right)),
                ListTile(title: Text("Vegetables"), trailing: Icon(Icons.chevron_right)),
              ],
            ),
          )
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
