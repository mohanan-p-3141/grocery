import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:grocery/screens/reset_password_screen.dart';
import 'home_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  final bool fromForgotPassword;
  const OtpScreen({super.key, required this.phone,this.fromForgotPassword = false});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();
  bool _showError = false;

  void _verifyOtp() {
    if (_otpController.text == '123456') {
      if(widget.fromForgotPassword){
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (_) => const ResetPasswordScreen()),
        );}else{
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen(isGuest: false, controller: ZoomDrawerController(),)),
        (route) => false,
      );
      }
    } else {
      setState(() {
        _showError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OTP Verification')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('A 6-digit OTP has been sent to:'),
            const SizedBox(height: 8),
            Text(widget.phone, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: const InputDecoration(labelText: 'Enter OTP'),
            ),
            if (_showError)
              const Text('Invalid OTP. Please try again.',
                  style: TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _verifyOtp,
                child: const Text('Verify'),
              ),
            ),
            TextButton(
              onPressed: () {
                // For demo: show resend message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('OTP resent to your number')),
                );
              },
              child: const Text("Didn't receive the code? Resend"),
            )
          ],
        ),
      ),
    );
  }
}
