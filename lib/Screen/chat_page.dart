import 'package:chat_app/Screen/call_page.dart';
import 'package:chat_app/Screen/individual_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../elements/firestore_contacts.dart';

class chatPage extends StatefulWidget{
  @override
  State<chatPage> createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {

  String selected = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:GestureDetector(
          child: Container(
            margin: EdgeInsets.all(8), // Optional: margin around the container
            padding: EdgeInsets.all(8), // Padding inside the container
            decoration: BoxDecoration(
              color: Colors.grey, // Background color of the container
              shape: BoxShape.circle, // Shape of the container
            ),
            child: Icon(
              Icons.more_horiz,
              color: Colors.black, // Color of the icon
            ),
          ),
        ),

        actions: [
          Container(
            margin: EdgeInsets.only(right: 10), // Optional: margin to the right
            padding: EdgeInsets.all(8), // Padding inside the container
            decoration: BoxDecoration(
              color: Colors.green, // Background color of the container
              shape: BoxShape.circle, // Shape of the container
            ),
            child:Icon(Icons.camera_alt,color: Colors.white,),
          ),

    GestureDetector(
    onTap: (){
    Get.off(RegisteredUsersList());
    },
    //_getContacts,
    child:Container(
            margin: EdgeInsets.only(right: 10), // Optional: margin to the right
            padding: EdgeInsets.all(8), // Padding inside the container
            decoration: BoxDecoration(
              color: Colors.green, // Background color of the container
              shape: BoxShape.circle, // Shape of the container
            ),
            child: Icon(
              Icons.add,
              color: Colors.white, // Color of the icon
            ),
          ),
    )],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Chats",style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),),

              SizedBox(height: 10,),

              Container(
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Search',
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10,),

              Row(
                children: [

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = "All";
                      });
                    },
                    child: Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: selected == "All" ? Colors.green : Colors.grey,
                      ),
                      child: Center(child: Text("All", style: TextStyle(color: Colors.white))),
                    ),
                  ),


                  SizedBox(width: 5),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = "Unread";
                      });
                    },
                    child: Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: selected == "Unread" ? Colors.green : Colors.grey,
                      ),
                      child: Center(child: Text("Unread", style: TextStyle(color: Colors.white))),
                    ),
                  ),

                ],
              ),
              SizedBox(height: 10,),

              Expanded(
                  child:
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatScreen()),
                      );
                    },
                      child:ListView.builder(
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) {
                      return
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Image.asset("assets/images/img1.jpg"),
                              ),
                              title: Text("Welcome",),
                              subtitle: Text("chat app"),
                            ),
                          ),
                        );

                    }
                  )
              )
              )],
          ),
        ),
    );
  }
}



