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


import 'dart:async';
import 'dart:convert';

import 'package:chat_app/webSocket/web_socket.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


class WebSocketServiceNonWeb extends WebSocketServiceImpl {
  late WebSocketChannel _channel;
  late String roomName;
  final _messageController = StreamController<Map<String, dynamic>>.broadcast();

  WebSocketServiceNonWeb(String serverUrl) {
    _channel = WebSocketChannel.connect(Uri.parse(serverUrl));
    _channel.stream.listen((event) {
      if (event is String) {
        try {
          final decodedMessage = jsonDecode(event);
          if (decodedMessage is Map<String, dynamic>) {
            _messageController.add(decodedMessage);
          } else {
            print('Error: Decoded message is not a map');
          }
        } catch (e) {
          print('Error decoding message: $e');
        }
      } else {
        print('Received unsupported message format: $event');
      }
    });
  }

  @override
  void connect(String roomName) {
    print('Joining room: $roomName');
    _channel.sink.add(jsonEncode({'join': roomName}));
  }

  @override
  void sendMessage(String message, String from, String to) {
    final jsonMessage = json.encode({'message': message, 'from': from, 'to': to});
    print('Sending message: $jsonMessage');
    _channel.sink.add(jsonMessage);
  }

  @override
  void disconnect() {
    print('Closing WebSocket connection');
    _channel.sink.close();
  }


  @override
  Stream<dynamic>? get stream => _messageController.stream;
}

