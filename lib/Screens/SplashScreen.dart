import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ─────────────────────────────────────────────
// SplashScreen — First screen the user sees
// Shows logo + app name for 3 seconds,
// then decides where to send the user next
// ─────────────────────────────────────────────

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {

  // Animation controller for the logo fade+scale entrance
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  // ── Freelio Brand Colors ──────────────────
  static const Color kPrimary        = Color(0xFF29B2FE); // Freelancer blue
  static const Color kBackground     = Color(0xFFFFFFFF); // clean white background
  static const Color kSurface        = Color(0xFFE8F6FF); // light blue tint for circle
  static const Color kTextPrimary    = Color(0xFF0A1628); // dark navy for text
  static const Color kTextSecondary  = Color(0xFF1D5C97); // mid blue for tagline
  // ─────────────────────────────────────────

  @override
  void initState() {
    super.initState();

    // Set up the fade + scale animation (runs once on load)
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeIn),
    );

    _scaleAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutBack),
    );

    // Start the animation immediately
    _animController.forward();

    // After 3 seconds, figure out where to route the user
    Future.delayed(const Duration(seconds: 5), () {
      checkAppFlow();
    });
  }

  @override
  void dispose() {
    // Always dispose animation controllers to avoid memory leaks
    _animController.dispose();
    super.dispose();
  }

  // ─────────────────────────────────────────────
  // checkAppFlow — Decides which screen comes next
  //
  // 3 possible outcomes:
  //   1. No username or rate saved → /welcomescreen1  (first time user)
  //   2. Lock is set               → /lockscreen      (returning, locked)
  //   3. Everything ready          → /dashboard       (returning, unlocked)
  // ─────────────────────────────────────────────
  Future<void> checkAppFlow() async {
    final prefs = await SharedPreferences.getInstance();

    String? name     = prefs.getString("username");
    double? rate     = prefs.getDouble("hourly_rate");
    bool isLockSet   = prefs.getBool("is_lock_set") ?? false;

    // ❌ First time user — hasn't set up their profile yet
    if (name == null || rate == null) {
      Navigator.pushReplacementNamed(context, "/welcomescreen1");
      return;
    }

    // 🔐 User set a PIN/lock — send them to unlock first
    if (isLockSet) {
      Navigator.pushReplacementNamed(context, "/lockscreen");
      return;
    }

    // ✅ All good — go straight to the dashboard
    Navigator.pushReplacementNamed(context, "/dashboard");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // White background — clean Freelio brand
      backgroundColor: kBackground,

      body: FadeTransition(
        opacity: _fadeAnim,
        child: ScaleTransition(
          scale: _scaleAnim,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // ── Logo Container ──────────────────────
                Container(
                  child: Image.asset(
                    "Assets/Images/SplashScreenImg.png",
                    height: 110,
                  ),
                ),
                // ───────────────────────────────────────

                const SizedBox(height: 36),

                // ── App Name ────────────────────────────
                Text(
                  "Freelio",
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w700,
                    color: kPrimary,       // Freelancer blue
                    letterSpacing: 1.8,
                  ),
                ),
                // ───────────────────────────────────────

                const SizedBox(height: 8),

                // ── Tagline ─────────────────────────────
                Text(
                  "Track. Manage. Earn.",
                  style: TextStyle(
                    fontSize: 13,
                    color: kTextSecondary, // mid blue
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // ───────────────────────────────────────

                const SizedBox(height: 60),

                // ── Loading Indicator ───────────────────
                // Thin blue spinner — feels alive while routing
                SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    color: kPrimary,
                    strokeWidth: 2,
                  ),
                ),
                // ───────────────────────────────────────

                const SizedBox(height: 16),

                // ── Small bottom label ──────────────────
                Text(
                  "your freelance ledger",
                  style: TextStyle(
                    fontSize: 11,
                    color: kTextSecondary.withOpacity(0.6),
                    letterSpacing: 1.2,
                  ),
                ),
                // ───────────────────────────────────────

              ],
            ),
          ),
        ),
      ),
    );
  }
}