import 'package:chat_app/Models/introduction_Model.dart';
import 'package:flutter/cupertino.dart';

class IntroView extends StatelessWidget{
  
  final IntroductionModel introductionModel;
  const IntroView({Key?key, required this.introductionModel}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 8,
            child: Center(
            child: Container(
            width: MediaQuery.of(context).size.width-120,
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(introductionModel.assetImages,fit: BoxFit.fill,),
            ),
          ),
        )),
        
        Expanded(
            child: Container(
            child: Text(introductionModel.titleText,textAlign: TextAlign.center,
                   style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
        )),

        Expanded(
            child: SizedBox(),
            flex: 1,)
      ],
    );
  }
  
}