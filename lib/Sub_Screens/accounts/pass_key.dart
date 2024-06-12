import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PassKey extends StatelessWidget{
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
        title: Text("PassKeys",
          style: TextStyle(color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Center(
              child: Container(
                height: 150,
                width: 150,
                child: Icon(Icons.person_search_sharp,color: Colors.greenAccent,size: 70,),
              ),
            ),

            Text("Access WhatsApp the same way you unlock your",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15),),
            Text("phone: with Face ID, Touch ID, or your device",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15),),
            Text("passcode. Your passkey gives you a secure and",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15),),
            Text("easy way to log back into your account.",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15),),

            TextButton(onPressed: (){},
                child: Text('Learn more.',style: TextStyle(color:Colors.green))),
            Spacer(),
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
                          Center(
                              child: Text("Create passkey",
                                style: TextStyle(fontWeight: FontWeight.bold),)),
                      ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

}