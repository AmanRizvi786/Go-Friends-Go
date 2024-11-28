// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:gofriendsgo/services/firebase/Message.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view_model/chats/create_chat_viewmodel.dart';
import 'package:gofriendsgo/view_model/profile_viewmodel.dart';
import 'package:gofriendsgo/widgets/chat_widgets/chat_field.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateChatScreen extends StatefulWidget {
  final String serviceName;
  final String image;

  const CreateChatScreen(
      {super.key, required this.serviceName, required this.image});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<CreateChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  final ValueNotifier<List<Message>> _messageNotifier = ValueNotifier([]);

  late final ProfileViewModel profileVM;
  late final CreateChatViewModel chatVM;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    profileVM = Provider.of<ProfileViewModel>(context, listen: false);
    chatVM = Provider.of<CreateChatViewModel>(context, listen: false);

    profileVM.fetchProfile().then((_) {
      chatVM.userId = profileVM.userEmail ?? "";
      chatVM.userName = profileVM.userName ?? "";
      chatVM.serviceName = widget.serviceName;
      chatVM.openChat();
      chatVM.mesgs?.listen((newMessages) {
        _messageNotifier.value = List.empty();
        _messageNotifier.value = List.from(_messageNotifier.value)
          ..addAll(newMessages);

        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
      });
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      log("SCROLLING down");
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      log("no clients");
    }
  }

  @override
  void dispose() {
    chatVM.mesgs = null;
    _scrollController.dispose();
    _messageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size(double.infinity, mediaqueryheight(0.09, context)),
            child: Container(
              height: mediaqueryheight(0.21, context),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: AppColors.gradientColors,
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft)),
              child: Column(
                children: [
                  SizedBox(
                    height: mediaqueryheight(0.05, context),
                  ),
                  Row(
                    children: [
                      const CustomSizedBoxWidth(0.04),
                      GestureDetector(
                        onTap: () {
                          PageNavigations().pop();
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: AppColors.whiteColor,
                          size: mediaquerywidth(0.07, context),
                        ),
                      ),
                      //const CustomSizedBoxWidth(0.02),
                      Container(
                        height: mediaqueryheight(0.05, context),
                        width: mediaquerywidth(0.05, context),
                        // decoration: BoxDecoration(
                        //     shape: BoxShape.circle,
                        //     image: DecorationImage(
                        //         fit: BoxFit.cover,
                        //         image: NetworkImage(
                        //             API.baseImageUrl + widget.image
                        //         )
                        //     )
                        // ),
                      ),
                      Container(
                        height: mediaqueryheight(0.055, context),
                        width: mediaqueryheight(0.055, context),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.whiteColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipOval(
                            child: widget.image.toLowerCase().endsWith('.svg')
                                ? SvgPicture.network(
                              API.baseImageUrl + widget.image,
                              fit: BoxFit.cover,
                            )
                                : Image.network(
                              API.baseImageUrl + widget.image,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error);
                              },
                            ),
                          ),
                        ),
                      ),
                      const CustomSizedBoxWidth(0.03),
                      CustomText(
                          weight: FontWeight.w600,
                          text: widget.serviceName,
                          fontFamily: CustomFonts.inter,
                          size: 0.045,
                          color: Colors.white)
                    ],
                  ),
                ],
              ),
            )),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ValueListenableBuilder<List<Message>>(
                  valueListenable: _messageNotifier,
                  builder: (context, messages, _) {
                    // final messages = snapshot.data!;
                    if (messages.isEmpty) {
                      return const Center(
                          child: Text(
                        "No messages yet",
                        style: TextStyle(fontSize: 20),
                      ));
                    }
                    return ListView.builder(
                        controller: _scrollController,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          final formattedTimestamp =
                              DateFormat('dd-MM-yyyy hh:mm a')
                                  .format(message.timestamp);
                          if (chatVM.userId == message.senderId) {
                            return _buildOutgoingMessage(message.senderName,
                                message.content, formattedTimestamp);
                          } else {
                            return _buildIncomingMessage(message.senderName,
                                message.content, formattedTimestamp);
                          }
                        });
                  }),
            ),
            _buildMessageInput((message) {
              _messageController.clear();
              log("$message in chatscreen");
              chatVM.sendMessage(message);
            }),
          ],
        ));
  }

  Widget _buildMessageInput(void onSend(String)) {
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
              // onPressed: () {
              //   if (_messageController.text != "" && _messageController.text.isEmpty) {
              //     onSend(_messageController.text.trim());
              //   }
              // },
                onPressed: () {
                  if (_messageController.text.isNotEmpty) {
                    onSend(_messageController.text.trim());
                  }
                }

            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomingMessage(String name, String message, String time) {
    return Column(children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.grey[300],
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 15),
                ),
                Text(message, style: const TextStyle(fontSize: 20)),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(time,
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontSize: 12)),
                )
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  Widget _buildOutgoingMessage(String name, String message, String time) {
    return Column(children: [
      Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: AppColors.gradientColors[0],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
                Text(message,
                    style: const TextStyle(fontSize: 20, color: Colors.white)),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(time,
                      textAlign: TextAlign.end,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.white)),
                )
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
