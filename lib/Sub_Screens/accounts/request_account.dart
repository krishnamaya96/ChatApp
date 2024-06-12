import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RequestAccountInfo extends StatefulWidget{
  @override
  State<RequestAccountInfo> createState() => _RequestAccountInfoState();
}

class _RequestAccountInfoState extends State<RequestAccountInfo> {

  bool light = true;

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop(); },

          icon: Icon(Icons.arrow_back_ios)),
        Spacer(),
        Text("Request Account Info",
          style: TextStyle(color: Colors.black,
              fontWeight: FontWeight.bold,fontSize: 18),),
        Spacer(),
      ],
    ),
    body: SingleChildScrollView(
    child:Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("ACCOUNT INFORMATION",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          SizedBox(height: 7,),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text("Request for account information",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),),
                  Spacer()
                ],
              ),
            ),
          ),

          SizedBox(height: 15,),

          Text("Your report will be ready in about 3 days. You'll have",
            style: TextStyle(
                color: Colors.black,
                fontSize: 15),),
          Text("a few weeks to download your report after it's avilable.",
            style: TextStyle(
                color: Colors.black,
                fontSize: 15),),
          SizedBox(height: 20,),
          Text("Your request will be canceled if you make changes",
            style: TextStyle(
                color: Colors.black,
                fontSize: 15),),

          Text("to your account such as changing your number or",
            style: TextStyle(
                color: Colors.black,
                fontSize: 15),),
          Text("deleting your account.",
            style: TextStyle(
                color: Colors.black,
                fontSize: 15),),

          SizedBox(height: 20,),

          Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text("Create reports automatically",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),),
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
              ),
              ),

          Row(
            children: [
              Text("A new report will be created every month.",style: TextStyle(fontSize: 13)),
              TextButton(onPressed: (){},
                  child: Text('Learn More.',style: TextStyle(color: Colors.green,fontSize: 11)))
            ],
          ),

          SizedBox(height: 10,),
          
          Text("CHANNELS ACTIVITY",style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(height: 7,),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Request channels report",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),),
                  Spacer()
                ],
              ),
            ),
          ),

          SizedBox(height: 10,),

          Text("Create a report of your channel updates and",
            style: TextStyle(
                color: Colors.black,
                fontSize: 15),),

          Text("information, which you can access or port to",
            style: TextStyle(
                color: Colors.black,
                fontSize: 15),),
          Row(
            children: [
              Text("another app.",style: TextStyle(color: Colors.black,fontSize: 15)),
              TextButton(onPressed: (){},
                  child: Text('Learn More.',style: TextStyle(color: Colors.green,fontSize: 15)))
            ],
          ),

          SizedBox(height: 20,),

          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text("Create reports automatically",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),),
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
            ),
          ),
          Row(
            children: [
              Text("A new report will be created every month.",style: TextStyle(fontSize: 13)),
              TextButton(onPressed: (){},
                  child: Text('Learn More.',style: TextStyle(color: Colors.green,fontSize: 11)))
            ],
          ),
        ],
      ),
    ),
    ));
  }
}