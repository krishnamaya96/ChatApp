class ChatRoom {
  final String id;
  final String name;
  final List<Message> messages;

  ChatRoom({required this.id, required this.name, required this.messages});
}

class Message {
  final String text;
  final String senderUid;
  final String senderName;
  final DateTime timestamp;

  Message({required this.text, required this.senderUid, required this.senderName, required this.timestamp});
}
