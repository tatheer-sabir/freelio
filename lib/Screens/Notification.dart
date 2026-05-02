import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  final Color primaryTeal = const Color(0xFF195A51);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[200],
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: primaryTeal,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          _notif("💰 Payment received from Ali Ahmed"),
          _notif("⚠️ Sara Khan payment is overdue"),
          _notif("👤 New client added: Hassan Ali"),


        ],
      ),
    );
  }

  Widget _notif(String text) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.notifications_active, color: Colors.teal),
        title: Text(text),
      ),
    );
  }
}