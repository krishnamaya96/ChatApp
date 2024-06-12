import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class SecurityNotification extends StatefulWidget{
  @override
  State<SecurityNotification> createState() => _SecurityNotificationState();
}

class _SecurityNotificationState extends State<SecurityNotification> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       leading: IconButton(
         onPressed: () {
           Navigator.of(context).pop();
         },
         icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
       ),
       title: Text("Security notifications",
         style: TextStyle(color: Colors.black,
         fontWeight: FontWeight.bold),),
     ),

     body: SingleChildScrollView(
       child: Padding(
         padding: const EdgeInsets.all(20),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Center(
               child: Container(
                 height: 150,
                 width: 150,
                 child: Icon(Icons.lock,color: Colors.greenAccent,size: 70,),
               ),
             ),
             Text("Your chats and calls are private",
               style: TextStyle(
                 color: Colors.black,
                  fontWeight: FontWeight.bold,
                   fontSize: 15),),
             SizedBox(height: 15,),

             Text("End-to-end encryption keeps your personal",
               style: TextStyle(
                   color: Colors.black,
                   fontSize: 15),),
             Text("messages and calls between you and the people",
               style: TextStyle(
                   color: Colors.black,
                   fontSize: 15),),

             Text("you choose. Not even WhatsApp can read or",
               style: TextStyle(
                   color: Colors.black,
                   fontSize: 15),),
             Text("listen to them. This include your",
               style: TextStyle(
                   color: Colors.black,
                   fontSize: 15),),

             SizedBox(height: 20,),
             Row(
               children: [
                 Icon(IconlyLight.message),
                 SizedBox(width:10,),
                 Text("Text and voice messages",style: TextStyle(
                     color: Colors.black,
                     fontSize: 15,fontWeight: FontWeight.bold))
               ],
             ),
             SizedBox(height: 10,),
             Row(
               children: [
                 Icon(IconlyLight.call),
                 SizedBox(width:10,),
                 Text("Audio and video calls",style: TextStyle(
                     color: Colors.black,
                     fontSize: 15,fontWeight: FontWeight.bold))
               ],
             ),
             SizedBox(height: 10,),
             Row(
               children: [
                 Icon(Icons.attach_file),
                 SizedBox(width:10,),
                 Text("Photos, videos and document",style: TextStyle(
                     color: Colors.black,
                     fontSize: 15,fontWeight: FontWeight.bold))
               ],
             ),
             SizedBox(height: 10,),
             Row(
               children: [
                 Icon(IconlyLight.location),
                 SizedBox(width:10,),
                 Text("Location sharing",style: TextStyle(
                     color: Colors.black,
                     fontSize: 15,fontWeight: FontWeight.bold))
               ],
             ),
             SizedBox(height: 10,),
             Row(
               children: [
                 Icon(Icons.update),
                 SizedBox(width:10,),
                 Text("Status updates",style: TextStyle(
                     color: Colors.black,
                     fontSize: 15,fontWeight: FontWeight.bold))
               ],
             ),
             SizedBox(height: 15,),
             TextButton(
                 onPressed: (){},
                 child: Text("Learn more",
                   style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),)),
             SizedBox(height: 15,),
             Container(
               height: 80,
               width: MediaQuery.of(context).size.width,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(20),
                 color: Colors.grey.shade200
               ),
               child: Padding(
                 padding: const EdgeInsets.all(15),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Column(
                       children: [
                         Text("Show security notifications on"),
                         Text("this phone")
                       ],
                     ),

                     Switch(
                       value: light,
                       activeColor: Colors.grey,
                       onChanged: (bool value) {
                         // This is called when the user toggles the switch.
                         setState(() {
                           light = value;
                         });
                       },),
                   ],
                 ),
               )
             ),

             SizedBox(height: 20,),

             Text("Get notified when your security code changes for a",
               style: TextStyle(
                   color: Colors.black87,
                   fontSize: 13),),
             Text("contact's phone in end-to-end encrypted chat. if",
               style: TextStyle(
                   color: Colors.black87,
                   fontSize: 13),),
             Text("you have multiple devices,this setting must be",
               style: TextStyle(
                   color: Colors.black87,
                   fontSize: 13),),

             Text("enabled on each device where you want to get",
               style: TextStyle(
                   color: Colors.black87,
                   fontSize: 13),),
             Row(
               children: [
                 Text("notifications.",
                   style: TextStyle(
                       color: Colors.black87,
                       fontSize: 13),),
                 TextButton(
                     onPressed: (){},
                     child: Text("Learn more.",style: TextStyle(color: Colors.green),))
               ],
             ),

           ],
         ),
       ),
     ),
   );
  }
}