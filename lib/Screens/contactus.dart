import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  static const Color kPrimary       = Color(0xFF29B2FE);
  static const Color kDark          = Color(0xFF1D5C97);
  static const Color kSurface       = Color(0xFFE8F6FF);
  static const Color kBackground    = Color(0xFFFFFFFF);

  Future<void> sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@freelio.com',
      queryParameters: {
        'subject': 'Support Request',
        'body': 'Hello, I need help with...'
      },
    );
    await _launch(emailUri);
  }

  Future<void> makeCall() async {
    final Uri callUri = Uri(
      scheme: 'tel',
      path: '+923066473361',
    );
    await _launch(callUri);
  }

  Future<void> openWhatsApp() async {
    final Uri whatsappUri = Uri.parse(
      "https://wa.me/923066473361?text=Hello%20I%20need%20help",
    );
    await _launch(whatsappUri);
  }

  Future<void> _launch(Uri uri) async {
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        debugPrint("Could not launch $uri");
      }
    } catch (e) {
      debugPrint("Error launching: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSurface,

      appBar: AppBar(
        backgroundColor: kPrimary,
        title: const Text(
          "Contact Us",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [kPrimary, kDark],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Need Help?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Contact us through any option below",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _actionCard(
              icon: Icons.email,
              title: "Email Support",
              subtitle: "support@freelio.com",
              color: kPrimary,
              onTap: sendEmail,
            ),

            _actionCard(
              icon: Icons.phone,
              title: "Call Us",
              subtitle: "+92 300 1234567",
              color: Colors.green,
              onTap: makeCall,
            ),

            _actionCard(
              icon: Icons.chat,
              title: "WhatsApp",
              subtitle: "Chat instantly",
              color: kDark,
              onTap: openWhatsApp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        tileColor: kBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}