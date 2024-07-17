

import 'package:chat_app/Controller/login_Controller.dart';
import 'package:chat_app/Screen/chat_page.dart';
import 'package:chat_app/elements/bottom_nav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class OtpPage extends GetView<LoginController>{
   OtpPage({Key?key}) : super(key: key);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Obx(() =>LoadingOverlay(
        isLoading: controller.isLoading.value,
        progressIndicator: SpinKitRotatingPlain(
          color: Theme.of(context).primaryColor,
        ),
        child: Scaffold(
          body: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: (){
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(30),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.asset("assets/images/ver.jpg"),),),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Enter Otp that send to the number...",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: 24,right: 24,top: 40),
                              child: OtpTextField(
                               // controller: controller.otpController,
                                keyboardType: TextInputType.number,
                                numberOfFields: 6,
                                borderColor: Color(0xFF512DA8),
                                //set to true to show as box or false to show as dash
                                showFieldAsBox: true,
                                //runs when a code is typed in
                                onCodeChanged: (String code) {
                                  controller.otpController.text = code;
                                  //handle validation or checks here

                                },
                                //runs when every textfield is filled
                                onSubmit: (String verificationCode){
                                  controller.otpController.text = verificationCode;
                                  showDialog(
                                      context: context,
                                      builder: (context){
                                        return AlertDialog(
                                          title: Text("Verification Code"),
                                          content: Text('Code entered is $verificationCode'),
                                        );
                                      }
                                  );
                                }, // end onSubmit
                              ),),

                            //otp pin
                            // Padding(padding: EdgeInsets.only(left: 30,right: 30,top: 40),
                            // child: PinInputTextField(
                            //   pinLength: 6,
                            //   textInputAction: TextInputAction.done,
                            //   decoration: CirclePinDecoration(
                            //       strokeColorBuilder: FixedColorBuilder(
                            //         Theme.of(context).primaryColor
                            //       )),),)

                            Padding(
                              padding: EdgeInsets.only(
                                  left: 24,
                                  right: 24,
                                  bottom: 30,
                                  top: 40),
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [BoxShadow(
                                        offset: Offset(4,4),
                                        blurRadius: 10,
                                        color: Theme.of(context).disabledColor.withOpacity(0.1)
                                    )],
                                    color: Colors.greenAccent
                                ),
                                child: Material(
                                  color:Colors.transparent,
                                  child: InkWell(
                                    onTap: () async{
                                      controller.verifyOtp();
                                      _storeUserData();
                                      //Get.off(chatPage());
                                    },
                                    borderRadius: BorderRadius.circular(30),
                                    child: Center(
                                      child: Text("Verify Otp",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 20),),
                                    ),
                                  ),
                                ),
                              ),)

                          ],
                        ),
                      ),
                    ))
              ],
            ),

          ),
        )));
  }




void _storeUserData() async {
  User? user = _auth.currentUser;
  if (user != null) {
    await _firestore.collection('user').doc(user.uid).set({
      'uid': user.uid,
      'phoneNumber': user.phoneNumber,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
}