import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:grocery/screens/zoom_drawer_wrapper.dart';

class WalletScreen extends StatefulWidget {
  final ZoomDrawerController controller;
  const WalletScreen({super.key, required this.controller});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final List<String> transactionTypes = [
    "All transactions",
    "Order transactions",
    "Converted from loyalty point",
    "Added via payment method",
    "Earned by referral",
    "Earned by Bonus",
    "Added by admin",
  ];

  String selectedType = "All transactions";
  bool showDropdown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w600,
            )),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.green),
          onPressed: () {
            widget.controller.toggle!();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Wallet Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 4, 82, 61),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(Icons.account_balance_wallet_rounded, color: Colors.white, size: 30),
                        SizedBox(height: 10),
                        Text(
                          '0.00 \$',
                          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Wallet Amount',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      child: ElevatedButton(
                        onPressed: () {
                          _showAddFundDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(8),
                        ),
                        child: const Icon(Icons.add, color: Color(0xFF006C50)),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Wallet History with Dropdown
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        showDropdown = !showDropdown;
                      });
                    },
                    child: Row(
                      children: [
                        const Text(
                          'Wallet History',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Icon(showDropdown ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                  if (showDropdown)
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
                        ],
                      ),
                      child: Column(
                        children: transactionTypes.map((type) {
                          return ListTile(
                            title: Text(
                              type,
                              style: TextStyle(
                                fontWeight: type == selectedType ? FontWeight.bold : FontWeight.normal,
                                color: type == selectedType ? Colors.black : Colors.grey[700],
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selectedType = type;
                                showDropdown = false;
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Text(" $selectedType",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),

            const SizedBox(height: 40),

            // Empty State
            Column(
              children: [
                const Icon(Icons.search, size: 150, color: Colors.grey),
                const SizedBox(height: 20),
                const Text(
                  'No Result Found',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ZoomDrawerWrapper(
                          controller: ZoomDrawerController(),
                          isGuest: false,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("Let's Shop",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      )),
                ),
              ],
            ),

            const SizedBox(height: 30),

            
          ],
          
        ),

      ),
    );
  }
  void _showAddFundDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      TextEditingController amountController = TextEditingController();

      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Add fund to Wallet",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Add funds from secured digital payment gateways.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter amount",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    final enteredAmount = amountController.text;
                    // Perform your add fund logic here.
                    Navigator.pop(context); // Close dialog after action.
                  },
                  child: Text("Add Fund"),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

}
