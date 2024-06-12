import 'package:chat_app/Models/country_models.dart';
import 'package:chat_app/Sub_Screens/accounts/change_number2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeNumber extends StatelessWidget{

   final Country countrys;

  ChangeNumber({required this.countrys});
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       actions: [
         TextButton(
         onPressed: () {
                Navigator.of(context).pop(); },

          child: Text("Cancel",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),),

           Spacer(),

           Text("Change number",
           style: TextStyle(color: Colors.black,
           fontWeight: FontWeight.bold,fontSize: 18),),

            Spacer(),

         TextButton(
           onPressed: () {
             Navigator.push(
               context,
               MaterialPageRoute(
                 builder: (context) => ChangePhoneNumber(country: countrys),
               ),
             );
           },
           child: Text("Next",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),)
       ],
     ),
     body: Padding(
       padding: const EdgeInsets.all(15),
       child: Column(
         children: [
           Center(
             child: Container(
               height: 150,
               width: MediaQuery.of(context).size.width,
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Icon(Icons.sim_card,color: Colors.greenAccent,size: 60,),
                   Icon(Icons.more_horiz,color: Colors.lightGreenAccent,size: 40,),
                   Icon(Icons.sim_card,color: Colors.lightGreenAccent,size: 60,),
                 ],
               ),
             ),
           ),

           Text("Use change number to migrate your account info,",
             style: TextStyle(
                 color: Colors.black,
                 fontSize: 15),),
           Text("groups and settings from your current phone",
             style: TextStyle(
                 color: Colors.black,
                 fontSize: 15),),
           Text("number to a new phone number. You can't undo this",
             style: TextStyle(
                 color: Colors.black,
                 fontSize: 15),),
           Text("change.",
             style: TextStyle(
                 color: Colors.black,
                 fontSize: 15),),

           SizedBox(height: 25,),

           Text("To proceed, confirm that your new number can",
             style: TextStyle(
                 color: Colors.black,
                 fontSize: 15),),
           Text("receive SMS or calls and tap Next to verify that",
             style: TextStyle(
                 color: Colors.black,
                 fontSize: 15),),
           Text("number.",
             style: TextStyle(
                 color: Colors.black,
                 fontSize: 15),),


         ],
       ),
     ),
   );
  }

}