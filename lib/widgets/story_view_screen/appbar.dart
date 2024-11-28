import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';

import 'package:gofriendsgo/view/story_display_screen/story_display_screen.dart';

class AppBarOfStoryViewScreen extends StatelessWidget {
  const AppBarOfStoryViewScreen({
    super.key,
    required this.widget,
    required int currentIndex,
  }) : _currentIndex = currentIndex;

  final StoryDisplayScreen widget;
  final int _currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: AppColors.gradientColors),
      ),
      child: Column(
        children: [
          const CustomSizedBoxHeight(0.04),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: mediaquerywidth(0.05, context)),
            child: Row(
              children: [
                Container(
                  width: mediaquerywidth(0.1, context),
                  height: mediaquerywidth(0.1, context),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: AppColors.whiteColor, width: 2),
                  ),
                ),
                const CustomSizedBoxWidth(0.03),
                CustomText(
                  text: widget.allStories[_currentIndex].title,
                  fontFamily: CustomFonts.roboto,
                  size: 0.055,
                  color: AppColors.whiteColor,
                  weight: FontWeight.w500,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    PageNavigations().pop();
                  },
                  child: Icon(
                    size: mediaquerywidth(0.08, context),
                    Icons.close,
                    color: AppColors.whiteColor,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}