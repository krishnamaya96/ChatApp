
import 'dart:async';
import 'package:chat_app/Screen/mobile_verification.dart';
import 'package:chat_app/Screen/otp_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyPhoneNumber {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendVerificationCode(String number) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          print('Phone number automatically verified and user signed in: ${FirebaseAuth.instance.currentUser}');
        },
        verificationFailed: (FirebaseAuthException e) {
          Fluttertoast.showToast(
            msg: "Verification failed: ${e.message}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Get.off(() => MobileVerification());
          print('Verification failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.setString("verificationId", verificationId);
          Get.to(() => OtpPage());
          print('Verification code sent to $number');
        },
        timeout: Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {
          print('Auto retrieval timeout: $verificationId');
        },
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "An error occurred: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print('An error occurred: $e');
    }
  }

  Future<void> verifyOtp(String otp, VoidCallback onSuccess, VoidCallback onFailure) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? verificationId = preferences.getString("verificationId");

    if (verificationId == null) {
      Fluttertoast.showToast(
        msg: "No verification ID found. Please request a new code.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      onFailure();
      return;
    }

    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      print('OTP verified and user signed in.');
      onSuccess();
      _storeUserData();
    } catch (e) {
      Fluttertoast.showToast(
        msg: "OTP verification failed: ${e.toString()}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      onFailure();
      print('OTP verification failed: ${e.toString()}');
    }
  }

  void _storeUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('user').doc(user.uid).set({
        'name' : user.photoURL,
        'uid': user.uid,
        'phoneNumber': user.phoneNumber,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }
}


