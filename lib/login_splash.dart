import 'package:flutter/material.dart';
import 'package:virica/sos_homepage.dart'; // 

class Login_splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Delayed navigation to LoginsScreen after 3 seconds
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SOSHomepage()),
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
