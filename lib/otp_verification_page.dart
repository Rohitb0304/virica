import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpVerificationPage extends StatefulWidget {
  final String verificationId;
  final String mobileNumber;
  final Function onVerificationSuccess;

  const OtpVerificationPage({
    required this.verificationId,
    required this.mobileNumber,
    required this.onVerificationSuccess,
  });

  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  TextEditingController _otpController = TextEditingController();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF190019),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'OTP Verification',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  fillColor: Color(0xfffbe4d8),
                  filled: true,
                  labelText: 'Enter OTP',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
            SizedBox(height: 10),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                // Validate the entered OTP and perform necessary actions
                String enteredOtp = _otpController.text.trim();
                try {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: enteredOtp,
                  );

                  await FirebaseAuth.instance.signInWithCredential(credential);
                  widget.onVerificationSuccess();
                } catch (e) {
                  // Show an alert or message for invalid OTP
                  if (e is FirebaseAuthException && e.code == 'invalid-verification-code') {
                    // Display a user-friendly message for invalid OTP
                    setState(() {
                      _errorMessage = 'Invalid OTP: Please enter the correct OTP.';
                    });
                  } else {
                    // Handle other errors or display a generic message
                    setState(() {
                      _errorMessage = 'Error verifying OTP. Please try again.';
                    });
                  }
                }
              },
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }
}
