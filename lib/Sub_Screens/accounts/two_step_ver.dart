import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TwoStepVerification extends StatelessWidget{
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
        title: Text("Two step verification",
          style: TextStyle(color: Colors.black,
              fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Center(
              child: Container(
                height: 150,
                width: 150,
                child: Icon(Icons.verified,color: Colors.greenAccent,size: 70,),
              ),
            ),


            Text("Two-step verification is on. You'll need to",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15),),
            Text("enter your PIN if you register your phone",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15),),
            Text("number on WhatsApp gain.",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15),),

            TextButton(onPressed: (){},
                child: Text('Learn more.',style: TextStyle(color:Colors.green))),

            SizedBox(height: 60,),


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
                    padding:EdgeInsets.all(10),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {  },
                          child: Text("Turn off",
                            style: TextStyle(color: Colors.red,
                                fontWeight: FontWeight.bold,fontSize: 15),),),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 0.09,
                    color: Colors.black,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10, top: 1.5),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {  },
                          child: Text("Change pin",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,fontSize: 15), ),),

                      ],
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      )
    );
  }

}