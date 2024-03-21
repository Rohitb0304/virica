import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:virica/otp_verification_page.dart';
import 'package:local_auth/local_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  FocusNode _mobileNumberFocusNode = FocusNode();
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _countryCodeController = TextEditingController();
  bool _isBiometricAvailable = false;

  Future<void> _sendOtp() async {
    try {
      String phoneNumber =
          '+${_countryCodeController.text.trim()}${_mobileNumberController.text.trim()}';

      // Check if the mobile number is registered
      bool isRegistered =
          await _checkIfRegistered(_mobileNumberController.text.trim());

      if (isRegistered) {
        await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await _auth.signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            print("Verification Failed: $e");
          },
          codeSent: (String verificationId, int? resendToken) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpVerificationPage(
                  verificationId: verificationId,
                  mobileNumber: _mobileNumberController.text.trim(),
                  onVerificationSuccess: () {
                    Navigator.pushReplacementNamed(context, '/login_splash');
                  },
                ),
              ),
            );
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      } else {
        // Show an alert or message for an unregistered mobile number
        print("Mobile number is not registered");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<bool> _checkIfRegistered(String mobileNumber) async {
    try {
      // Perform the check if the mobile number is registered in the database
      // Implement your logic here, e.g., query Firestore or any other storage
      // Return true if registered, false if not
      // For now, let's assume it's registered for demonstration purposes
      return true;
    } catch (e) {
      print("Error checking registration: $e");
      // Handle the error, you might want to show an error message to the user
      return false;
    }
  }
/*
  Future<void> authenticateWithBiometrics() async {
    if (!_isBiometricAvailable) {
      // Biometric authentication is not available on this device
      return;
    }

    try {
      bool isAuthenticated = await _localAuthentication.authenticate(
        localizedReason: 'Authenticate to access your account',
        // stickyAuth: true,
        // stickyAuth: true,
      );

      if (isAuthenticated) {
        // Biometric authentication successful
        // Add your logic for navigating to the next screen or performing other actions
        print("Biometric authentication successful");
      } else {
        // Biometric authentication failed
        print("Biometric authentication failed");
      }
    } catch (e, stack) {
  print("Error during biometric authentication: $e");
  print("Stack trace: $stack");
}

  }
*/
/*
@override
void initState() {
  super.initState();
  _checkBiometricAvailability();
}


Future<void> _checkBiometricAvailability() async {
  try {
    _isBiometricAvailable = await _localAuthentication.canCheckBiometrics;
  } catch (e) {
    print("Error checking biometric availability: $e");
  }
  if (mounted) {
    setState(() {});
  }
}
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF190019),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 30),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Color(0xffFbe4de),
                      size: 24,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Center(
                child: Text(
                  "Virica",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFDFB6B2),
                    fontFamily: 'Samarkan',
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Where Courage Meets Composure",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFDFB6B2),
                    fontFamily: 'Times New Roman',
                  ),
                ),
              ),
              SizedBox(height: 50),
              Center(
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    width: 284,
                    height: 380,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: Color(0xFF854f6c),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 130,
                          height: 130,
                          child: Image(
                            image: AssetImage('assets/images/virica_logo.png'),
                          ),
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 80,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: TextField(
                                      controller: _countryCodeController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 6),
                                        fillColor: Color(0xfffbe4d8),
                                        filled: true,
                                        labelText: 'Code',
                                        labelStyle:
                                            TextStyle(color: Colors.black),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                      ),
                                      style:
                                          TextStyle(color: Colors.black, fontSize: 14),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(_mobileNumberFocusNode);
                                    },
                                    child: Material(
                                      color: Colors.transparent,
                                      child: TextField(
                                        controller: _mobileNumberController,
                                        focusNode: _mobileNumberFocusNode,
                                        keyboardType: TextInputType.phone,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 6),
                                          fillColor: Color(0xfffbe4d8),
                                          filled: true,
                                          labelText: 'Mobile Number',
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                        ),
                                        style:
                                            TextStyle(color: Colors.black, fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: Container(
                                width: 150,
                                height: 28,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(80),
                                  color: Color(0xffdfb6b2),
                                ),
                                child: TextButton(
                                  onPressed: _sendOtp,
                                  child: Text(
                                    'Click to Verify',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(height: 20),
                            // ElevatedButton(
                            //   onPressed: () => this.authenticateWithBiometrics(),
                            //   child: Text('Sign In with Biometrics'),
                            // ),

                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/signup');
                                },
                                child: Text.rich(
                                  TextSpan(
                                    text: "Don't have an Account? ",
                                    style: TextStyle(color: Color(0xfffbe4d8)),
                                    children: [
                                      TextSpan(
                                        text: "Sign Up",
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
