import 'package:flutter/material.dart';
import 'package:freelio/Screens/DashBoardScreen.dart';
import 'package:freelio/Screens/WelcomeScreen1.dart';
import 'package:freelio/Screens/WelcomeScreen2.dart';
import 'package:freelio/Screens/WelcomeScreen3.dart';

void main() {
  runApp(const Freelio());
}

class Freelio extends StatelessWidget {
  const Freelio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,


      routes: {
        "/": (context) => const Welcomescreen1(),
        "/welcomescreen2": (context) => const Welcomescreen2(),
        "/dashboard": (context) => const Dashboardscreen(),
        "/welcomescreen3": (context) => const Welcomescreen3(),
      },
    );
  }
}