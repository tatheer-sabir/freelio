import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ─────────────────────────────────────────────
// WelcomeScreen4 — App Lock Setup screen
// (Screen 4 of 5 in the welcome flow)
//
// User sets an optional PIN/password lock for the app
// If they skip → goes to screen 5 without saving any lock
// If they set it → saves password + is_lock_set flag, then screen 5
// On next app open, splash will detect is_lock_set and route to lockscreen
// ─────────────────────────────────────────────

class Welcomescreen4 extends StatefulWidget {
  const Welcomescreen4({super.key});

  @override
  State<Welcomescreen4> createState() => _Welcomescreen4State();
}

class _Welcomescreen4State extends State<Welcomescreen4> {

  // ── Freelio Brand Colors ──────────────────
  static const Color kPrimary       = Color(0xFF29B2FE); // Freelancer blue
  static const Color kBackground    = Color(0xFFFFFFFF); // clean white
  static const Color kSurface       = Color(0xFFE8F6FF); // light blue tint
  static const Color kTextPrimary   = Color(0xFF0A1628); // dark navy
  static const Color kTextSecondary = Color(0xFF1D5C97); // mid blue
  static const Color kDivider       = Color(0xFFBFE4FF); // soft blue divider
  // ─────────────────────────────────────────

  // ── Controllers & Focus Nodes ─────────────
  TextEditingController Password    = TextEditingController();
  TextEditingController ConformPass = TextEditingController();
  FocusNode password    = FocusNode();
  FocusNode conformPass = FocusNode();
  // ─────────────────────────────────────────

  // ── Visibility Toggles ────────────────────
  bool PassVisible          = true;
  bool ConformPassVisibility = true;
  // ─────────────────────────────────────────

  @override
  void dispose() {
    Password.dispose();
    ConformPass.dispose();
    password.dispose();
    conformPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      resizeToAvoidBottomInset: false,

      // ── Bottom Navigation Buttons ──────────────────────────
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            // Back → screen 3
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, "/welcomescreen3");
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

            // Skip → screen 5 (no lock set)
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, "/welcomescreen5");
              },
              icon: const Icon(Icons.arrow_forward_ios, size: 14),
              label: const Text("Skip"),
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
            Navigator.pushNamed(context, "/welcomescreen5");
          } else if (velocity > 300) {
            Navigator.pop(context);
          }
        },

        child: Stack(
          children: [

            // ── Main Form Content ──────────────────────────────
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    // Lock icon
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: kPrimary.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.lock_outline_rounded,
                        color: kPrimary,
                        size: 32,
                      ),
                    ),

                    const SizedBox(height: 16),

                    Text(
                      "Set App Lock",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: kTextPrimary,
                        letterSpacing: 0.5,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      "Optional — you can skip this step",
                      style: TextStyle(
                        fontSize: 13,
                        color: kTextSecondary.withOpacity(0.7),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ── Password Field ───────────────────────────
                    TextField(
                      obscureText: PassVisible,
                      obscuringCharacter: "•",
                      focusNode: password,
                      controller: Password,
                      keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(color: kTextPrimary),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              PassVisible = !PassVisible;
                            });
                          },
                          icon: Icon(
                            PassVisible ? Icons.visibility_off : Icons.visibility,
                            color: kTextSecondary,
                          ),
                        ),
                        labelText: "Password",
                        labelStyle: TextStyle(color: kTextSecondary),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Enter password",
                        hintStyle: TextStyle(color: kTextSecondary.withOpacity(0.4)),
                        filled: true,
                        fillColor: kSurface,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: kPrimary, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: kDivider, width: 1),
                        ),
                      ),
                    ),
                    // ─────────────────────────────────────────────

                    const SizedBox(height: 22),

                    // ── Confirm Password Field ───────────────────
                    TextField(
                      obscureText: ConformPassVisibility,
                      obscuringCharacter: "•",
                      focusNode: conformPass,
                      controller: ConformPass,
                      keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(color: kTextPrimary),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              ConformPassVisibility = !ConformPassVisibility;
                            });
                          },
                          icon: Icon(
                            ConformPassVisibility ? Icons.visibility_off : Icons.visibility,
                            color: kTextSecondary,
                          ),
                        ),
                        labelText: "Confirm Password",
                        labelStyle: TextStyle(color: kTextSecondary),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Retype password",
                        hintStyle: TextStyle(color: kTextSecondary.withOpacity(0.4)),
                        filled: true,
                        fillColor: kSurface,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: kPrimary, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: kDivider, width: 1),
                        ),
                      ),
                    ),
                    // ─────────────────────────────────────────────

                    const SizedBox(height: 28),

                    // ── Set Password Button ──────────────────────
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          savePassword();
                        },
                        icon: const Icon(Icons.lock_rounded, size: 18),
                        label: const Text(
                          "Set Lock",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    // ─────────────────────────────────────────────

                  ],
                ),
              ),
            ),
            // ────────────────────────────────────────────────────

            // ── Page Indicator Dots ────────────────────────────
            // Screen 4 → activeIndex = 3
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  const int activeIndex = 3;
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

  // ── savePassword ───────────────────────────────────────────
  Future<void> savePassword() async {

    if (Password.text.isEmpty || ConformPass.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Fields cannot be empty"),
          backgroundColor: kPrimary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    if (Password.text != ConformPass.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Passwords do not match"),
          backgroundColor: kPrimary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("app_password", Password.text);
    await prefs.setBool("is_lock_set", true);

    Navigator.pushNamed(context, "/welcomescreen5");
  }
}