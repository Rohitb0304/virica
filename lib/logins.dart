import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFF190019),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 100),
              child: SizedBox(
                width: 178.5124053955078,
                height: 200,
                child: Image(
                  image: AssetImage('assets/images/virica_logo.png'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: SizedBox(height: 10),
            ),
            _buildButton("LOGIN", Icons.login, () {
              Navigator.pushNamed(context, '/sos_homepage'); // Navigate to Signin page
            }),

            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: SizedBox(height: 10),
            ),
            _buildButton("CREATE AN ACCOUNT", Icons.person_add, () {
              Navigator.pushNamed(context, '/signup'); // Navigate to Signup page
            }),

            Padding(
              padding: const EdgeInsets.all(50),
              child: SizedBox(height: 10),
            ),
            Stack(
              children: [
                Center(
                  child: Container(
                    width: 180,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0xffFF0000),
                    ),
                    child: Center(
                      child: Container(
                        width: 160,
                        height: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: Color(0xffFBE4d8),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            launch('tel:112'); // Navigate to SOS page
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Text(
                              "Dial SOS",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Color(0xffFF0000),
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            onPrimary: Colors.transparent,
                            elevation: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: Colors.white,
          ),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ],
      ),
      style: ElevatedButton.styleFrom(
        primary: Color(0xffdfb6b2),
        onPrimary: Color(0xFF854F6C),
        minimumSize: Size(261, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
