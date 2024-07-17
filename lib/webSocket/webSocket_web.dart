// import 'dart:convert';
// import 'dart:html';
//
// import 'package:web_socket_channel/html.dart';
//
// abstract class WebSocketServiceBase {
//   void connect(String roomName);
//   void sendMessage(String message);
//   void disconnect();
//   Stream<dynamic>? get stream;
// }
//
// // class WebSocketServiceWeb implements WebSocketServiceBase {
// //   WebSocket? _webSocket;
// //
// //   @override
// //   void connect(String roomName) {
// //     _webSocket = WebSocket('ws://127.0.0.1:8000/ws/chat/$roomName/');
// //     _webSocket!.onMessage.listen((event) {
// //       // Handle incoming messages
// //       print(event.data);
// //     });
// //   }
// //
// //   @override
// //   void sendMessage(String message) {
// //
// //     _webSocket?.send(message);
// //   }
// //
// //   @override
// //   void disconnect() {
// //     _webSocket?.close();
// //   }
// //
// //   @override
// //   Stream<dynamic>? get stream => _webSocket?.onMessage.map((event) => event.data);
// // }
//
//
//
//
// class WebSocketService implements WebSocketServiceBase {
//   HtmlWebSocketChannel? _channel;
//
//   void connect(String roomName) {
//     _channel = HtmlWebSocketChannel.connect('ws://127.0.0.1:8000/ws/chat/$roomName/');
//     _channel!.stream.listen((message) {
//       // Handle incoming messages
//       print(message);
//     });
//   }
//
//   void sendMessage(String message) {
//     if (_channel != null) {
//       final jsonMessage = jsonEncode({'message': message});
//       _channel!.sink.add(jsonMessage);
//     }
//   }
//
//   void disconnect() {
//     if (_channel != null) {
//       _channel!.sink.close();
//     }
//   }
//
//   Stream<dynamic>? get stream => _channel?.stream;
// }
//
// WebSocketServiceBase createWebSocketService() => WebSocketService();

import 'dart:async';
import 'dart:convert';
//import 'dart:html' as html;

import 'package:chat_app/webSocket/web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


class WebSocketServiceWeb extends WebSocketServiceImpl {
  //late html.WebSocket _webSocket;
  late WebSocketChannel _webSocketChannel;
  late String roomName;
  final _messageController = StreamController<Map<String, dynamic>>.broadcast();

  WebSocketServiceWeb(String serverUrl) {
    print('Connecting to WebSocket server at $serverUrl');
    _webSocketChannel = WebSocketChannel.connect(Uri.parse(serverUrl));
    _webSocketChannel.stream.listen((event) {
      print("Data received in WebSocket: $event");
      if (event is String) {
        // Decode the JSON string
        try {
          final decodedMessage = jsonDecode(event);
          if (decodedMessage is Map<String, dynamic>) {
            _messageController.add(decodedMessage);
            //addMessage(decodedMessage);
          }
          else {
            print('Error: Decoded message is not a map');
          }

        }
        catch (e) {
          print('Error decoding message: $e');
        }}
      //   }}else if (event is Map<String, dynamic>) {
      //   addMessage(event);
      // }
      else {
        print('Received unsupported message format: $event');
      }
    });
    //   try {
    //     final decodedMessage = jsonDecode(event);
    //     if (decodedMessage is Map<String, dynamic>) {
    //       addMessage(decodedMessage);
    //       // if (decodedMessage.containsKey('join')) {
    //       //   print('User joining room front: ${decodedMessage['join']}');
    //       // } else if (decodedMessage.containsKey('message')) {
    //       //
    //       //   //handleMessage(decodedMessage);
    //       // } else {
    //       //   print('Received message without a valid "join" or "message" field.');
    //       // }
    //     } else {
    //       print('Received invalid JSON format: $event');
    //     }
    //   } catch (e) {
    //     print('Error decoding message: $e');
    //   }
    // }, onError: (error) {
    //   print("WebSocket error: $error");
    // }, onDone: () {
    //   print("WebSocket connection closed.");
    // });
  }


