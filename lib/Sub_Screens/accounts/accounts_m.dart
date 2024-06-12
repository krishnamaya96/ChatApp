import 'package:chat_app/Models/country_models.dart';
import 'package:chat_app/Sub_Screens/accounts/change_number.dart';
import 'package:chat_app/Sub_Screens/accounts/delete_account.dart';
import 'package:chat_app/Sub_Screens/accounts/email_address.dart';
import 'package:chat_app/Sub_Screens/accounts/pass_key.dart';
import 'package:chat_app/Sub_Screens/accounts/security_notification.dart';
import 'package:chat_app/Sub_Screens/accounts/two_step_ver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class accountOne extends StatelessWidget{

  final Country sampleCountry = Country(name: 'INDIA', code: 'IN');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
        title: Text("Accounts",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              height: 220,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200,
              ),
              child: Column(
                children: [
               GestureDetector(
                 onTap: (){
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecurityNotification()));
                 },
                 child:Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                    child: Row(
                      children: [
                        Text("Security notifications",style: TextStyle(color: Colors.black)),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,)
                      ],
                    ),
                  ),),
                  Divider(
                    thickness: 0.08,
                    color: Colors.black,
                  ),

                 GestureDetector(
                   onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => TwoStepVerification()));
                   },
                   child:Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
                    child: Row(
                      children: [
                        Text("Two-step verification",style: TextStyle(color: Colors.black),),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,)
                      ],
                    ),
                  ),),
                  Divider(
                    thickness: 0.08,
                    color: Colors.black,
                  ),

               GestureDetector(
                 onTap: (){
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => EmailAddress()));
                 },
                 child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
                    child: Row(
                      children: [
                        Text("Email address",style: TextStyle(color: Colors.black),),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,)
                      ],
                    ),
                  ),),
                  Divider(
                    thickness: 0.08,
                    color: Colors.black,
                  ),

                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PassKey()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
                    child: Row(
                      children: [
                        Text("Passkeys",style: TextStyle(color: Colors.black),),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,)
                      ],
                    ),
                  ),),
                  Divider(
                    thickness: 0.08,
                    color: Colors.black,
                  ),

             GestureDetector(
                 onTap: (){
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangeNumber(countrys: sampleCountry,)));
                 },

               child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
                    child: Row(
                      children: [
                        Text("Change number",style: TextStyle(color: Colors.black),),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,)
                      ],
                    ),
                  ),)
                ],
              ),
            ),

            SizedBox(height: 20,),

            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200,
              ),
              child: Column(
                children: [
                  Padding(
                    padding:EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text("Request account info",style: TextStyle(color: Colors.black)),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,)
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 0.09,
                    color: Colors.black,
                  ),
        
                   GestureDetector(
                      onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeleteAccount(country: sampleCountry)));
                     },
               child:  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10, top: 1.5),
                    child: Row(
                      children: [
                        Text("Delete my account",style: TextStyle(color: Colors.black),),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,)
                      ],
                    ),
               ) ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}