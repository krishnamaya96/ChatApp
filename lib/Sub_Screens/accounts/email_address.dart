import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmailAddress extends StatelessWidget{
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
       title: Text("Email address",
         style: TextStyle(color: Colors.black,
             fontWeight: FontWeight.bold,
             fontSize: 18),),
       actions: [
         TextButton(onPressed: (){},
             child: Text("Edit",style: TextStyle(color: Colors.green,fontSize: 15,fontWeight: FontWeight.bold),))
       ],
     ),
     body: Padding(
       padding: const EdgeInsets.all(15),
       child: Column(
         children: [
           Center(
             child: Container(
               height: 150,
               width: 150,
               child: Icon(Icons.email,color: Colors.greenAccent,size: 70,),
             ),
           ),

           Text("Email helps you access your account. It isn't",
             style: TextStyle(
                 color: Colors.black,
                 fontSize: 15),),
           Text("Visible to others.",
             style: TextStyle(
                 color: Colors.black,
                 fontSize: 15),),

           SizedBox(height: 30,),

           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text("EMAIL"),
               SizedBox(height: 5,),
               Container(
                 height: 50,
                 width: MediaQuery.of(context).size.width,
                 child: TextField(
                   decoration: InputDecoration(
                     filled: true,
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(10),
                       borderSide: BorderSide.none
                     ),
                     hintText: 'Valid email id',
                   ),
                 ),
               ),
             ],
           ),

              SizedBox(height: 50,),


              Padding(padding: EdgeInsets.only(left: 48,right: 48,bottom: 32,),
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

                     },
                     borderRadius: BorderRadius.circular(24),
                     child:
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Icon(Icons.verified_user,color: Colors.black,),
                             Text("Verify",style: TextStyle(fontWeight: FontWeight.bold),),
                           ],
                         )),
                   ),
                 ),
               ),


         ],
       ),
     ),

   );
  }

}