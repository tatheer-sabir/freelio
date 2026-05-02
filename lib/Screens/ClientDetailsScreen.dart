import 'package:flutter/material.dart';

class ClientDetailScreen extends StatelessWidget {
  final Map<String, String> client;

  const ClientDetailScreen({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),

      appBar: AppBar(
        backgroundColor: const Color(0xFF195A51), // darkTeal
        title: Text(client["name"] ?? "Client Detail"),
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _infoCard("Name", client["name"]),
            _infoCard("Company", client["company"]),
            _infoCard("Email", client["email"]),
            _infoCard("Phone", client["phone"]),
            _infoCard("Address", client["address"]),
            _infoCard("Notes", client["notes"]),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String label, String? value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value ?? "-",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}