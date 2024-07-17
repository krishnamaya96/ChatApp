import 'package:chat_app/Controller/login_Controller.dart';
import 'package:chat_app/Screen/chat_page.dart';
import 'package:chat_app/Screen/introduction_screen.dart';
import 'package:chat_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late AnimationController animationController;
  late AnimationController slideAnimation;
  late Animation<Offset> offsetAnimation;
  late Animation<Offset> textAnimation;

@override
  void initState() {
   animationController = AnimationController(
       vsync: this,
     lowerBound: 0,
     upperBound: 60,
     animationBehavior: AnimationBehavior.normal,
     duration: const Duration(milliseconds: 700));

   animationController.forward();

   slideAnimation = AnimationController(
       vsync: this,
       duration: const Duration(milliseconds: 700));

   offsetAnimation = Tween<Offset>(
     begin: Offset.zero,
     end: const Offset(-0.5, 0.0)
   ).animate(CurvedAnimation(
       parent: slideAnimation,
       curve: Curves.fastOutSlowIn));

   textAnimation = Tween<Offset>(
       begin: const Offset(-0.5, 0.0),
       end:const Offset(0.2, 0.0)
   ).animate(CurvedAnimation(
       parent: slideAnimation,
       curve: Curves.fastOutSlowIn));

   animationController.addStatusListener((status) {
     if(status == AnimationStatus.completed){
       slideAnimation.forward();
     }
   });
   
   Future.delayed(const Duration(seconds: 4), (){
   //  loginController controller = Get.find<loginController>();

       Navigator.push(context,
           MaterialPageRoute(builder: (context) => IntroductionScreen()));
      });


   super.initState();
  }


  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                  animation: animationController,
                  builder: (_,child){
                    return SlideTransition(
                        position: offsetAnimation,
                        child: Icon(Icons.chat,color: Colors.black,size: animationController.value,),);
                  }),

              SlideTransition(
                position: textAnimation,
                child: Text('Chat App',
                  style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),),
              )

            ],
          ),
        ),
      ),
    );
  }
}