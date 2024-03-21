import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late User _user;
  String? name;
  String? email;
  String? dob;
  String? mobileNumber;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser!;
    _loadUserData();
  }

  Future<void> _loadUserData() async {
  try {
    // Use the user's UID as the document ID
    DocumentSnapshot<Map<String, dynamic>> userData =
        await _firestore.collection('users').doc(_user.uid).get();

    // Check if the document exists
    if (userData.exists) {
      setState(() {
        name = userData['name'];
        email = userData['email'];
        dob = userData['dob'];
        mobileNumber = userData['mobileNumber'];
      });
    } else {
      // Handle the case where the document doesn't exist
      print('User document does not exist for UID: ${_user.uid}');
    }
  } catch (e) {
    // Handle errors, e.g., show an error message
    print('Error loading user data: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Color(0xFF190019),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/homepage');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Display user icon or image (if available)
            CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            SizedBox(height: 16),
            Text('Name: ${name ?? ''}'),
            Text('Email: ${email ?? ''}'),
            Text('Date of Birth: ${dob ?? ''}'),
            Text('Mobile Number: ${mobileNumber ?? ''}'),
          ],
        ),
      ),
    );
  }
}
