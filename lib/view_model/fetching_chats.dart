
import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/chat_models/fetch_messages_model.dart';
// import 'package:gofriendsgo/services/chats/fetch_messages_service.dart';

class FetchChatsViewModel extends ChangeNotifier {
  // final FetchMessagesService _service = FetchMessagesService();
  FetchMessagesModel? _fetchMessagesModel;
  bool _isLoading = false;

  FetchMessagesModel? get fetchMessagesModel => _fetchMessagesModel;
  bool get isLoading => _isLoading;

  Future<void> fetchMessages(FetchMessagesRequest fetchMessageRequest) async {
    _isLoading = true;

  //   try {
  //     _fetchMessagesModel = await _service.fetchMessages(
  //         fetchMessageRequest, SharedPreferecesServices.token!);
  //     if (_fetchMessagesModel != null) {
  //       log('messages fetched successfully');
  //     }

  //     notifyListeners();
  //   } catch (e) {
  //     log('Error fetching cabs: $e');
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }
//}

// import 'dart:async';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:gofriendsgo/model/chat_models/fetch_messages_model.dart';
// import 'package:gofriendsgo/services/chats/fetch_messages_service.dart';
// import 'package:gofriendsgo/services/shared_preferences.dart';

// class FetchChatsViewModel extends ChangeNotifier {
//   final FetchMessagesService _service = FetchMessagesService();
//   FetchMessagesModel? _fetchMessagesModel;
//   bool _isLoading = false;
//   Timer? _timer;

//   FetchMessagesModel? get fetchMessagesModel => _fetchMessagesModel;
//   bool get isLoading => _isLoading;

//   void startFetchingMessages(FetchMessagesRequest fetchMessageRequest) {
//     _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
//       log('fetched from timer');
//       fetchMessages(fetchMessageRequest);
//     });
//   }

//   void stopFetchingMessages() {
//     _timer?.cancel();
//     _timer = null;
//   }

//   Future<void> fetchMessages(FetchMessagesRequest fetchMessageRequest) async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       _fetchMessagesModel = await _service.fetchMessages(
//           fetchMessageRequest, SharedPreferecesServices.token!);
//       if (_fetchMessagesModel != null) {
//         log('messages fetched successfully');
//       }
//     } catch (e) {
//       log('Error fetching messages: $e');
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   @override
//   void dispose() {
//     stopFetchingMessages();
//     super.dispose();
//   }
// }
  }}