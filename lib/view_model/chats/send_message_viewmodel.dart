import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gofriendsgo/services/chats/send_message_service.dart';
import 'package:gofriendsgo/services/shared_preferences.dart';

class SendMessageViewModel extends ChangeNotifier {
  final SendMessageService _service = SendMessageService();
  bool _isLoading = false;
  String? _imagePath;
  
  bool get isLoading => _isLoading;
  String? get imagePath => _imagePath;


  // getImage()async{
  //   final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (image!=null) {
  //     _imagePath=image.path
  //   } 
  // }




  Future<void> sendMessage({
    required String message,
    required dynamic chatId,
    String? filePath,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
     
      await _service.sendMessage(
        token: SharedPreferecesServices.token!,
        message: message,
        chatId: chatId.toString(),
        filePath: filePath,
      );
      log('Message sent successfully');
       log(chatId.toString());
    } catch (e) {
      log('Error sending message: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
