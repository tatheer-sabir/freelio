import 'package:flutter/material.dart';

class Welcomescreen1 extends StatelessWidget {
  const Welcomescreen1({super.key});

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
              onPressed: null,
              icon: const Icon(Icons.skip_previous),
              label: const Text("Back"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade300,
                foregroundColor: Colors.black,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, "/welcomescreen2");
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
            Navigator.pushNamed(context, "/welcomescreen2");
          }


        },
        child: Stack(
          children: [

            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [

                  Text(
                    "Welcome to",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      letterSpacing: 1.2,
                    ),
                  ),

                  SizedBox(height: 6),

                  Text(
                    "Freelio",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: Colors.teal,
                      letterSpacing: 1.5,
                    ),
                  ),

                  SizedBox(height: 12),

                  Text(
                    "A Digital Ledger",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),

                  SizedBox(height: 4),

                  Text(
                    "for your Freelance",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),

                  Text(
                    "Career",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
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
                  int activeIndex = 0; // change this later dynamically

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
                          color: Colors.blue.withOpacity(0.7),
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