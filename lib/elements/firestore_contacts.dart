import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Screen/individual_chat.dart';
import '../chat_page_one.dart';
import '../webSocket/web_socket.dart';
import '../webSocket/web_socket_service_factory.dart';

class RegisteredUsersList extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String getFirstTwoDigits(String phoneNumber) {
    return phoneNumber.substring(3, 5); // Assuming phone number starts with '+'
  }

  Future<String> getCurrentUserUid() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      throw Exception("No user logged in");
    }
  }

  Future<WebSocketService> initializeWebSocketService(String roomName,) async {
    String uid = await getCurrentUserUid();
    WebSocketService webSocketService = createWebSocketService('ws://127.0.0.1:8000/ws/chat/$roomName/');
    return webSocketService;
  }

  String getRoomName(String uid1, String uid2) {
    List<String> uids = [uid1, uid2];
    uids.sort();
    return uids.join('_');
  }

  // final String uid = FirebaseAuth.instance.currentUser!.uid;
  //
  // final WebSocketService webSocketService = createWebSocketService('ws://127.0.0.1:8000/ws/chat/roomName/$uid/');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),),
        title: Text('Contacts',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('user').orderBy('createdAt').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No registered users'));
          }
          var users = snapshot.data!.docs;


          return
            // GestureDetector(
            // onTap: (){
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => WebSocketExamplePage(webSocketService: webSocketService)),
            //   );
            // },
            //   child:

              ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              var user = users[index];
              var userUid = user.id;
              String phoneNumber = user['phoneNumber'];
              String firstTwoDigits = getFirstTwoDigits(phoneNumber);
              // Cast user.data() to Map<String, dynamic> to ensure type safety
              Map<String, dynamic>? userData = user.data() as Map<String, dynamic>?;

              // Check if userData is not null and then check for 'name' field
              String userName = userData != null && userData.containsKey('name') ? userData['name'] : 'Unknown User';

              return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      firstTwoDigits,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                title: Text(user['phoneNumber']),
                subtitle: Text(userName),

                onTap: ()
                  {
                    navigateToChatPage(context,userUid,userName);
                  }
                // async {
                //
                //   User? currentUser = FirebaseAuth.instance.currentUser;
                //   if (currentUser != null) {
                //     String currentUserUid = currentUser.uid;
                //     String selectedUserUid = user['uid'];
                //     String roomName = getRoomName(currentUserUid, selectedUserUid);
                //     WebSocketService webSocketService = await initializeWebSocketService(roomName);
                //
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => WebSocketExamplePage(
                //           webSocketService:webSocketService,
                //         ),
                //       ),
                //     );
                //   }
                //   // Navigator.push(
                //   //   context,
                //   //   MaterialPageRoute(
                //   //     builder: (context) =>
                //   //         FutureBuilder<WebSocketService>(
                //   //           future: initializeWebSocketService(),
                //   //           builder: (context, snapshot) {
                //   //             if (snapshot.connectionState ==
                //   //                 ConnectionState.waiting) {
                //   //               return Scaffold(
                //   //                 body: Center(
                //   //                     child: CircularProgressIndicator()),
                //   //               );
                //   //             }
                //   //             if (snapshot.hasError) {
                //   //               return Scaffold(
                //   //                 body: Center(child: Text(
                //   //                     'Error initializing WebSocket')),
                //   //               );
                //   //             }
                //   //
                //   //             WebSocketService webSocketService = snapshot
                //   //                 .data!;
                //   //             return WebSocketExamplePage(
                //   //                 webSocketService: webSocketService);
                //   //           },
                //   //         ),
                //   //   ),
                //   // );
                //
                // },
              );
              //)
            } );
        },
      ),
    );
  }
  void navigateToChatPage(BuildContext context, String selectedUserUid,  String selectedUserName) async {
    String currentUserUid = await getCurrentUserUid();
    String roomName = getRoomName(currentUserUid, selectedUserUid);

    WebSocketService webSocketService = await initializeWebSocketService(roomName);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebSocketExamplePage(
          webSocketService: webSocketService,
          selectedUserUid: selectedUserUid,
          currentUserUid: currentUserUid,
          selectedUserName: selectedUserName,
        ),
      ),
    );
  }

}


