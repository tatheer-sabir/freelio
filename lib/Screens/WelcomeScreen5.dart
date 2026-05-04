import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
// WelcomeScreen5 — All Done / Celebration screen
// (Screen 5 of 5 — final screen in welcome flow)
//
// User has completed setup — username, rate, optional lock
// Finish button → goes to /dashboard (main app)
// Swipe left also goes to dashboard
// This screen is never shown again after first launch
// ─────────────────────────────────────────────

class Welcomescreen5 extends StatelessWidget {
  const Welcomescreen5({super.key});

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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            // Back → screen 4
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, "/welcomescreen4");
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

            // Finish → launches into the actual app
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context,
                    "/dashboard",
                      (route) => false,
                );
              },
              icon: const Icon(Icons.check_rounded, size: 16),
              label: const Text(
                "Let's Go",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimary,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
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

        onHorizontalDragEnd: (details) {
          final velocity = details.primaryVelocity ?? 0;

          if (velocity < -300) {
            Navigator.pushNamedAndRemoveUntil(
                context,
                "/dashboard",
                (route) => false,
            );
          } else if (velocity > 300) {
            Navigator.pop(context);
          }
        },

        child: Stack(
          children: [

            // ── Center Celebration Content ─────────────────────
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  // Checkmark celebration icon
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: kPrimary.withOpacity(0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: kPrimary.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_rounded,
                        color: kPrimary,
                        size: 40,
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  Text(
                    "Congratulations!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: kTextPrimary,
                      letterSpacing: 0.5,
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "You're all set up",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: kTextSecondary,
                      letterSpacing: 0.4,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Freelio is ready to track your work",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: kTextSecondary.withOpacity(0.6),
                      letterSpacing: 0.2,
                    ),
                  ),

                  const SizedBox(height: 36),

                  // ── Mini summary of what was set up ───────────
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      color: kSurface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: kDivider, width: 1),
                    ),
                    child: Column(
                      children: [
                        _summaryRow(Icons.person_outline_rounded, "Profile saved"),
                        const SizedBox(height: 10),
                        _summaryRow(Icons.attach_money_rounded, "Hourly rate set"),
                        const SizedBox(height: 10),
                        _summaryRow(Icons.lock_outline_rounded, "App lock configured"),
                      ],
                    ),
                  ),
                  // ─────────────────────────────────────────────

                ],
              ),
            ),
            // ────────────────────────────────────────────────────

            // ── Page Indicator Dots ────────────────────────────
            // Screen 5 → activeIndex = 4 (last dot)
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  const int activeIndex = 4;
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

  // ── _summaryRow ────────────────────────────────────────────
  Widget _summaryRow(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: kPrimary, size: 18),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF1D5C97), // mid blue — updated from old warm brown
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}