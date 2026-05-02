import 'package:flutter/material.dart';

class Welcomescreen2 extends StatelessWidget {
  const Welcomescreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // 🔻 Bottom Buttons
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, "/");
              },
              icon: const Icon(Icons.skip_previous),
              label: const Text("Back"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade300,
                foregroundColor: Colors.black,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, "/dashboard");
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text("Continue"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.black,
              ),
            ),
          ],
        ),
      ),

      // 🔻 Body
      body: GestureDetector(
        behavior: HitTestBehavior.opaque, // 👈 IMPORTANT

        onHorizontalDragEnd: (details) {

          final velocity = details.primaryVelocity ?? 0;

          // Swipe LEFT → NEXT
          if (velocity < -300) {
            Navigator.pushNamed(context, "/dashboard");
          }

          // Swipe RIGHT → BACK
          else if (velocity > 300) {
            Navigator.pop(context);
          }
        },
        child: Stack(
          children: [

            // ✅ Centered Text Content
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    "Let Set up the ledger",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      letterSpacing: 1.2,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "to be ready to use",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),

            // ✅ Bottom Center Dots Indicator
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  int activeIndex = 1; // change this later dynamically

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: index == activeIndex ? 10 : 8,
                    height: index == activeIndex ? 10 : 8,
                    decoration: BoxDecoration(
                      color:
                      index == activeIndex ? Colors.teal : Colors.grey,
                      shape: BoxShape.circle,
                      boxShadow: index == activeIndex
                          ? [
                        BoxShadow(
                          color: Colors.pink.withOpacity(0.7),
                          blurRadius: 6,
                          spreadRadius: 1,
                        )
                      ]
                          : [],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
