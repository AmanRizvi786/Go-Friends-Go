import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/chat_models/create_chat_model.dart';
import 'package:gofriendsgo/services/chats/create_chat_service.dart';
import 'package:gofriendsgo/services/firebase/chat_service.dart';
import 'package:gofriendsgo/services/shared_preferences.dart';
import 'package:http/http.dart';

import '../../services/firebase/Message.dart';

class CreateChatViewModel extends ChangeNotifier {
  final ChatService _chatService = ChatService();
  var userId = "";
  var userName = "";
  var serviceName = "";

  final List<String> _messages = [];

  Stream<List<Message>>? mesgs;

  List<String> get messages => _messages;

  openChat() {
    _chatService.openChat(serviceName, userId);
    getAllMessages();
  }

  getAllMessages() {
     mesgs = _chatService.getMessages(serviceName);
  }

  sendMessage(String message) {
    _chatService.sendMessage(serviceName, userId, userName, message);
    log("$message: chatViewModel working fine");
  }
}
