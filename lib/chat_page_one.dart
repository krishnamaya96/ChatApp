//
//
//
//
// import 'dart:convert';
//
// import 'package:chat_app/webSocket/web_socket.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class WebSocketExamplePage extends StatefulWidget {
//   final WebSocketService webSocketService;
//
//   WebSocketExamplePage({required this.webSocketService});
//
//   @override
//   _WebSocketExamplePageState createState() => _WebSocketExamplePageState();
// }
//
// class _WebSocketExamplePageState extends State<WebSocketExamplePage> {
//   @override
//   void initState() {
//     super.initState();
//     widget.webSocketService.messagesStream.listen((message) {
//       print('Received message: $message');
//       // Handle message and update UI if needed
//     });
//   }
//
//   @override
//   void dispose() {
//     widget.webSocketService.close(); // Close WebSocket connection when widget is disposed
//     super.dispose();
//   }
//
//   void _sendMessage() {
//     if (_controller.text.isNotEmpty) {
//       widget.webSocketService.sendMessage(jsonEncode({'message': _controller.text}));
//       {
//       setState(() {
//         _messages.add(_controller.text);
//       });
//     }
//     }
//    // widget.webSocketService.sendMessage('Hello from Flutter!');
//   }
//
//   final TextEditingController _controller = TextEditingController();
//   List<String> _messages = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('WebSocket Example'),
//       ),
//       body:
//     Column(
//         children: [
//           Expanded(
//             child:  StreamBuilder<dynamic>(
//               stream: widget.webSocketService.messagesStream,
//               builder: (context, snapshot) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 24.0),
//                   child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
//                 );
//                 // if (snapshot.hasData) {
//                 //   return Text('Received: ${snapshot.data}');
//                 // } else if (snapshot.hasError) {
//                 //   return Text('Error: ${snapshot.error}');
//                 // } else {
//                 //   return CircularProgressIndicator();
//                 // }
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: InputDecoration(hintText: 'Enter message'),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: _sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//
//      //  Column(
//      //    children: [
//      //      Form(
//      //        child: TextFormField(
//      //          controller: _controller,
//      //          decoration: InputDecoration(labelText: 'Send a message'),
//      //        ),
//      //      ),
//      //      StreamBuilder<dynamic>(
//      //      stream: widget.webSocketService.messagesStream,
//      //      builder: (context, snapshot) {
//      //        return Padding(
//      //          padding: const EdgeInsets.symmetric(vertical: 24.0),
//      //          child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
//      //        );
//      //        // if (snapshot.hasData) {
//      //        //   return Text('Received: ${snapshot.data}');
//      //        // } else if (snapshot.hasError) {
//      //        //   return Text('Error: ${snapshot.error}');
//      //        // } else {
//      //        //   return CircularProgressIndicator();
//      //        // }
//      //      },
//      //    ),
//      // ] ),
//      //  floatingActionButton: FloatingActionButton(
//      //    onPressed: _sendMessage,
//      //    child: Icon(Icons.send),
//      //  ),
//     );
//   }
// }

import 'dart:convert';
import 'package:chat_app/webSocket/web_socket.dart';
import 'package:chat_app/webSocket/web_socket_service_factory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';


class WebSocketExamplePage extends StatefulWidget {

  final WebSocketService webSocketService;
  final String currentUserUid;
  final String selectedUserUid;
  final String selectedUserName;

