import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/chat_models/chat_list_model.dart';
import 'package:gofriendsgo/services/chats/get_chat_list_service.dart';
import 'package:gofriendsgo/services/shared_preferences.dart';

class ChatListViewmodel extends ChangeNotifier {
  final ChatServices _service = ChatServices();
  ChatsListModel? _chatsModel;
  bool _isLoading = false;

  ChatsListModel? get chatsModel => _chatsModel;
  bool get isLoading => _isLoading;

  Future<void> fetchChatList() async {
    _isLoading = true;
 

    try {
      _chatsModel = await _service.fetchChats(SharedPreferecesServices.token!);
      if (_chatsModel != null) {
        log('chats fetched successfully');
      
      }   notifyListeners();
    } catch (e) {
      // Handle error
      log('Error fetching chats: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
