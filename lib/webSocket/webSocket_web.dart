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

import 'dart:convert';
//import 'dart:html' as html;

import 'package:chat_app/webSocket/web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


class WebSocketServiceWeb extends WebSocketServiceImpl {
  //late html.WebSocket _webSocket;
  late WebSocketChannel _webSocketChannel;
  late String roomName;


  WebSocketServiceWeb(String serverUrl) {
    print('Connecting to WebSocket server at $serverUrl');
    _webSocketChannel = WebSocketChannel.connect(Uri.parse(serverUrl));
    _webSocketChannel.stream.listen((event) {
      print("Data received in WebSocket: $event");
      try {
              final decodedMessage = jsonDecode(event);
              if (decodedMessage.containsKey('message')) {
                addMessage(decodedMessage['message']);
              }
              // else {
              //   print('Received message: ${decodedMessage['message']} from ${decodedMessage['from']}');
              // }
            } catch (e) {
              print('Error decoding message: $e');
            }
    },
      onError: (error) {
        print("WebSocket error: $error");
      },
      onDone: () {
        print("WebSocket connection closed.");
      },
    );
  }

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
  void sendMessage(String message) {

    final jsonMessage = jsonEncode({'message': message});
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
}
