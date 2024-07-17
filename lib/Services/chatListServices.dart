import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<ChatRooms>> getChatRooms() {
    return _firestore.collection('chatRooms').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ChatRooms.fromDocument(doc);
      }).toList();
    });
  }
}

class ChatRooms {
  final String id;

  ChatRooms({required this.id});

  factory ChatRooms.fromDocument(DocumentSnapshot doc) {
    return ChatRooms(
      id: doc.id,
    );
  }
}