    // print('Connecting to WebSocket server at $serverUrl');
    // _webSocketChannel = WebSocketChannel.connect(Uri.parse(serverUrl));
    // _webSocketChannel.stream.listen((event) {
    //   print("Data received in WebSocket: $event");
    //   try {
    //           final decodedMessage = jsonDecode(event);
    //           if (decodedMessage.containsKey('message')) {
    //             addMessage(decodedMessage['message']);
    //             print('Received message: ${decodedMessage['message']}');
    //           }
    //           else {
    //             print('Received message without a valid "message" field.');
    //           }
    //         } catch (e) {
    //           print('Error decoding message: $e');
    //         }
    // },
    //   onError: (error) {
    //     print("WebSocket error: $error");
    //   },
    //   onDone: () {
    //     print("WebSocket connection closed.");
    //   },
    // );


  @override
  void connect(String roomName) {
    this.roomName = roomName;
    print('Joining room: $roomName');
    _webSocketChannel.sink.add(jsonEncode({'join': roomName}));
  }
           //addMessage(event.data);

      // try {
      //   final decodedData = jsonDecode(event);
      //   if (decodedData != null && decodedData is Map<String, dynamic>) {
      //     final innerMessageJson = jsonDecode(decodedData['message']);
      //     if (innerMessageJson != null && innerMessageJson is Map<String, dynamic>) {
      //       final messageText = innerMessageJson['message'] ?? '';
      //       final to = innerMessageJson['to'] ?? '';
      //     } else {
      //       print('Invalid inner message format: $event');
      //     }
      //   } else {
      //     print('Received invalid JSON format: $event');
      //   }
      // } catch (e) {
      //   print('Error decoding message: $e');
      // }
    //enother code
  //   _webSocketChannel.stream.listen((event) {
  // //  _webSocket = html.WebSocket(serverUrl);
  //  // _webSocket.onMessage.listen((event) {
  //     try {
  //       final decodedMessage = jsonDecode(event);
  //       if (decodedMessage.containsKey('message')) {
  //         addMessage(decodedMessage['message']);
  //       } else {
  //         print('Received message: ${decodedMessage['message']} from ${decodedMessage['from']}');
  //       }
  //     } catch (e) {
  //       print('Error decoding message: $e');
  //     }
  //
  //    // addMessage(event.data);
  //   });

  // @override
  // void connect(String roomName) {
  //   this.roomName = roomName;
  //   _webSocketChannel.sink.add(jsonEncode({'join': roomName}));
  //   _webSocketChannel.stream.listen(
  //         (event) {
  //       print("Data received in WebSocket: $event");
  //       try {
  //         final decodedMessage = jsonDecode(event);
  //         if (decodedMessage.containsKey('message')) {
  //           addMessage(decodedMessage);
  //         }
  //       } catch (e) {
  //         print('Error decoding message: $e');
  //       }
  //     },
  //     onError: (error) {
  //       print("WebSocket error: $error");
  //     },
  //     onDone: () {
  //       print("WebSocket connection closed.");
  //     },
  //   );
  // }

  @override
  void sendMessage(String message,String from, String to) {

    final jsonMessage = json.encode({'message': message,'from': from, 'to':to});
    print(from);
    print(to);
    print(message);
    print('Sending message: $jsonMessage');
    _webSocketChannel.sink.add(jsonMessage);
   // _webSocket.sendString(jsonMessage);
  }

  @override
  void close() {
    print('Closing WebSocket connection');
    _webSocketChannel.sink.close();
  //  _webSocket.close();
    super.close();
  }

  // void addMessage(dynamic message) {
  //   if (message is Map<String, dynamic>) {
  //     _messageController.add(message);
  //   } else {
  //     print('Invalid message format');
  //   }
  // }

  Stream<Map<String, dynamic>> get messagesStream => _messageController.stream;

  // void handleMessage(Map<String, dynamic> decodedMessage) {
  //   try {
  //     if (decodedMessage.containsKey('message')) {
  //       final message = decodedMessage['message'];
  //       final fromUser = decodedMessage['from'];
  //       final toUser = decodedMessage['to'];
  //       print('Received message from $fromUser to $toUser: $message');
  //       // Handle the message as needed in your application
  //       // Example: Update UI, save message to local storage, etc.
  //     } else {
  //       print('Received message does not contain a valid "message" key.');
  //     }
  //   } catch (e) {
  //     print('Error handling WebSocket message: $e');
  //     // Handle any unexpected errors gracefully
  //   }
  // }

}
