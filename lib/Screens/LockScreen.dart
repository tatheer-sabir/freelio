import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Lockscreen extends StatefulWidget {
  const Lockscreen({super.key});

  @override
  State<Lockscreen> createState() => _LockscreenState();
}

class _LockscreenState extends State<Lockscreen> {

  // ── Freelio Brand Colors ──────────────────
  static const Color kPrimary       = Color(0xFF29B2FE); // Freelancer blue
  static const Color kBackground    = Color(0xFFFFFFFF); // clean white
  static const Color kSurface       = Color(0xFFE8F6FF); // light blue tint
  static const Color kTextPrimary   = Color(0xFF0A1628); // dark navy
  static const Color kTextSecondary = Color(0xFF1D5C97); // mid blue
  static const Color kDivider       = Color(0xFFBFE4FF); // soft blue divider
  // ─────────────────────────────────────────

  bool PassVisible = true;
  TextEditingController Password = TextEditingController();

  @override
  void dispose() {
    Password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // ── Lock Icon ────────────────────────────────
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: kPrimary.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lock_outline_rounded,
                  color: kPrimary,
                  size: 36,
                ),
              ),
              // ────────────────────────────────────────────

              const SizedBox(height: 20),

              // ── App Name ─────────────────────────────────
              Text(
                "Freelio",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: kPrimary,
                  letterSpacing: 1.8,
                ),
              ),
              // ────────────────────────────────────────────

              const SizedBox(height: 6),

              Text(
                "Enter your password to continue",
                style: TextStyle(
                  fontSize: 13,
                  color: kTextSecondary.withOpacity(0.7),
                ),
              ),

              const SizedBox(height: 32),

              // ── Password Field ────────────────────────────
              TextField(
                obscureText: PassVisible,
                obscuringCharacter: "•",
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
                  hintText: "Enter your password",
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
              // ────────────────────────────────────────────

              const SizedBox(height: 24),

              // ── Unlock Button ─────────────────────────────
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final savedPassword = prefs.getString("app_password");

                    if (Password.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Please enter password"),
                          backgroundColor: kPrimary,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      );
                      return;
                    }

                    if (savedPassword == Password.text) {
                      Navigator.pushReplacementNamed(context, "/dashboard");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Wrong password"),
                          backgroundColor: Colors.redAccent,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.lock_open_rounded, size: 18),
                  label: const Text(
                    "Unlock",
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
              // ────────────────────────────────────────────

            ],
          ),
        ),
      ),
    );
  }
}