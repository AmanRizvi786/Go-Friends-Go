import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_bar.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/view_model/chats/chat_list_viewmodel.dart';
import 'package:gofriendsgo/widgets/booking_details_widgets/booking_details_searchbar.dart';
import 'package:provider/provider.dart';

import '../../utils/constants/custom_text.dart';
import '../../utils/constants/paths.dart';
import '../../utils/navigations/navigations.dart';
import '../chat_screen/chat_screen.dart';

class ChatListScreen extends StatefulWidget {
  final bool fromBottomNav;
  const ChatListScreen({super.key, required this.fromBottomNav});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatListViewmodel>().fetchChatList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, mediaqueryheight(0.08, context)),
        child: CommonGradientAppBar(
          heading: 'Chats',
          fromBottomNav: widget.fromBottomNav,
        ),
      ),
      body: Column(
        children: [
          const ChatDetailsSearch(), // Moved above Consumer
          const CustomSizedBoxHeight(0.03),
          Expanded(
            child: Consumer<ChatListViewmodel>(
              builder: (context, value, child) {
                if (value.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (value.chatsModel == null || value.chatsModel!.data.isEmpty) {
                  return const Center(
                    child: Text("No chats available."),
                  );
                }
                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: value.chatsModel!.data.length,
                  itemBuilder: (context, index) {
                    final chatListModel = value.chatsModel!.data[index];
                    return ListTile(
                      onTap: () {
                        PageNavigations().push(ChatScreen(
                          chatData: chatListModel,
                        ));
                      },
                      title: CustomText(
                        weight: FontWeight.w600,
                        text: chatListModel.name,
                        color: AppColors.blackColor,
                        fontFamily: CustomFonts.inter,
                        size: 0.04,
                      ),
                      subtitle: CustomText(
                        weight: FontWeight.w300,
                        text: chatListModel.tag,
                        color: AppColors.blackColor,
                        fontFamily: CustomFonts.inter,
                        size: 0.03,
                      ),
                      leading: Container(
                        width: mediaquerywidth(0.12, context),
                        height: mediaqueryheight(0.06, context),
                        decoration: const BoxDecoration(
                          color: AppColors.whiteColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(AppImages.busIcon),
                        ),
                      ),
                      trailing: Column(
                        children: [
                          const CustomSizedBoxHeight(0.02),
                          CustomText(
                            weight: FontWeight.w300,
                            text: chatListModel.updatedAt.toString(),
                            color: AppColors.blackColor,
                            fontFamily: CustomFonts.inter,
                            size: 0.03,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class ChatDetailsSearch extends StatelessWidget {
  const ChatDetailsSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: mediaquerywidth(0.06, context),
        vertical: mediaqueryheight(0.04, context),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(25),
          /* Uncomment this if you want a shadow effect
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          */
        ),
        child: TextField(
          onChanged: (value) {
            // Assuming you want to filter chats based on the search query
            context.read<ChatListViewmodel>().fetchChatList();
          },
          decoration: InputDecoration(
            hintText: 'Search Message or Users',
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            hintStyle: const TextStyle(color: Colors.grey),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              vertical: mediaqueryheight(0.015, context),
            ),
          ),
        ),
      ),
    );
  }
}