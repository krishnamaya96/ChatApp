import 'package:chat_app/webSocket/webSocket_nonweb.dart';
import 'package:chat_app/webSocket/webSocket_web.dart';
import 'package:chat_app/webSocket/web_socket.dart';
import 'package:universal_platform/universal_platform.dart';


WebSocketService createWebSocketService(String serverUrl) {
  if (UniversalPlatform.isWeb) {
    return WebSocketServiceWeb(serverUrl);
  } else {
    return WebSocketServiceNonWeb(serverUrl);
  }
}

String getRoomName(String currentUserUid, String selectedUserUid) {
  // Ensure a consistent room name regardless of user order
  return currentUserUid.compareTo(selectedUserUid) > 0
      ? '$currentUserUid-$selectedUserUid'
      : '$selectedUserUid-$currentUserUid';
}