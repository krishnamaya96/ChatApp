import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<List<dynamic>> fetchChatRooms() async {

    final response = await http.get(Uri.parse('$baseUrl/chatroom/roomname/'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load chat rooms');
    }
  }

  Future<List<dynamic>> fetchMessages(int roomId) async {
    final response = await http.get(Uri.parse('$baseUrl/chatroom/roomname/'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load messages');
    }
  }
}
