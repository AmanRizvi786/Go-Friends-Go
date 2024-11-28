import 'dart:convert';
import 'dart:developer';

import 'package:gofriendsgo/model/chat_models/create_chat_model.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:http/http.dart' as http;

class CreateChatService{
    Future<http.Response?> createChat(CreateChatRequest createChatRequest,String token) async {
    final url = Uri.parse('${API.baseUrl}/chats');
    final headers = {
         'Authorization': 'Bearer $token',
         'Content-Type': 'application/json'
    };
    final body = jsonEncode(createChatRequest.toJson());

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
     if (response.statusCode==200) {
         return response;
     }else{
      log("error in creating chat :${response.statusCode}");
      return response;
     }
   
    } catch (error) {
      log('Error creating chat: $error');
      return null;
    }
  }
}