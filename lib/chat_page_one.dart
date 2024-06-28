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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';


class WebSocketExamplePage extends StatefulWidget {

  final WebSocketService webSocketService;
  final String selectedUserUid;
  final String currentUserUid;
  final String selectedUserName;

  WebSocketExamplePage({required this.webSocketService,required this.selectedUserUid,required this.currentUserUid,required this.selectedUserName,});
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<WebSocketExamplePage> {

  final TextEditingController controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  late String currentUserUid;
  late String selectedUserUid;
  late WebSocketService _webSocketService;

  @override
  void initState() {
    super.initState();
    initializeUids();
    widget.webSocketService.connect(widget.selectedUserUid);
   // final String uid = FirebaseAuth.instance.currentUser!.uid;
    widget.webSocketService.messagesStream.listen((data) {
      print("Data received in stream: $data");
      try {
        final messageJson = json.decode(data);
        final message = messageJson['message'];
        final to = messageJson['to'];
        final from = messageJson['from'];
        print(from);
        print("Received message from: $from to: $to message: $message");
        print("Received message init: $messageJson");
        if (to == widget.currentUserUid) {
        setState(() {
          messages.add({'message': message, 'isSent': false});
        });
      } }catch (e) {
        print('Error decoding message: $e');
      }
    });


  }

  Future<String> getCurrentUserUid() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      throw Exception("No user logged in");
    }
  }

  Future<void> initializeUids() async {
    currentUserUid = await getCurrentUserUid();
    // Assume selectedUserUid is passed or set somewhere in your code
    // For example, you can pass it through the constructor
    selectedUserUid = widget.selectedUserUid;
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
                      final messageObj = json.encode({'message': message,'to': widget.selectedUserUid,'from': widget.currentUserUid});
                      print("Sending message: $messageObj");

                      widget.webSocketService.sendMessage(messageObj);
                      setState(() {
                        messages.add({'message': message, 'isSent': true});
                      });
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
