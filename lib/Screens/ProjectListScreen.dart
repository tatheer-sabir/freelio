import 'package:flutter/material.dart';

class Projectlistscreen extends StatelessWidget {
  const Projectlistscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Projects"),
      ),
      body: const Center(
        child: Text(
          "We will design Project List page in next phase 🚀",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}