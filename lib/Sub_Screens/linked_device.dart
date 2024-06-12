import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LinkedDevice extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text("Linked devices",style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10,10,10,50),
        child: Column(
          children: [
            Container(
              height: 200,
                width: 200,
                child:Image.asset("assets/images/chat.jpg")),

            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Column(
                children: [
                  Text("Use WhatsApp on",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                  ),),
                  Center(
                    child: Text(" other devices",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30
                      ),),
                  )
                ],
              ),
            ),

            SizedBox(height: 10,),

            Text("You can link other devices to this account,",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15
              ),),
            Padding(
              padding: const EdgeInsets.fromLTRB(14,0,0,0),
              child: Row(
                children: [
                  Text("including Windows,Mac and Web.",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15
                    ),),
                  TextButton(
                      onPressed: (){},
                      child:Text("Learn More",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 15
                        ),),)
                ],
              ),
            ),

            Spacer(),

           Container(
                   height: 50,
                  decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius:BorderRadius.circular(10)
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: (){
                      },
                      borderRadius: BorderRadius.circular(24),
                      child: Center(child: Text("Link device")),
                    ),
                  ),
                ),
            SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.only(left:10),
              child: Row(
                children: [
                  Icon(Icons.lock,size: 10,color: Colors.grey,),
                  Text("Your personal messages are",style: TextStyle(color: Colors.grey),),
                  TextButton(onPressed: (){}, child: Text("end-to-end encrypted",style: TextStyle(color: Colors.green,fontSize: 13)))
                ],
              ),
            ),
            Text("on all of your devices.",style: TextStyle(color: Colors.grey)),

            // RichText(
            //   text: TextSpan(
            //     text: 'Your personal messages are',style: TextStyle(color: Colors.black),
            //     children:[
            //       TextSpan(text: '"end-to-end encrypted"',
            //           style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green)),
            //       TextSpan(text: "on all of your devices,",style: TextStyle(color: Colors.black),),
            //
            //     ],
            //   ),
            //
            // )

          ],
        ),
      ),
    );
  }

}