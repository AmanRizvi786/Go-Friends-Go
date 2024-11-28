
import 'dart:convert';
import 'dart:developer';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:http/http.dart' as http;
import 'package:gofriendsgo/model/chat_models/chat_list_model.dart';

class ChatServices {
 

  Future<ChatsListModel> fetchChats(String token) async {
    log('Fetching chats from service file');
    try {
      final response = await http.get(
        Uri.parse('${API.baseUrl}/chats'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        print("hey i am called-->${response.body}");
        return ChatsListModel.fromJson(parsed);
      } else {
        log('Error: Failed to load chats with status code ${response.statusCode}');
        print("hey i am NOT called-->${response.statusCode}");
        throw Exception('Failed to load chats');
      }
    } catch (e) {
      log('Exception caught: $e');
      throw Exception('Failed to load chats: $e');
    }
  }
}
