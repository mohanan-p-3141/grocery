import 'package:flutter/material.dart';
import 'otp_screen.dart';

class CompleteProfileScreen extends StatefulWidget {
  final String email;
  final String name;

  const CompleteProfileScreen({
    super.key,
    required this.email,
    required this.name,
  });

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _referralController = TextEditingController();

  final List<String> existingNumbers = ['9876543210'];

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
  }

  void _validateAndProceed() {
    if (_formKey.currentState!.validate()) {
      if (existingNumbers.contains(_mobileController.text)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Mobile number already exists")),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OtpScreen(
              phone: '+91 ${_mobileController.text}',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Just One Step Away!')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text('This will help make your profile more personalized'),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Enter your name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Mobile Number'),
                validator: (val) => val != null && val.length == 10
                    ? null
                    : 'Enter valid mobile number',
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _referralController,
                decoration: const InputDecoration(labelText: 'Referral Code (Optional)'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _validateAndProceed,
                child: const Text('Done'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
