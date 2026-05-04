import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
// WelcomeScreen1 — First onboarding screen
// (Screen 1 of 5 in the welcome flow)
//
// Shows the app name + tagline
// User can swipe left or tap Continue to proceed
// Back button is disabled on screen 1 (nothing behind it)
// ─────────────────────────────────────────────

class Welcomescreen1 extends StatelessWidget {
  const Welcomescreen1({super.key});

  // ── Freelio Brand Colors ──────────────────
  static const Color kPrimary       = Color(0xFF29B2FE); // Freelancer blue
  static const Color kBackground    = Color(0xFFFFFFFF); // clean white
  static const Color kSurface       = Color(0xFFE8F6FF); // light blue tint
  static const Color kTextPrimary   = Color(0xFF0A1628); // dark navy
  static const Color kTextSecondary = Color(0xFF1D5C97); // mid blue
  static const Color kDivider       = Color(0xFFBFE4FF); // soft blue divider
  // ─────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,

      // ── Bottom Navigation Buttons ──────────────────────────
      // Back is disabled on screen 1 (there's nowhere to go back to)
      // Continue pushes to welcomescreen2
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            // Back button — disabled on screen 1
            ElevatedButton.icon(
              onPressed: null, // disabled intentionally
              icon: const Icon(Icons.arrow_back_ios_new, size: 14),
              label: const Text("Back"),
              style: ElevatedButton.styleFrom(
                backgroundColor: kDivider,
                foregroundColor: kTextSecondary,
                disabledBackgroundColor: kDivider,
                disabledForegroundColor: kTextSecondary.withOpacity(0.4),
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            // Continue button → goes to screen 2
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, "/welcomescreen2");
              },
              icon: const Icon(Icons.arrow_forward_ios, size: 14),
              label: const Text("Continue"),
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimary,      // Freelancer blue
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

          ],
        ),
      ),
      // ───────────────────────────────────────────────────────

      // ── Body ────────────────────────────────────────────────
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,

        // Swipe gesture — left to go forward, right disabled on screen 1
        onHorizontalDragEnd: (details) {
          final velocity = details.primaryVelocity ?? 0;

          // Swipe LEFT → go to next screen
          if (velocity < -300) {
            Navigator.pushNamed(context, "/welcomescreen2");
          }
          // Swipe RIGHT → nothing (screen 1, no back)
        },

        child: Stack(
          children: [

            // ── Center Content (logo text + tagline) ──────────
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  // Small "Welcome to" label above the app name
                  Text(
                    "Welcome to",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: kTextSecondary,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // App name — main hero text
                  Text(
                    "Freelio",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w800,
                      color: kPrimary,       // Freelancer blue
                      letterSpacing: 2.0,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Thin decorative divider line under the name
                  Container(
                    width: 48,
                    height: 2,
                    decoration: BoxDecoration(
                      color: kPrimary.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Tagline — what the app is
                  Text(
                    "A Digital Ledger",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: kTextPrimary,   // dark navy
                      letterSpacing: 0.5,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Sub-tagline — who it's for
                  Text(
                    "for your Freelance Career",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: kTextSecondary, // mid blue
                      letterSpacing: 0.3,
                    ),
                  ),

                ],
              ),
            ),
            // ────────────────────────────────────────────────────

            // ── Page Indicator Dots (bottom center) ────────────
            // 5 dots total, dot 0 is active on this screen
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  const int activeIndex = 0; // screen 1 = index 0

                  final bool isActive = index == activeIndex;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 20 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isActive ? kPrimary : kDivider,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: isActive
                          ? [
                        BoxShadow(
                          color: kPrimary.withOpacity(0.35),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ]
                          : [],
                    ),
                  );
                }),
              ),
            ),
            // ────────────────────────────────────────────────────

          ],
        ),
      ),
      // ─────────────────────────────────────────────────────────
    );
  }
}