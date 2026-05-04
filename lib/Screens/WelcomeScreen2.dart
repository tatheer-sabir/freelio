import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
// WelcomeScreen2 — Second onboarding screen
// (Screen 2 of 5 in the welcome flow)
//
// Tells the user we're about to set up the ledger
// Swipe left → screen 3, swipe right → screen 1
// Both Back and Continue buttons are active here
// ─────────────────────────────────────────────

class Welcomescreen2 extends StatelessWidget {
  const Welcomescreen2({super.key});

  // ── Freelio Brand Colors ──────────────────
  static const Color kPrimary       = Color(0xFF29B2FE); // Freelancer blue
  static const Color kBackground    = Color(0xFFFFFFFF); // clean white
  static const Color kTextPrimary   = Color(0xFF0A1628); // dark navy
  static const Color kTextSecondary = Color(0xFF1D5C97); // mid blue
  static const Color kDivider       = Color(0xFFBFE4FF); // soft blue divider
  // ─────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,

      // ── Bottom Navigation Buttons ──────────────────────────
      // Both Back and Continue are active on screen 2
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            // Back → goes to screen 1
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, "/welcomescreen1");
              },
              icon: const Icon(Icons.arrow_back_ios_new, size: 14),
              label: const Text("Back"),
              style: ElevatedButton.styleFrom(
                backgroundColor: kDivider,
                foregroundColor: kTextSecondary,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            // Continue → goes to screen 3
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, "/welcomescreen3");
              },
              icon: const Icon(Icons.arrow_forward_ios, size: 14),
              label: const Text("Continue"),
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimary,
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

        // Swipe gestures for navigation
        onHorizontalDragEnd: (details) {
          final velocity = details.primaryVelocity ?? 0;

          // Swipe LEFT → next screen
          if (velocity < -300) {
            Navigator.pushNamed(context, "/welcomescreen3");
          }

          // Swipe RIGHT → previous screen
          else if (velocity > 300) {
            Navigator.pop(context);
          }
        },

        child: Stack(
          children: [

            // ── Center Content ─────────────────────────────────
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    // Small blue icon above the heading for visual interest
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: kPrimary.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.tune_rounded,
                        color: kPrimary,
                        size: 32,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Main heading
                    Text(
                      "Let's Set Up\nthe Ledger",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: kTextPrimary,   // dark navy
                        letterSpacing: 0.5,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Subheading — sets expectation for next steps
                    Text(
                      "A few quick details and\nyou'll be ready to go",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: kTextSecondary, // mid blue
                        letterSpacing: 0.3,
                        height: 1.6,
                      ),
                    ),

                  ],
                ),
              ),
            ),
            // ────────────────────────────────────────────────────

            // ── Page Indicator Dots ────────────────────────────
            // Screen 2 → activeIndex = 1
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  const int activeIndex = 1; // this is screen 2
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