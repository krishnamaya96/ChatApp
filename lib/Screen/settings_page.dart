import 'package:chat_app/Sub_Screens/accounts/accounts_m.dart';
import 'package:chat_app/Sub_Screens/linked_device.dart';
import 'package:chat_app/elements/bottom_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconly/iconly.dart';

class settingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text("Settings",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),),
              ),
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

              Container(
                height: 120,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage("assets/images/ai4.jpg"),
                          ),
                          SizedBox(width: 7,),
                              Text("Username",
                                style: TextStyle(
                                    color: Colors.black,
                                fontSize: 15),),
                              Spacer(),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green
                                ),
                                child: Icon(Icons.qr_code,color: Colors.white,),
                              ),
                            ],
                      ),
                    ),
                    Divider(
                      thickness: 0.05,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10,top: 1.5),
                      child: Row(
                        children: [
                          Icon(IconlyBold.activity,color: Colors.black,),
                          SizedBox(width: 10,),
                          Text("Avatar",style: TextStyle(color: Colors.black)),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,)
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10,),
              
              Container(
                height: 120,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10,top: 1.5),
                      child: Row(
                        children: [
                          Icon(Icons.broadcast_on_personal_sharp,color: Colors.black,),
                          SizedBox(width: 10,),
                          Text("Broadcast Lists",style: TextStyle(color: Colors.black)),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,)
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 0.05,
                      color: Colors.black,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10, top: 1.5),
                      child: Row(
                        children: [
                          Icon(Icons.star,color: Colors.black,),
                          SizedBox(width: 10,),
                          Text("Starred Messages",style: TextStyle(color: Colors.black),),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,)
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 0.15,
                      color: Colors.black,
                    ),

                   GestureDetector(
                     onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LinkedDevice()));
                     },
                     child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10,),
                      child: Row(
                        children: [
                          Icon(Icons.computer,color: Colors.black,),
                          SizedBox(width: 10,),
                          Text("Linked Device",style: TextStyle(color: Colors.black),),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,)
                        ],
                      ),
                    ),),
                  ],
                ),
              ),

              SizedBox(height: 15,),

              Container(
                height: 240,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200,
                ),
                child: Column(
                  children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => accountOne()));
                    },
                      child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
                      child: Row(
                        children: [
                          Icon(IconlyBold.lock,color: Colors.black,),
                          SizedBox(width: 10,),
                          Text("Account",style: TextStyle(color: Colors.black)),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,)
                        ],
                      ),
                    ),),
                    Divider(
                      thickness: 0.05,
                      color: Colors.black,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10,),
                      child: Row(
                        children: [
                          Icon(Icons.privacy_tip,color: Colors.black,),
                          SizedBox(width: 10,),
                          Text("Privacy",style: TextStyle(color: Colors.black),),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,)
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 0.05,
                      color: Colors.black,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10,),
                      child: Row(
                        children: [
                          Icon(IconlyBold.chat,color: Colors.black,),
                          SizedBox(width: 10,),
                          Text("Chats",style: TextStyle(color: Colors.black),),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,)
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 0.05,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10,),
                      child: Row(
                        children: [
                          Icon(Icons.notifications,color: Colors.black,),
                          SizedBox(width: 10,),
                          Text("Notifications",style: TextStyle(color: Colors.black),),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,)
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 0.05,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10,),
                      child: Row(
                        children: [
                          Icon(Icons.currency_rupee,color: Colors.black,),
                          SizedBox(width: 10,),
                          Text("Payments",style: TextStyle(color: Colors.black),),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,)
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 0.05,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10,),
                      child: Row(
                        children: [
                          Icon(IconlyBold.arrow_up,color: Colors.black,),
                          SizedBox(width: 10,),
                          Text("Storage and Data",style: TextStyle(color: Colors.black),),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,)
                        ],
                      ),
                    ),

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
                          Icon(Icons.help,color: Colors.black,),
                          SizedBox(width: 10,),
                          Text("Help",style: TextStyle(color: Colors.black)),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,)
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 0.1,
                      color: Colors.black,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10, top: 1.5),
                      child: Row(
                        children: [
                          Icon(Icons.favorite_border,color: Colors.black,),
                          SizedBox(width: 10,),
                          Text("Tell a Friend",style: TextStyle(color: Colors.black),),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios,color: Colors.black,size: 15,)
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      )
    );
  }

}