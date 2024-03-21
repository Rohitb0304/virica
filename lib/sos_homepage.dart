import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class SOSHomepage extends StatefulWidget {
  @override
  _SOSHomepageState createState() => _SOSHomepageState();
}

class _SOSHomepageState extends State<SOSHomepage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String firstName = '';

  @override
  void initState() {
    super.initState();
    _loadFirstName();
  }

  Future<void> _loadFirstName() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      final userData =
          await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      setState(() {
        firstName = userData.data()?['firstName'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF190019),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logout Button
                IconButton(
                  onPressed: () {
                    _firebaseAuth.signOut();
                    Navigator.pushNamed(context, '/signin');
                  },
                  icon: Icon(Icons.logout, color: Colors.white),
                ),
                // User's First Name
                _buildFirstNameWidget(),
              ],
            ),
            SizedBox(height: 30),
            Text(
              "Virica",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w400,
                color: Color(0xFFDFB6B2),
                fontFamily: 'Samarkan',
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/homepage');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffdfb6b2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
                primary: null,
              ),
              child: Container(
                width: 302,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  color: Color(0xffdfb6b2),
                ),
                child: Center(
                  child: Text(
                    "Click for more features",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF854F6C),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/e_contacts');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffdfb6b2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
                primary: null,
              ),
              child: Container(
                width: 302,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  color: Color(0xffdfb6b2),
                ),
                child: Center(
                  child: Text(
                    "emergency contacts",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF854F6C),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // _showSOSModalBottomSheet(context);
                launch('tel:112');
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                primary: Color(0xFFFF0000),
              ),
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 275,
                    height: 275,
                    decoration: BoxDecoration(
                      color: Color(0xFFFBE4D8),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          color: Color(0xFFFF0000),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "SOS",
                            style: TextStyle(
                                fontSize: 70,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFBE4D8)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFirstNameWidget() {
    return FutureBuilder<String>(
      future: _getFirstName(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              'Hi',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          );
        } else {
          final firstName = snapshot.data ?? '';
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              firstName.isNotEmpty ? 'Hi, $firstName' : 'Hi, $firstName',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          );
        }
      },
    );
  }

  Future<String> _getFirstName() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      final userData =
          await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      return userData.data()?['firstName'] ?? '';
    }
    return '';
  }

  void _showSOSModalBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(bottom: 40),
        child: Container(
          height: MediaQuery.of(context).size.height * 2,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  _dial112();
                  Navigator.pop(context); // Close the bottom sheet
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFFF0000),
                ),
                child: Text(
                  'Dial 112',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}


  void _dial112() async {
    const url = 'tel:112';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle the error
    }
  }

  void _callEmergencyContacts() {
    // Implement your logic to call emergency contacts
  }
}
