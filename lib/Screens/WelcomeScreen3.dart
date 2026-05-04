import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

// ─────────────────────────────────────────────
// WelcomeScreen3 — Profile Setup screen
// (Screen 3 of 5 in the welcome flow)
//
// User enters:
//   • Profile photo (from gallery)
//   • Username
//   • Hourly rate
//
// Data is saved to SharedPreferences
// Submit button validates + saves, then goes to screen 4
// LoadData() pre-fills fields if user already set these up before
// ─────────────────────────────────────────────

class Welcomescreen3 extends StatefulWidget {
  const Welcomescreen3({super.key});

  @override
  State<Welcomescreen3> createState() => _Welcomescreen3State();
}

class _Welcomescreen3State extends State<Welcomescreen3> {

  // ── Freelio Brand Colors ──────────────────
  static const Color kPrimary       = Color(0xFF29B2FE); // Freelancer blue
  static const Color kBackground    = Color(0xFFFFFFFF); // clean white
  static const Color kSurface       = Color(0xFFE8F6FF); // light blue tint
  static const Color kTextPrimary   = Color(0xFF0A1628); // dark navy
  static const Color kTextSecondary = Color(0xFF1D5C97); // mid blue
  static const Color kDivider       = Color(0xFFBFE4FF); // soft blue divider
  // ─────────────────────────────────────────

  // ── Controllers & Focus Nodes ─────────────
  TextEditingController Username    = TextEditingController();
  TextEditingController Hourly_Rate = TextEditingController();
  final nameFocus = FocusNode();
  final rateFocus = FocusNode();
  // ─────────────────────────────────────────

  // ── Image State ───────────────────────────
  File? imageFile;
  final picker = ImagePicker();
  // ─────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    LoadData();
  }

  // ── pickImage ─────────────────────────────
  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    final tempImage = File(picked.path);

    setState(() {
      imageFile = tempImage;
    });

    await saveImageLocally(tempImage);
  }

  // ── saveImageLocally ──────────────────────
  Future<void> saveImageLocally(File image) async {
    final dir      = await getApplicationDocumentsDirectory();
    final fileName = image.path.split('/').last;
    final savedImage = await image.copy('${dir.path}/$fileName');

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image', savedImage.path);
  }

  @override
  void dispose() {
    nameFocus.dispose();
    rateFocus.dispose();
    Username.dispose();
    Hourly_Rate.dispose();
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

            // Back → goes to screen 2
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, "/welcomescreen2");
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
            Navigator.pushNamed(context, "/welcomescreen4");
          } else if (velocity > 300) {
            Navigator.pop(context);
          }
        },

        child: Stack(
          children: [

            // ── Main Form Content ──────────────────────────────
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // ── Profile Photo Picker ─────────────────────
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 54,
                        backgroundColor: kSurface,
                        backgroundImage: imageFile != null
                            ? FileImage(imageFile!)
                            : AssetImage("Assets/Images/ProfileImagePlaceholder.jpg")
                        as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: kPrimary,         // blue edit button
                            shape: BoxShape.circle,
                            border: Border.all(color: kBackground, width: 2),
                          ),
                          child: IconButton(
                            onPressed: pickImage,
                            icon: const Icon(Icons.edit, size: 16),
                            color: Colors.white,
                            padding: const EdgeInsets.all(6),
                            constraints: const BoxConstraints(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // ─────────────────────────────────────────────

                  const SizedBox(height: 8),

                  Text(
                    "Tap pencil to change photo",
                    style: TextStyle(
                      fontSize: 11,
                      color: kTextSecondary.withOpacity(0.6),
                    ),
                  ),

                  // ── Username Field ───────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                    child: TextField(
                      focusNode: nameFocus,
                      controller: Username,
                      keyboardType: TextInputType.name,
                      style: TextStyle(color: kTextPrimary),
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.person_outline, color: kPrimary),
                        labelText: "Username",
                        labelStyle: TextStyle(color: kTextSecondary),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Enter your name",
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
                  ),
                  // ─────────────────────────────────────────────
                  const SizedBox(height: 22),

                  // ── Hourly Rate Field ────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                    child: TextField(
                      focusNode: rateFocus,
                      controller: Hourly_Rate,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: kTextPrimary),
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.attach_money, color: kPrimary),
                        labelText: "Hourly Rate",
                        labelStyle: TextStyle(color: kTextSecondary),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Enter your hourly rate",
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
                  ),
                  // ─────────────────────────────────────────────

                  const SizedBox(height: 28),

                  // ── Submit Button ────────────────────────────
                  ElevatedButton.icon(
                    onPressed: () async {
                      final name     = Username.text.trim();
                      final rateText = Hourly_Rate.text.trim();

                      if (name.isEmpty) {
                        FocusScope.of(context).requestFocus(nameFocus);
                        return;
                      }

                      if (rateText.isEmpty) {
                        FocusScope.of(context).requestFocus(rateFocus);
                        return;
                      }

                      final rate = double.tryParse(rateText);
                      if (rate == null) {
                        FocusScope.of(context).requestFocus(rateFocus);
                        return;
                      }

                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('username', name);
                      await prefs.setDouble('hourly_rate', rate);

                      Navigator.pushNamed(context, "/welcomescreen4");
                    },
                    icon: const Icon(Icons.check_rounded, size: 18),
                    label: const Text(
                      "Save & Continue",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  // ─────────────────────────────────────────────

                ],
              ),
            ),
            // ────────────────────────────────────────────────────

            // ── Page Indicator Dots ────────────────────────────
            // Screen 3 → activeIndex = 2
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  const int activeIndex = 2;
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

  // ── LoadData ───────────────────────────────────────────────
  void LoadData() async {
    var prefs     = await SharedPreferences.getInstance();
    var imagePath = prefs.getString("profile_image");
    var name      = prefs.getString("username");
    var rate      = prefs.getDouble("hourly_rate");

    setState(() {
      if (name != null)  Username.text    = name;
      if (rate != null)  Hourly_Rate.text = rate.toString();

      if (imagePath != null && File(imagePath).existsSync()) {
        imageFile = File(imagePath);
      }
    });
  }
}