// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/chat_models/chat_list_model.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/view_model/chats/fetching_chats.dart';
import 'package:gofriendsgo/view_model/chats/send_message_viewmodel.dart';
import 'package:gofriendsgo/widgets/chat_widgets/chat_appbar.dart';
import 'package:gofriendsgo/widgets/chat_widgets/chat_bubble.dart';
import 'package:gofriendsgo/widgets/chat_widgets/chat_field.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final ChatData chatData;
  const ChatScreen({super.key, required this.chatData});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    // context
    //     .read<FetchChatsViewModel>()
    //     .fetchMessages(FetchMessagesRequest(chatId: widget.chatData.id));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size(double.infinity, mediaqueryheight(0.09, context)),
            child: const ChatAppbar()),
        body: Consumer<FetchChatsViewModel>(
          builder: (context, value, child) {
            if (value.messages.isEmpty) {
              return const SizedBox();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: value.messages.length,
                    itemBuilder: (context, index) {
                      final message = value.messages[index];
                      return ChatBubble(
                        isCurrentUser: message.fromId == widget.chatData.id,
                        message: message.body,
                      );
                    },
                  ),
                ),
                _buildMessageInput(widget.chatData.id),
              ],
            );
          },
        ));
  }

  Widget _buildMessageInput(id) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              child: ChatField(
            controller: _messageController,
            hinttext: 'Type your message',
          )),
          const CustomSizedBoxWidth(0.02),
          Container(
            width: mediaquerywidth(0.13, context),
            height: mediaqueryheight(0.06, context),
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: AppColors.gradientColors)),
            child: IconButton(
              icon: const Icon(
                Icons.send,
                color: AppColors.whiteColor,
              ),
              onPressed: () {
                log('sending from screen');
                context
                    .read<SendMessageViewModel>()
                    .sendMessage(message: _messageController.text, chatId: id);
              
              },
            ),
          ),
        ],
      ),
    );
  }
}
// import 'dart:async';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:gofriendsgo/model/chat_models/chat_list_model.dart';
// import 'package:gofriendsgo/model/chat_models/fetch_messages_model.dart';
// import 'package:gofriendsgo/services/chats/fetch_messages_service.dart';
// import 'package:gofriendsgo/services/shared_preferences.dart';
// import 'package:gofriendsgo/utils/color_theme/colors.dart';
// import 'package:gofriendsgo/utils/constants/mediaquery.dart';
// import 'package:gofriendsgo/utils/constants/sizedbox.dart';
// import 'package:gofriendsgo/view_model/chats/send_message_viewmodel.dart';
// import 'package:gofriendsgo/widgets/chat_widgets/chat_appbar.dart';
// import 'package:gofriendsgo/widgets/chat_widgets/chat_bubble.dart';
// import 'package:gofriendsgo/widgets/chat_widgets/chat_field.dart';
// import 'package:provider/provider.dart';

// class ChatScreen extends StatefulWidget {
//   final ChatData chatData;
//   const ChatScreen({super.key, required this.chatData});

//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final StreamController<FetchMessagesModel> _streamController = StreamController<FetchMessagesModel>();

//   @override
//   void initState() {
//     super.initState();
//     _startFetchingMessages();
//   }

//   void _startFetchingMessages() {
//     FetchMessagesService()
//         .fetchMessagesStream(FetchMessagesRequest(chatId: widget.chatData.id), SharedPreferecesServices.token!)
//         .listen((messages) {
//       _streamController.sink.add(messages);
//     });
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     _streamController.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//           preferredSize: Size(double.infinity, mediaqueryheight(0.09, context)),
//           child: const ChatAppbar()),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           StreamBuilder<FetchMessagesModel>(
//             stream: _streamController.stream,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Expanded(
//                   child: ListView.builder(
//                     reverse: true,
//                     itemCount: snapshot.data!.messages.length,
//                     itemBuilder: (context, index) {
//                       final message = snapshot.data!.messages[index];
//                       return ChatBubble(
//                         isCurrentUser: message.fromId == widget.chatData.id,
//                         message: message.body,
//                       );
//                     },
//                   ),
//                 );
//               } else {
//                 return const Expanded(child: SizedBox());
//               }
//             },
//           ),
//           _buildMessageInput(widget.chatData.id),
//         ],
//       ),
//     );
//   }

//   Widget _buildMessageInput(id) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Expanded(
//               child: ChatField(
//             controller: _messageController,
//             hinttext: 'Type your message',
//           )),
//           const CustomSizedBoxWidth(0.02),
//           Container(
//             width: mediaquerywidth(0.13, context),
//             height: mediaqueryheight(0.06, context),
//             decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: LinearGradient(colors: AppColors.gradientColors)),
//             child: IconButton(
//               icon: const Icon(
//                 Icons.send,
//                 color: AppColors.whiteColor,
//               ),
//               onPressed: () {
//                 log('sending from screen');
//                context
//                    .read<SendMessageViewModel>()
//                    .sendMessage(message: _messageController.text, chatId: id);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // void _sendMessage(String message, String chatId) async {
//   //   try {
//   //     await FetchMessagesService().s(message, chatId);
//   //     _messageController.clear();
//   //     _startFetchingMessages(); // Fetch messages again to update the UI
//   //   } catch (e) {
//   //     log('Error sending message: $e');
//   //   }
//   // }
// }
