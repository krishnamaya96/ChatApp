// import 'package:web_socket_channel/web_socket_channel.dart';
//
// class WebSocketService {
//   final WebSocketChannel channel;
//
//   WebSocketService({required this.channel});
//
//   void sendMessage(String message) {
//     channel.sink.add(message);
//   }
//
//   Stream<dynamic> get messages => channel.stream;
// }



// import 'dart:convert';
//
// import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/status.dart' as status;
//
// class WebSocketService {
//   IOWebSocketChannel? _channel;
//
//   void connect(String roomName) {
//     _channel = IOWebSocketChannel.connect('ws://127.0.0.1:8000/ws/chat/$roomName/');
//
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
//       _channel!.sink.close(status.goingAway);
//     }
//   }
//
//   Stream<dynamic>? get stream => _channel?.stream;
// }

// //main running
// import 'dart:io' show Platform;
//
// import 'package:chat_app/webSocket/webSocket_nonweb.dart'
//
// if (dart.library.html) 'webSocket_web.dart';
//
// class WebSocketService {
//   final WebSocketServiceBase _service;
//
//   WebSocketService() : _service = createWebSocketService();
//
//   void connect(String roomName) => _service.connect(roomName);
//
//   void sendMessage(String message) => _service.sendMessage(message);
//
//   void disconnect() => _service.disconnect();
//
//   Stream<dynamic>? get stream => _service.stream;
// }

import 'dart:async';

abstract class WebSocketService {
  void connect(String roomName);
  void sendMessage(String message);
  Stream<dynamic> get messagesStream;
  void close();
}

class WebSocketServiceImpl implements WebSocketService {
  late StreamController<dynamic> _controller;

  WebSocketServiceImpl() {
    _controller = StreamController.broadcast();
  }


  @override
  void connect(String roomName){

  }

  @override
  void sendMessage(String message) {
    // Implement platform-specific sendMessage in the respective files
  }

  @override
  Stream<dynamic> get messagesStream => _controller.stream;

  @override
  void close() {
    _controller.close();
  }

  void addMessage(dynamic message) {
    _controller.add(message);
  }
}

