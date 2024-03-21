import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virica/otp_verification_page.dart';
// import 'package:google_sign_in/google_sign_in.dart';


class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  

  bool _isChecked = false;
  FocusNode _nameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _dobFocusNode = FocusNode();
  FocusNode _mobileNumberFocusNode = FocusNode();

  TextEditingController _dobController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();

  DateTime? _selectedDate;

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _dobFocusNode.dispose();
    _mobileNumberFocusNode.dispose();
    _dobController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF190019),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
            SizedBox(height: 10),
            Center(
              child: Text(
                "Virica",
                style: TextStyle(
                  fontSize: 25,
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
            SizedBox(height: 10),
            Center(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    width: 284,
                    height: 553,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: Color(0xFF854f6c),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 110,
                          height: 110,
                          child: Image(
                            image: AssetImage('assets/images/virica_logo.png'),
                          ),
                        ),
                        Column(
                          children: [
                            _buildTextField(_nameController, _nameFocusNode, 'Full Name'),
                            SizedBox(height: 20),
                            _buildDateTextField(_dobController, 'Date of Birth'),
                            SizedBox(height: 20),
                            _buildTextField(_emailController, _emailFocusNode, 'Email'),
                            SizedBox(height: 20),
                            _buildMobileTextField(_mobileNumberController, _mobileNumberFocusNode, 'Mobile Number'),
                            SizedBox(height: 20),
                            _buildTermsAndConditions(),
                            SizedBox(height: 30),
                            _buildSignUpButton(),
                          ],
                        ),
                      ],
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

  Widget _buildTextField(TextEditingController controller, FocusNode focusNode, String labelText) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(focusNode);
      },
      child: Material(
        color: Colors.transparent,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            fillColor: Color(0xfffbe4d8),
            filled: true,
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildDateTextField(TextEditingController controller, String labelText) {
    return GestureDetector(
      onTap: () {
        _selectDate(context);
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            fillColor: Color(0xfffbe4d8),
            filled: true,
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildMobileTextField(TextEditingController controller, FocusNode focusNode, String labelText) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(focusNode);
      },
      child: Material(
        color: Colors.transparent,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            fillColor: Color(0xfffbe4d8),
            filled: true,
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Row(
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (value) {
            setState(() {
              _isChecked = value!;
            });
          },
        ),
        GestureDetector(
          onTap: () {
            // Open link to Terms and Conditions
          },
          child: Text(
            "I agree to the ",
            style: TextStyle(
              color: Color(0xFFFBE4D8),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            launch("https://rohitb0304.github.io/virica-terms-and-conditions/");
          },
          child: Text(
            "terms and conditions",
            style: TextStyle(
              color: Color(0xFFDFB6B2),
              fontWeight: FontWeight.bold,
              fontSize: 10,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpButton() {
    return Container(
      width: 100,
      height: 39,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(80),
        color: Color(0xffdfb6b2),
      ),
      child: TextButton(
        onPressed: () {
          _signUp();
        },
        child: Text(
          'SIGN UP',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ); 
  }

  Future<void> _signUp() async {
    try {
      if (_nameController.text.isEmpty ||
          _dobController.text.isEmpty ||
          _emailController.text.isEmpty ||
          _mobileNumberController.text.isEmpty ||
          !_isChecked) {
        // Show an alert or some feedback to the user about the missing fields
        print("Please fill in all the fields");
        return;
      }

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: 'a_password',
      );

      // Move OTP verification logic here
      await _sendOtpAndVerify();

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': _nameController.text,
        'email': _emailController.text,
        'dob': _dobController.text,
        'mobileNumber': _mobileNumberController.text,
      });

      Navigator.pushNamed(context, '/login_splash');
    } catch (e) {
    print("Error: $e");
    String errorMessage = "An error occurred during registration. Please try again.";

    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = "The email address is already in use by another account.";
          break;
        case 'phone-number-already-in-use':
          errorMessage = "The phone number is already in use by another account.";
          break;
        // Add more cases for other relevant error codes
      }
    }

    // Show the error message to the user
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Registration Error"),
        content: Text(errorMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}

Future<void> _sendOtpAndVerify() async {
    try {
      String phoneNumber = '+${_mobileNumberController.text.trim()}';

      // Verify phone number
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
                  // You can perform actions after OTP verification here              
                  print("OTP verification successful");
                },
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print("Error: $e");
    }
  }

Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _dobController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }
}
