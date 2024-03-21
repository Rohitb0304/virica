import 'package:flutter/material.dart';
import 'package:virica/logins.dart'; // Importing the logins.dart file

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Delayed navigation to LoginsScreen after 3 seconds
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginsScreen()),
      );
    });

    return Scaffold(
      body: Container(
        color: Color(0xFF190019),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/virica_logo.png'),
                ),
              ],
            ),
            
          ),
          
        ),
      ),
    );
  }
}
