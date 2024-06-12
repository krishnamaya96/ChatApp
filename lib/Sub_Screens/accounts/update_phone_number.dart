import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdatePhoneNumberScreen extends StatefulWidget {
  @override
  _UpdatePhoneNumberScreenState createState() => _UpdatePhoneNumberScreenState();
}

class _UpdatePhoneNumberScreenState extends State<UpdatePhoneNumberScreen> {
  final TextEditingController _newPhoneNumberController = TextEditingController();
  final TextEditingController _smsCodeController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;

  void _verifyNewPhoneNumber() async {
    final String newPhoneNumber = _newPhoneNumberController.text.trim();

    await _auth.verifyPhoneNumber(
      phoneNumber: newPhoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.currentUser?.updatePhoneNumber(credential);
        print("Phone number automatically updated");
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Phone number update verification failed. Code: ${e.code}. Message: ${e.message}");
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

  void _updatePhoneNumber() async {
    final String smsCode = _smsCodeController.text.trim();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: smsCode,
    );

    try {
      await _auth.currentUser?.updatePhoneNumber(credential);
      print("Phone number successfully updated");
    } catch (e) {
      print("Failed to update phone number: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Phone Number')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _newPhoneNumberController,
              decoration: InputDecoration(labelText: 'New Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifyNewPhoneNumber,
              child: Text('Verify New Phone Number'),
            ),
            TextField(
              controller: _smsCodeController,
              decoration: InputDecoration(labelText: 'Verification Code'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updatePhoneNumber,
              child: Text('Update Phone Number'),
            ),
          ],
        ),
      ),
    );
  }
}
