import 'package:chat_app/Data/introduction_data.dart';
import 'package:chat_app/Screen/welcome_page.dart';
import 'package:chat_app/widgets/intoduction_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroductionScreen extends StatelessWidget{
   IntroductionScreen({Key? key}) : super(key: key);

  PageController pageController = PageController(initialPage: 0);

  List  abc = IntroductionData().introData;

  var currentShowIndex = 0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top,),
          Expanded(
              child: PageView(
            controller: pageController,
            pageSnapping: true,
            physics: BouncingScrollPhysics(),
            onPageChanged: (index){
              currentShowIndex = index;
            },
            scrollDirection: Axis.horizontal,
            children: [
              IntroView(introductionModel:abc[0]),
              IntroView(introductionModel:abc[1]),
              IntroView(introductionModel:abc[2]),
              IntroView(introductionModel:abc[3]),
              IntroView(introductionModel:abc[4]),
            ],
          )),

          SmoothPageIndicator(
              controller: pageController,  // PageController
              count:  abc.length,
              effect:  SlideEffect(
                dotColor: Colors.greenAccent,
                activeDotColor: Colors.lightGreenAccent
              ),  // your preferred effect
              onDotClicked: (index){}
          ),

        Padding(padding: EdgeInsets.only(left: 48,right: 48,bottom: 32,top: 32),

        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius:BorderRadius.circular(24)
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: (){
                Get.to(WelcomePage());
              },
              borderRadius: BorderRadius.circular(24),
              child: Center(child: Text("Register")),
            ),
          ),
        ),),
          SizedBox(height: MediaQuery.of(context).padding.bottom,)

        ],
      ),

    );
  }

}