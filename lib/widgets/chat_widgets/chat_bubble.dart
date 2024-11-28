import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  // final String time;
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.message,
    // required this.time,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    final alignment =
        isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: AppColors.gradientColors,
                  end: Alignment.topRight,
                  begin: Alignment.bottomLeft),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              message,
              style: const TextStyle(fontSize: 17, color: AppColors.whiteColor),
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
