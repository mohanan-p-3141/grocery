import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/src/drawer_controller.dart';
import 'package:image_picker/image_picker.dart';

class CustomerSupportScreen extends StatefulWidget {
  final ZoomDrawerController controller;
  const CustomerSupportScreen({super.key, required this.controller});

  @override
  State<CustomerSupportScreen> createState() => _CustomerSupportScreenState();
}

class _CustomerSupportScreenState extends State<CustomerSupportScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _messages.add({
          'text': null,
          'image': _image,
          'time': DateTime.now(),
          'sender': 'moha',
        });
      });
    }
  }

  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        _messages.add({
          'text': _controller.text.trim(),
          'image': null,
          'time': DateTime.now(),
          'sender': 'moha',
        });
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Customer Support",
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
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (message['text'] != null)
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFE0E0),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            message['text'],
                            style: const TextStyle(color: Colors.black87),
                          ),
                        ),
                      if (message['image'] != null)
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: FileImage(message['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      Text(
                        "${message['time'].hour}:${message['time'].minute.toString().padLeft(2, '0')} | ${message['time'].day}-${message['time'].month}-${message['time'].year}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.image, color: Colors.green),
                    onPressed: _pickImage,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Type here",
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(color: Colors.green),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.green),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
