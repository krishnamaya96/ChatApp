// import 'dart:convert';
//
// import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/status.dart' as status;
//
// abstract class WebSocketServiceBase {
//   void connect(String roomName);
//   void sendMessage(String message);
//   void disconnect();
//   Stream<dynamic>? get stream;
// }
//
// class WebSocketServiceNonWeb implements WebSocketServiceBase {
//   IOWebSocketChannel? _channel;
//
//   @override
//   void connect(String roomName) {
//     _channel = IOWebSocketChannel.connect('ws://127.0.0.1:8000/ws/chat/$roomName/');
//     _channel!.stream.listen((message) {
//       // Handle incoming messages
//       print(message);
//     });
//   }
//
//   @override
//   void sendMessage(String message) {
//     if (_channel != null) {
//       final jsonMessage = jsonEncode({'message': message});
//       _channel!.sink.add(jsonMessage);
//     }
//   }
//
//   @override
//   void disconnect() {
//     if (_channel != null) {
//       _channel!.sink.close(status.goingAway);
//     }
//   }
//
//   @override
//   Stream<dynamic>? get stream => _channel?.stream;
// }
//
// WebSocketServiceBase createWebSocketService() => WebSocketServiceNonWeb();


import 'dart:convert';

import 'package:chat_app/webSocket/web_socket.dart';
import 'package:web_socket_channel/io.dart';


class WebSocketServiceNonWeb extends WebSocketServiceImpl {
  late IOWebSocketChannel _channel;

  WebSocketServiceNonWeb(String serverUrl) {
    _channel = IOWebSocketChannel.connect(serverUrl);
    _channel.stream.listen((message) {
      print("Data received in WebSocket: $message");
      try {
        final decodedMessage = jsonDecode(message);
        if (decodedMessage.containsKey('message')) {
          addMessage(decodedMessage['message']);
        } else {
          print('Received message format is invalid: $message');
        }
      } catch (e) {
        print('Error decoding message: $e');
      }

      //addMessage(message);
    });
  }

  @override
  void sendMessage(String message) {
    final jsonMessage = jsonEncode({'message': message});
   // final jsonMessage = jsonEncode({'message': message});
    _channel.sink.add(jsonMessage);
  }

  @override
  void close() {
    _channel.sink.close();
    super.close();
  }
}

