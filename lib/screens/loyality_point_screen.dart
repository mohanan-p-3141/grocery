import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class LoyaltyPointScreen extends StatefulWidget {
  final ZoomDrawerController controller;

  const LoyaltyPointScreen({Key? key, required this.controller}) : super(key: key);

  @override
  _LoyaltyPointScreenState createState() => _LoyaltyPointScreenState();
}

class _LoyaltyPointScreenState extends State<LoyaltyPointScreen> {
  final TextEditingController _pointController = TextEditingController();
  int withdrawablePoints = 0; // Replace with actual logic

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.green),
          onPressed: () {
            widget.controller.toggle!(); // Animate back to menu
          },
        ),
        title: const Text(
          "Loyalty Point",
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.green,

      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.emoji_events, size: 32, color: Colors.amber),
                          const SizedBox(height: 8),
                          Text(
                            withdrawablePoints.toStringAsFixed(1),
                            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          const Text("Withdrawable Point", style: TextStyle(fontSize: 16)),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            alignment: WrapAlignment.center,
                            children: [
                              _buildTab("Convert to money", true),
                              _buildTab("Earning", false),
                              _buildTab("Converted", false),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Enter Point", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _pointController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "ex: 300",
                        labelText: "Convert point to wallet money",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Note:", style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          _noteText("• Only earning point can be converted to wallet money"),
                          _noteText("• 1.0 Point remains 1.00 \$"),
                          _noteText("• Once you convert the point into money, it won’t go back to point"),
                          _noteText("• Points can be used to get bonus money"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade800,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // TODO: Convert point to wallet logic
                      },
                      child: const Text("Convert Point",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            label == "Convert to money"
                ? Icons.account_balance_wallet_outlined
                : label == "Earning"
                    ? Icons.trending_up
                    : Icons.check_circle_outline,
            size: 18,
            color: Colors.green.shade800,
          ),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: Colors.green.shade800)),
        ],
      ),
    );
  }

  Widget _noteText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(text),
    );
  }
}
