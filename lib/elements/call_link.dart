import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
class callLink extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body:SingleChildScrollView( child:
     Container(
       //height: MediaQuery.of(context).size.height/3,
       width: MediaQuery.of(context).size.width,
       margin: EdgeInsets.symmetric(
         horizontal: 20,
         vertical: 20,
       ),
       child: Column(
         children: <Widget>[
           Row(
             children: [
               Text(
                 "Create call link",
                 style: TextStyle(
                   fontSize: 20.0,
                 ),
               ),
               Spacer(),
               Container(
                 height: 30,
                 width: 30,
                 decoration: BoxDecoration(
                   shape: BoxShape.circle,
                   color: Colors.grey.shade200,

                 ),

                 child: IconButton(
                   onPressed: () {
                     Navigator.pop(context);
                   },
                   icon: Center(child: Icon(Icons.close,color: Colors.black,size: 15,)),),
               )
             ],
           ),
           SizedBox(
             height: 20,
           ),
           Container(
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(10),
               color: Colors.grey.shade200,
             ),
             height: 220,
             width: 500,
             child: Column(
               children: [
                 Row(
                   children: [
                     Padding(
                       padding: const EdgeInsets.all(10),
                       child: Container(
                         height: 60,
                         width: 60,
                         decoration: BoxDecoration(
                           shape: BoxShape.circle,
                           color: Colors.grey
                         ),
                         child: Icon(IconlyBold.video,color: Colors.white,size: 30,),
                       ),
                     ),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         const Text("Video Call",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15),),
                        Text("https://www.whatsapp.com/",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),),
                         Text("video/dkfkdk45412dgfgfdgPo",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold))
                       ],
                     )
                   ],
                 ),
                 Padding(
                   padding: const EdgeInsets.all(10),
                   child: Text("Anyone with whtasapp can use this link to join this call. Only share it with people you trust.",
                     maxLines: 2,
                   style: TextStyle(fontSize: 15),),
                 ),
                 Divider(
                   color: Colors.grey,  // Line color
                   thickness: 1.0,       // Line thickness
                 ),
                 Padding(
                   padding: const EdgeInsets.all(10),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Container(
                         height: 30,
                         width: 30,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(30),
                           color: Colors.green
                         ),
                         child: Icon(IconlyBold.video,color: Colors.white,),
                       ),
                       Text("video",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15),)
                     ],
                   ),
                 )
               ],
             ),
           ),
           SizedBox(height: 10,),

           Container(
             height: 150,
             width: MediaQuery.of(context).size.width,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(10),
               color: Colors.grey.shade200,
             ),
             child: Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
                   child: Row(
                     children: [
                       Text("Send link via Whatsapp",style: TextStyle(color: Colors.black)),
                       Spacer(),
                       Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,)
                     ],
                   ),
                 ),
                 Divider(
                   thickness: 0.08,
                   color: Colors.black,
                 ),

                 Padding(
                   padding: const EdgeInsets.only(left: 10,right: 10, top: 1.5),
                   child: Row(
                     children: [
                       Text("Copy Link",style: TextStyle(color: Colors.black),),
                       Spacer(),
                       Icon(Icons.copy,color: Colors.black,size: 15,)
                     ],
                   ),
                 ),
                 Divider(
                   thickness: 0.15,
                   color: Colors.black,
                 ),
                 Padding(
                   padding: const EdgeInsets.only(left: 10,right: 10,),
                   child: Row(
                     children: [
                       Text("Share link",style: TextStyle(color: Colors.black),),
                       Spacer(),
                       Icon(Icons.share,color: Colors.black,size: 15,)
                     ],
                   ),
                 ),
                 Divider(
                   thickness: 0.15,
                   color: Colors.black,
                 ),
                 Padding(
                   padding: const EdgeInsets.only(left: 10,right: 10,),
                   child: Row(
                     children: [
                       Text("Add to Calender",style: TextStyle(color: Colors.black),),
                       Spacer(),
                       Icon(Icons.share,color: Colors.black,size: 15,)
                     ],
                   ),
                 ),

               ],
             ),
           ),

         ],
       ),
     )
     ) );
  }
}
