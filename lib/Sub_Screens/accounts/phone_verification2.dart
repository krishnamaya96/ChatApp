import 'package:chat_app/Sub_Screens/accounts/update_phone_number.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/src/get_main.dart';

class PhoneVerificationScreen extends StatefulWidget {
  @override
  _PhoneVerificationScreenState createState() => _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _smsCodeController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;

  // Function to validate phone number format
  bool _validatePhoneNumber(String phoneNumber) {
    // Simple regex for validating phone number format
    final regex = RegExp(r'^\+\d{10,13}$');
    return regex.hasMatch(phoneNumber);
  }

  void _verifyPhoneNumber() async {
    final String phoneNumber = _phoneController.text.trim();

    if (!_validatePhoneNumber(phoneNumber)) {
      print("Invalid phone number format");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid phone number format. Please include country code.')),
      );
      return;
    }

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieve or instant verification
        await _auth.signInWithCredential(credential);
        print("Phone number automatically verified and user signed in: ${_auth.currentUser?.uid}");
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Phone number verification failed. Code: ${e.code}. Message: ${e.message}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Phone number verification failed: ${e.message}')),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        print("Please check your phone for the verification code.");
        setState(() {
          _verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("Verification code: $verificationId");
        setState(() {
          _verificationId = verificationId;
        });
      },
    );
  }

  void _signInWithPhoneNumber() async {
    final String smsCode = _smsCodeController.text.trim();
    if (_verificationId == null) {
      print("Verification ID is null");
      return;
    }

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: smsCode,
    );

    try {
      await _auth.signInWithCredential(credential);
      print("Successfully signed in UID: ${_auth.currentUser?.uid}");
    } catch (e) {
      print("Failed to sign in: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Phone Verification')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone Number (with country code)'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifyPhoneNumber,
              child: Text('Verify Phone Number'),
            ),
            TextField(
              controller: _smsCodeController,
              decoration: InputDecoration(labelText: 'Verification Code'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed:(){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdatePhoneNumberScreen()));
              },
              child: Text('Update Number'),
            ),
          ],
        ),
      ),
    );
  }
}
