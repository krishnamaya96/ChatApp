
import 'package:chat_app/Controller/login_Controller.dart';
import 'package:chat_app/Screen/otp_page.dart';
import 'package:chat_app/Screen/welcome_page.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MobileVerification extends StatefulWidget  {
  @override
  _MobileVerificationState createState() => _MobileVerificationState();
}

class _MobileVerificationState extends State<MobileVerification> {
  @override
  void initState() {
    super.initState();
    // Schedule the dialog to show after the layout is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Future.delayed(Duration.zero, () => _showConfirmationDialog(context));
      }
    });
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm'),
          content: Text('Do you agree to continue?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Disagree'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Agree'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(40),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.asset("assets/images/mob.jpg"),
                      ),
                    ),
                    SizedBox(height: 100,),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Otp will send to this number",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                        left: 24,
                        right: 24,
                        top: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Theme.of(context).backgroundColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).disabledColor.withOpacity(0.1),
                                  offset: Offset(4, 4),
                                  blurRadius: 10,
                                )
                              ],
                            ),
                            child: CountryCodePicker(
                              favorite: ['IN'], // Use the ISO code for India
                              textStyle: TextStyle(color: Theme.of(context).primaryColor),
                              onChanged: (countryCode) {
                                print(countryCode.dialCode);
                              },
                            ),
                          ),
                          SizedBox(width: 5,),

                          Expanded(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Theme.of(context).backgroundColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context).disabledColor.withOpacity(0.1),
                                    offset: Offset(4, 4),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Obx(() =>TextField(
                                controller: controller.numberController,
                                decoration: InputDecoration(
                                  hintText: 'Enter mobile number',
                                  errorText: controller.numberError.value.isEmpty ? null : controller.numberError.value,
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                ),
                                maxLines: 1,
                                keyboardType: TextInputType.phone,
                              ),)
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Padding(
                    //   padding: EdgeInsets.only(left: 24,right: 24,top: 40),
                    //   child: Container(
                    //     height: 48,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(30),
                    //       color: Theme.of(context).primaryColor,
                    //       boxShadow: [
                    //         BoxShadow(
                    //             color: Theme.of(context).disabledColor
                    //         .withOpacity(0.1),
                    //         offset: Offset(4,4),
                    //         blurRadius: 10)
                    //       ]
                    //     ),
                    //     child: Material(
                    //       color: Colors.greenAccent,
                    //       child: InkWell(
                    //         onTap: (){},
                    //         borderRadius: BorderRadius.circular(30),
                    //         child: Center(child: Text("Generate OTP",
                    //         style: TextStyle(fontWeight: FontWeight.bold,
                    //         color: Colors.black,
                    //         fontSize: 20),)),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                     Padding(padding: EdgeInsets.only(left: 24,right: 24,top: 40,),
                        child: Container(
                           height: 50,
                          decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius:BorderRadius.circular(24)
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: (){
                                controller.sendOtp();
                                //Get.to( const OtpPage());
                                //Navigator.push(context, MaterialPageRoute(builder:(context) =>OtpPage() ));
                              },
                              borderRadius: BorderRadius.circular(24),
                              child:Center(
                                     child: Text("Generate OTP",
                                     style: TextStyle(fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    fontSize: 20),)),
                            ),
                          ),
                        ),),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