  WebSocketExamplePage({
    required this.webSocketService,
    required this.currentUserUid,
    required this.selectedUserUid,
    required this.selectedUserName,});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<WebSocketExamplePage> {

  final TextEditingController controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  String getRoomName(String uid1, String uid2) {
    List<String> uids = [uid1, uid2];
    uids.sort();
    return uids.join('_');
  }


  @override
  void initState() {
    super.initState();
    //initializeUids();
    print('WebSocketService setup started...');
    print('WebSocket URL: ${widget.webSocketService}');
    print('Connecting to WebSocket...');
    print('Initializing WebSocket connection...');
    widget.webSocketService.connect(getRoomName(widget.currentUserUid, widget.selectedUserUid));
    print('Connected to WebSocket with room: ${getRoomName(widget.currentUserUid, widget.selectedUserUid)}');
   // final String uid = FirebaseAuth.instance.currentUser!.uid;
    print('Setting up message stream listener...');
    print('WebSocketService setup complete.');
    print('WebSocketService messagesStream: ${widget.webSocketService.messagesStream}');
    widget.webSocketService.messagesStream.listen((data) {
      print("Data received in stream: $data");
      // try {
      //   print("Attempting to decode JSON...");
      // //  final messageJson = json.decode(data);
      //   //print("Decoded JSON: $messageJson");
      //   final message = data['message'];
      //   final from = data['from'];
      //   final to = data['to'];
      //
      //   print('From: $from');
      //   print('Message: $message');
      //   print('To: $to');
      //
      //   print('Decoded message: $message');
      //   print('Message to: $to from: $from');
      //   print("Received message from: $from to: $to message: $message");
      //  // print("Received message init: $messageJson");
      // //   if (to == widget.selectedUserUid) {
      // //   setState(() {
      // //     messages.add({'message': message, 'isSent': false});
      // //   });
      // // }
      //
      //   if ((to == widget.currentUserUid && from == widget.selectedUserUid) ||
      //       (from == widget.currentUserUid && to == widget.selectedUserUid)) {
      //     setState(() {
      //       messages.add({'message': message, 'isSent': from == widget.currentUserUid});
      //     });
      //   }
      //   // Save the message to Firestore
      //   saveMessageToFirestore(message, from, to);
      // }
      // catch (e) {
      //   print('Error decoding message: $e');
      // }
    });
    print('Message stream listener setup complete.');



    // Load previous messages from Firestore
    loadMessagesFromFirestore();

  }

  Future<String> getCurrentUserUid() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      throw Exception("No user logged in");
    }
  }


  // void saveMessageToFirestore(String message, String from, String to) {
  //   final roomName = getRoomName(widget.currentUserUid, widget.selectedUserUid);
  //   FirebaseFirestore.instance.collection('chatRooms').doc(roomName).collection('messages').add({
  //     'message': message,
  //     'from': from,
  //     'to': to,
  //     'timestamp': Timestamp.now(),
  //   });
  // }

  void saveMessageToFirestore(String message, String from, String to) {
    final roomName = getRoomName(from, to);
    final chatRoomRef = FirebaseFirestore.instance.collection('chatRooms').doc(roomName);

    // Add message to the messages sub-collection
    chatRoomRef.collection('messages').add({
      'message': message,
      'from': from,
      'to': to,
      'timestamp': Timestamp.now(),
    });

    // Update the last message and timestamp at the chat room level
    chatRoomRef.set({
      'lastMessage': message,
      'lastMessageTimestamp': Timestamp.now(),
    }, SetOptions(merge: true));
  }


  void loadMessagesFromFirestore() {
    final roomName = getRoomName(widget.currentUserUid, widget.selectedUserUid);
    FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(roomName)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .listen((snapshot) {
      setState(() {
        messages = snapshot.docs.map((doc) => {
          'message': doc['message'],
          'isSent': doc['from'] == widget.currentUserUid,
          'senderName': doc['from'] == widget.currentUserUid ? 'You' : widget.selectedUserName,
        }).toList();
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.selectedUserName)),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                print("hellooo$message");
                return Align(
                  alignment: message['isSent'] ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: message['isSent'] ? Colors.blue[100] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(message['message']),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(labelText: 'Send a message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      final message = controller.text;
                      final messageObj = jsonEncode({'message': message,'to': widget.selectedUserUid,'from': widget.currentUserUid});
                     print("Sending message: $messageObj");
                      final to = widget.selectedUserUid;
                      final from =  widget.currentUserUid;
                      print(to);
                      print(from);

                      widget.webSocketService.sendMessage(messageObj,from,to);

                      // Save the message to Firestore (this will trigger the Firestore listener)
                      saveMessageToFirestore(message, widget.currentUserUid, widget.selectedUserUid);

                      // setState(() {
                      //   messages.add({'message': message, 'isSent': true});
                      // });
                      controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.webSocketService.close(); // Close WebSocket connection when widget is disposed
    super.dispose();
  }
}
//   final TextEditingController _controller = TextEditingController();
//   final List<Message> _messages = [];
//
//   @override
//   void initState() {
//     super.initState();
//     widget.webSocketService.messagesStream.listen((message) {
//       final decodedMessage = jsonDecode(message);
//       final messageText = decodedMessage['message'];
//       setState(() {
//         _messages.add(Message(
//           text: messageText,
//           sentByMe: false,
//         ));
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     widget.webSocketService.close();
//     super.dispose();
//   }
//
//   void _sendMessage() {
//     if (_controller.text.isNotEmpty) {
//       final message = _controller.text;
//       widget.webSocketService.sendMessage(jsonEncode({'message': message}));
//       setState(() {
//         _messages.add(Message(
//           text: message,
//           sentByMe: true,
//         ));
//         _controller.clear();
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat Application'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 final message = _messages[index];
//                 return Container(
//                   padding: EdgeInsets.all(8.0),
//                   alignment: message.sentByMe
//                       ? Alignment.centerRight
//                       : Alignment.centerLeft,
//                   child: Container(
//                     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
//                     decoration: BoxDecoration(
//                       color: message.sentByMe
//                           ? Colors.blueAccent
//                           : Colors.grey[300],
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     child: Text(
//                       message.text,
//                       style: TextStyle(
//                         color: message.sentByMe ? Colors.white : Colors.black,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: InputDecoration(
//                       labelText: 'Send a message',
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: _sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class Message {
//   final String text;
//   final bool sentByMe;
//
//   Message({required this.text, required this.sentByMe});
//}
