import 'package:flutter/material.dart';
import 'package:freelio/Screens/DashBoardScreen.dart';

void main(){
  runApp(freelio());
}

class freelio extends StatelessWidget {
  const freelio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Text("Tatheer and Umara"),
      ),
      // routes: {
      //   "/" : (context) => Dashboardscreen(),
      // //   Add the routes as needed
      // },

    );
  }
}
