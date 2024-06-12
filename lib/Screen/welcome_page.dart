import 'package:chat_app/Screen/mobile_verification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class WelcomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
        children: [
          Expanded(
              flex: 4,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width-120,
                  // child: AspectRatio(
                  //   aspectRatio: 1,
                    child: Text("Welcome to Chat App...",
                      style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black),)
                 // ),
                ),
              )),
          Container(
            height: 250,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30)
            ),
              child:Image.asset("assets/images/whtsapp.jpg",height: 200,width: 200,),
          ),
          //Image.asset("assets/images/whtsapp.jpg",height: 200,width: 200,),
          Spacer(),

          Expanded(
              child: RichText(
                text: TextSpan(
                  text: 'Tap',style: TextStyle(color: Colors.black),
               //   style: DefaultTextStyle.of(context).style,
                  children:[
                    TextSpan(text: '"agree and continue"',
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green)),
                    TextSpan(text: 'to accept',style: TextStyle(color: Colors.black),),
                    TextSpan(text: '"terms and conditions"',
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green)),
                  ],
                ),

              )),

          Expanded(
            flex: 1,
            child: Padding(padding: EdgeInsets.only(left: 48,right: 48,bottom: 32,),
              child: Container(
               // height: 50,
                decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius:BorderRadius.circular(24)
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: (){
                     Get.to(MobileVerification());
                    },
                    borderRadius: BorderRadius.circular(24),
                    child: Center(child: Text("Agree and Continue")),
                  ),
                ),
              ),),)

        ],

            ),
      ));
  }

}