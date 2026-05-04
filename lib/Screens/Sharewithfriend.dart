import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareScreen extends StatelessWidget {
  const ShareScreen({super.key});

  static const Color kPrimary = Color(0xFF29B2FE);
  static const Color kDark    = Color(0xFF1D5C97);
  static const Color kSurface = Color(0xFFE8F6FF);
  static const Color kWhite   = Color(0xFFFFFFFF);

  void shareApp() {
    Share.share(
      "Check out this amazing app 🚀\n\nDownload now:\nhttps://yourapplink.com",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSurface,

      // ✅ APPBAR WITH BACK BUTTON ONLY
      appBar: AppBar(
        backgroundColor: kPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Share with Friends",
          style: TextStyle(color: Colors.white),
        ),
      ),

      // ✅ BODY
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // HEADER CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [kPrimary, kDark],
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Column(
                children: [
                  Icon(Icons.share, color: Colors.white, size: 50),
                  SizedBox(height: 12),
                  Text(
                    "Share This App",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Invite your friends and grow together 🚀",
                    style: TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // SHARE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimary,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
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

            const Text(
              "Share via WhatsApp, Instagram, Email, and more",
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}