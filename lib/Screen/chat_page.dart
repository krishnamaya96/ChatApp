import 'package:chat_app/Screen/call_page.dart';
import 'package:chat_app/Screen/individual_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/intl.dart';

import '../Controller/chatListController.dart';
import '../chat_page_one.dart';
import '../elements/firestore_contacts.dart';
import '../Controller/userController_get.dart';
import '../webSocket/web_socket.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();

    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: Obx(() {
        if (userController.currentUserId.value.isEmpty) {
          return Center(child: Text("User is not logged in"));
        }

        return ChatRoomsList(currentUserId: userController.currentUserId.value);
      }),
    );
  }
}

class   ChatRoomsList extends StatefulWidget{
 final String currentUserId;
 //  final WebSocketService webSocketService;

 ChatRoomsList({super.key, required this.currentUserId});

  @override
  State<  ChatRoomsList> createState() => _chatPageState();
}

class _chatPageState extends State<ChatRoomsList> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  List<DocumentSnapshot> _chatRooms = [];
  String selected = "All";
  late Future<List<Map<String, dynamic>>> _chatHistoryFuture;

  //late Future<List<Map<String, dynamic>>> _chatRoomsFuture;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _fetchChatRooms();
  // }

  //
  // Future<List<String>> getChattedUsers(String currentUserId) async {
  //   QuerySnapshot chatRoomsSnapshot = await FirebaseFirestore.instance
  //       .collection('chatRooms')
  //       .where('users', arrayContains: currentUserId)
  //       .get();
  //
  //   List<String> userIds = [];
  //   chatRoomsSnapshot.docs.forEach((doc) {
  //     List<dynamic> users = doc.id.split('_');
  //     users.forEach((userId) {
  //       if (userId != currentUserId) {
  //         userIds.add(userId);
  //       }
  //     });
  //   });
  //   return userIds;
  // }


  Future<List<Map<String, dynamic>>> getChatHistory(String currentUserId) async {
    try {
      final chatRoomsRef = FirebaseFirestore.instance.collection('chatRooms');
      final querySnapshot = await chatRoomsRef.get();

      print('Total chat rooms found: ${querySnapshot.docs.length}');

      List<Map<String, dynamic>> chatHistory = [];
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        final roomName = doc.id;

        print('Checking chat room: $roomName');

        // Fetch the latest message from the messages sub-collection
        final latestMessageSnapshot = await chatRoomsRef
            .doc(roomName)
            .collection('messages')
            .orderBy('timestamp', descending: true)
            .limit(1)
            .get();

        if (latestMessageSnapshot.docs.isNotEmpty) {
          final latestMessage = latestMessageSnapshot.docs.first.data();
          final otherUserId = latestMessage['from'] == currentUserId
              ? latestMessage['to']
              : latestMessage['from'];
          final userDoc = await FirebaseFirestore.instance.collection('user')
              .doc(otherUserId)
              .get();

          if (userDoc.exists) {
            print('Adding user to chat history: ${userDoc.data()!['name']}');

            chatHistory.add({
              'userId': userDoc.id,
              'userName': userDoc.data()!['name'],
              'userProfilePic': userDoc.data()!['profilePicture'],
              'lastMessage': latestMessage['message'],
              'timestamp': latestMessage['timestamp']
                  .toDate()
                  .millisecondsSinceEpoch,
            });
          }
          else{
            print('User document does not exist for userId: $otherUserId');
          }
        }
        else{
          print('No messages found in chat room: $roomName');
        }
      }
      print('Total chat history entries: ${chatHistory.length}');
      return chatHistory;
    }
    catch (e, stacktrace) {
      print('Error fetching chat history: $e');
      print(stacktrace);
      return [];
    }
  }



  // Stream<List<ChatUser>> getChatUsers() {
  //   return FirebaseFirestore.instance
  //       .collection('chatRooms')
  //       .where('participants', arrayContains: widget.currentUserUid)
  //       .snapshots()
  //       .map((snapshot) {
  //     // Map each document to a ChatUser object
  //     return snapshot.docs.map((doc) {
  //       var data = doc.data() as Map<String, dynamic>;
  //       // Extract relevant data
  //       var lastMessage = data['lastMessage'] ?? '';
  //       var timestamp = data['timestamp']?.toDate() ?? DateTime.now();
  //       var otherUserId = (data['participants'] as List)
  //           .firstWhere((id) => id != widget.currentUserUid);
  //       var otherUserName = data['name'][otherUserId] ?? 'Unknown';
  //       var otherUserProfilePic = data['profilePics'][otherUserId] ?? '';
  //
  //       return ChatUser(
  //         id: otherUserId,
  //         name: otherUserName,
  //         profilePic: otherUserProfilePic,
  //         lastMessage: lastMessage,
  //         timestamp: timestamp,
  //       );
  //     }).toList();
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _chatHistoryFuture = getChatHistory(widget.currentUserId);
  }

  @override
  Widget build(BuildContext context) {
    //
    //final ChatController chatController = Get.put(ChatController());
    final UserController userController = Get.find<UserController>();
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
       FutureBuilder<List<Map<String, dynamic>>>(
         future: _chatHistoryFuture,
         builder: (context, snapshot) {
           if (snapshot.connectionState == ConnectionState.waiting) {
             return Center(child: CircularProgressIndicator());
           } else if (snapshot.hasError) {
             return Center(child: Text('Error: ${snapshot.error}'));
           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
             return Center(child: Text('No chat history found.......'));
           } else {
             final chatHistory = snapshot.data!;
             return ListView.builder(
               itemCount: chatHistory.length,
               itemBuilder: (context, index) {
                 final chatUser = chatHistory[index];
                 return ListTile(
                   // leading: CircleAvatar(
                   //   backgroundImage: NetworkImage(chatUser['userProfilePic']),
                   // ),
                   title: Text(chatUser['userName']),
                   subtitle: Text(chatUser['lastMessage']),
                   trailing: Text(
                     DateFormat('h:mm a').format(
                       DateTime.fromMillisecondsSinceEpoch(chatUser['timestamp']),
                     ),
                     style: TextStyle(
                       color: Colors.grey,
                       fontSize: 12.0,
                     ),
                   ),
                   onTap: () {
                     // Navigator.push(
                     //   context,
                     //   MaterialPageRoute(
                     //     builder: (context) => ChatPage(
                     //       currentUserId: widget.currentUserId,
                     //       chatUserId: chatUser['userId'],
                     //       chatUserName: chatUser['userName'],
                     //       chatUserProfilePic: chatUser['userProfilePic'],
                     //     ),
                     //   ),
                     // );
                   },
                 );
               },
             );
           }
         },
       ),
       // GetX<ChatRoomController>(
       //   init: ChatRoomController(),
       //   builder: (controller) {
       //     if (controller.chatRooms.isEmpty) {
       //       return Center(child: Text('No chat rooms available.'));
       //     } else {
       //       return ListView.builder(
       //         itemCount: controller.chatRooms.length,
       //         itemBuilder: (context, index) {
       //           var chatRoom = controller.chatRooms[index];
       //           List participants = chatRoom['participants'];
       //           String otherUserId = participants.firstWhere((id) => id != controller.currentUserId.value);
       //
       //           return FutureBuilder<DocumentSnapshot>(
       //             future: FirebaseFirestore.instance.collection('users').doc(otherUserId).get(),
       //             builder: (context, snapshot) {
       //               if (snapshot.connectionState == ConnectionState.waiting) {
       //                 return ListTile(title: Text('Loading...'));
       //               } else if (snapshot.hasError) {
       //                 return ListTile(title: Text('Error loading user'));
       //               } else if (!snapshot.hasData || !snapshot.data!.exists) {
       //                 return ListTile(title: Text('User not found'));
       //               } else {
       //                 var userData = snapshot.data!.data() as Map<String, dynamic>;
       //                 return ListTile(
       //                   title: Text(userData['name'] ?? 'No Name'),
       //                   // onTap: () {
       //                   //   // Navigate to the chat page with the selected user
       //                   //   Get.to(ChatPage(chatRoomId: chatRoom.id, otherUserId: otherUserId));
       //                   // },
       //                 );
       //               }
       //             },
       //           );
       //         },
       //       );
       //     }
       //   },
       // ),
       )


        // String currentUserId = userController.currentUserId.value;

         //print('Current User ID: $currentUserId');  // Debug print
         // return StreamBuilder(
         //   stream: FirebaseFirestore.instance
         //       .collection('chatRooms')
         //       .where('userIds', arrayContains: currentUserId)
         //       .snapshots(),
         //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
         //     if (snapshot.connectionState == ConnectionState.waiting) {
         //       return Center(child: CircularProgressIndicator());
         //     }
         //     if (snapshot.hasError || !snapshot.hasData) {
         //       print('Error: ${snapshot.error}');  // Debug print
         //       return Center(child: Text('No chat rooms available.'));
         //     }
         //
         //     var chatRooms = snapshot.data!.docs;
         //     print('Fetched chat rooms: ${chatRooms.length}');
         //     return ListView.builder(
         //       itemCount: chatRooms.length,
         //       itemBuilder: (context, index) {
         //         var chatRoom = chatRooms[index];
         //         var chatRoomId = chatRoom.id;
         //         var userId = chatRoom['userIds'].firstWhere((id) => id != currentUserId);
         //         print('Chat Room ID: $chatRoomId, User ID: $userId');  // Debug print
         //         return ListTile(
         //           title: Text('Chat with $userId'),
         //           // onTap: () {
         //           //   Get.to(ChatDetailPage(chatRoomId: chatRoomId, userId: userId));
         //           // },
         //         );
         //       },
         //     );
         //   },
         // );


       // FutureBuilder<QuerySnapshot>(
       //   future:FirebaseFirestore.instance
       //       .collection('chatRooms')
       //       .where('members', arrayContains: currentUserId)
       //       .get(),
       //   builder: (context, snapshot) {
       //     if (snapshot.connectionState == ConnectionState.waiting) {
       //       return Center(child: CircularProgressIndicator());
       //     }
       //     if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
       //       return Center(child: Text('No users found'));
       //     }
       //     final chatRooms = snapshot.data!.docs;
       //    // List<String> userIds = snapshot.data!.docs;
       //     return ListView.builder(
       //       itemCount: chatRooms.length,
       //       itemBuilder: (context, index) {
       //         final chatRoom = chatRooms[index];
       //         return ListTile(
       //           title: Text(chatRoom.id),
       //           onTap: () {
       //             // Navigator.push(
       //             //   context,
       //             //   MaterialPageRoute(
       //             //     builder: (context) => ChatPage(
       //             //       currentUserId: currentUserId,
       //             //       otherUserId: userIds[index],
       //             //     ),
       //             //   ),
       //             // );
       //           },
       //         );
       //       },
       //     );
       //   },
       // ),
        //),

    //           Expanded(
    //                   child:
    //                         GestureDetector(
    //                                onTap: (){
    //                                 Navigator.push(
    //                                     context,
    //                                      MaterialPageRoute(builder: (context) => ChatScreen()),
    //                                  );
    //                              },
    //                   // StreamBuilder(
    //                   //    stream: FirebaseFirestore.instance.collection('chatRooms').snapshots(),
    //                   //    //getChatUsers(),
    //                   //    builder: (context,  snapshot) {
    //                   //      if (!snapshot.hasData) {
    //                   //        return Center(child: CircularProgressIndicator());
    //                   //      }
    //                   //
    //                   //      final chatUsers = snapshot.data!.docs;
    //
    //                        child:  ListView.builder(
    //                            itemCount: 20,
    // //chatUsers.length,
    //                            itemBuilder: (BuildContext context, int index) {
    //                              //final user = chatUsers[index];
    //                              return
    //                                Padding(
    //                                  padding: const EdgeInsets.all(4),
    //                                  child: Container(
    //                                    decoration: BoxDecoration(
    //                                      color: Colors.grey.shade200,
    //                                    ),
    //                                    child: ListTile(
    //                                      leading: CircleAvatar(
    //                                        child: Image.asset(
    //                                            "assets/images/img1.jpg"),
    //                                      ),
    //                                      title: Text("Welocme"),
    //                                      //user.name),
    //                                      subtitle: Text("chat app"),
    //                                     //user.lastMessage),
    //                                      // trailing: Text(
    //                                      //   DateFormat('h:mm a').format(user.timestamp),
    //                                      //   style: TextStyle(color: Colors.grey, fontSize: 12),
    //                                      // ),
    //                                      // onTap: () {
    //                                      //   Navigator.push(
    //                                      //     context,
    //                                      //     MaterialPageRoute(
    //                                      //       builder: (context) =>WebSocketExamplePage(
    //                                      //         webSocketService: widget.webSocketService,
    //                                      //         currentUserUid: widget.currentUserUid,
    //                                      //         selectedUserUid: user.id,
    //                                      //         selectedUserName: user.name,
    //                                      //       ),
    //                                      //     ),
    //                                      //   );
    //                                      // },
    //                                    ),
    //                                  ),
    //                                );
    //                            }
    //                        ),
    //                       )
    //           ),

      ]  ),
      ));
  }
}


// class ChatUser {
//   final String id;
//   final String name;
//   final String profilePic;
//   final String lastMessage;
//   final DateTime timestamp;
//
//   ChatUser({
//     required this.id,
//     required this.name,
//     required this.profilePic,
//     required this.lastMessage,
//     required this.timestamp,
//   });
// }


