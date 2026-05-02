import 'package:flutter/material.dart';
import 'package:freelio/Screens/DashBoardScreen.dart';
import 'package:freelio/Screens/WelcomeScreen1.dart';
import 'package:freelio/Screens/WelcomeScreen2.dart';
import 'package:freelio/Screens/WelcomeScreen3.dart';
import 'package:freelio/Screens/ClientListScreen.dart';
import 'package:freelio/Screens/ProjectListScreen.dart';
import 'package:freelio/Screens/PaymentScreen.dart';
import 'package:freelio/Screens/Notification.dart';
import 'package:freelio/Screens/contactus.dart';
import 'package:freelio/Screens/Sharewithfriend.dart';


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
        "/dashboard": (context) => DashboardScreen(),
        "/welcomescreen3": (context) => const Welcomescreen3(),
        "/clientpage":(context)=>const ClientListScreen(),
        "/projectpage":(context)=> const Projectlistscreen(),
        "/payement":(context)=>const PaymentScreen(),
        "/notifications":(context)=> const NotificationsPage(),
        "/contactus":(context)=> const ContactUsScreen(),
        "/sharing":(context)=> const ShareScreen(),
      },
    );
  }
}