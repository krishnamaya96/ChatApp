// import 'package:chat_app/FireBase/phoneNumber_firebase.dart';
// import 'package:chat_app/Screen/chat_page.dart';
// import 'package:chat_app/Screen/get_user_data.dart';
// import 'package:chat_app/Screen/mobile_verification.dart';
// import 'package:chat_app/Screen/update_page.dart';
// import 'package:chat_app/Screen/user_info.dart';
// import 'package:chat_app/Screen/welcome_page.dart';
// import 'package:chat_app/elements/bottom_nav.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
//
// class loginController extends GetxController{
//
//   TextEditingController numberController = TextEditingController();
//   TextEditingController otpController = TextEditingController();
//   String code = "+91";
//   RxString numberError = "".obs;
//   RxString pinError = "".obs;
//   FirebaseAuth auth = FirebaseAuth.instance ;
//   verifyPhoneNumber verifyPhone =verifyPhoneNumber();
//   late String number;
//   RxBool isLoading = RxBool(false);
//
//   @override
//   void onClose() {
//     super.onClose();
//     numberController.dispose();
//     otpController.dispose();
//   }
//
//   void sendOtp() async {
//     if(numberController.text.isEmpty){
//       numberError("Fiels is required**");
//     }
//     else if(numberController.text.length<10){
//       numberError.value = "Invalid Number";
//     }
//     else{
//       numberError("");
//       number = code + numberController.text;
//       await verifyPhone.sendVerificationCode(number);
//     }
//   }
//
//   void verifyOtp() async {
//     if(otpController.text.isEmpty){
//       pinError("Field is required**");
//     }
//     else if(otpController.text.length<6){
//       pinError.value = "Invalid Pin";
//     }
//     else{
//       isLoading.value = true;
//       await verifyPhone.verifyOtp(otpController.text,
//       );
//
//       // isLoading.value = false;
//       // Get.off(UserInfoScreen());
//
//
//     }
//   }
// }



import 'package:chat_app/FireBase/phoneNumber_firebase.dart';
import 'package:chat_app/Screen/chat_page.dart';
import 'package:chat_app/Screen/get_user_data.dart';
import 'package:chat_app/Screen/introduction_screen.dart';
import 'package:chat_app/Screen/mobile_verification.dart';
import 'package:chat_app/Screen/update_page.dart';
import 'package:chat_app/Screen/user_info.dart';
import 'package:chat_app/Screen/welcome_page.dart';
import 'package:chat_app/elements/bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController numberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  String code = "+91";
  RxString numberError = "".obs;
  RxString pinError = "".obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  VerifyPhoneNumber verifyPhone = VerifyPhoneNumber();
  late String number;
  RxBool isLoading = RxBool(false);

  @override
  void onClose() {
    super.onClose();
    numberController.dispose();
    otpController.dispose();
  }

  void sendOtp() async {
    if (numberController.text.isEmpty) {
      numberError("Field is required**");
    } else if (numberController.text.length < 10) {
      numberError.value = "Invalid Number";
    } else {
      numberError("");
      number = code + numberController.text;
      await verifyPhone.sendVerificationCode(number);
    }
  }

  void verifyOtp() async {
    if (otpController.text.isEmpty) {
      pinError("Field is required**");
    } else if (otpController.text.length < 6) {
      pinError.value = "Invalid Pin";
    } else {
      isLoading.value = true;
      await verifyPhone.verifyOtp(
        otpController.text,
            () {
          isLoading.value = false;
          Get.off(() => UserInfoScreen());
        },
            () {
          isLoading.value = false;
          Get.off(() => IntroductionScreen());
        },
      );
    }
  }
}

