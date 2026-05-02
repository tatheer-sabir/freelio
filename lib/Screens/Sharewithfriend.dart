import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareScreen extends StatelessWidget {
  const ShareScreen({super.key});

  final Color darkTeal = const Color(0xFF195A51);

  // 🔗 Share function
  void shareApp() {
    Share.share(
      "Check out this amazing app 🚀\n\nDownload now:\nhttps://yourapplink.com",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),

      appBar: AppBar(
        backgroundColor: darkTeal,
        title: const Text(
          "Share with Friends",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // 🎯 HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: darkTeal,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                children: [
                  Icon(Icons.share, color: Colors.white, size: 40),
                  SizedBox(height: 10),
                  Text(
                    "Share this App",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Invite your friends to use this app",
                    style: TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 📲 SHARE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkTeal,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.share, color: Colors.white),
                label: const Text(
                  "Share Now",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: shareApp,
              ),
            ),

            const SizedBox(height: 20),

            // 💡 INFO TEXT
            const Text(
              "You can share via WhatsApp, Instagram, Email, and more.",
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}