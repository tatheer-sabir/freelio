import 'package:flutter/material.dart';

class ClientDetailScreen extends StatelessWidget {
  final Map<String, String> client;

  const ClientDetailScreen({super.key, required this.client});

  // 🎨 APP THEME COLORS
  static const Color kPrimary    = Color(0xFF29B2FE);
  static const Color kDark       = Color(0xFF1D5C97);
  static const Color kSurface    = Color(0xFFE8F6FF);
  static const Color kBackground = Color(0xFFFFFFFF);
  static const Color kTextGrey   = Color(0xFF6B7C93);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSurface,

      // ✅ APPBAR
      appBar: AppBar(
        backgroundColor: kPrimary,
        title: Text(
          client["name"] ?? "Client Detail",
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // ✅ BODY
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
        color: kBackground,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
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
              color: kTextGrey,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            value ?? "-",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: kDark,
            ),
          ),
        ],
      ),
    );
  }
}