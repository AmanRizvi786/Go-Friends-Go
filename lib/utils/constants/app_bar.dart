import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';

import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/screen_padding.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';

class CommonGradientAppBar extends StatelessWidget {
  final bool fromBottomNav;
  final String heading;

  const CommonGradientAppBar({
    required this.fromBottomNav,
    required this.heading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: AppColors.gradientColors,
              begin: Alignment.centerRight,
              end: Alignment.centerLeft)),
      child: Padding(
        padding: commonScreenPadding(context),
        child: Column(children: [
          SizedBox(
            height: mediaqueryheight(0.05, context),
          ),
          Row(
            children: [
              if (fromBottomNav)
                Container(
                  height: mediaqueryheight(0.05, context),
                ),
              if (!fromBottomNav)
                IconButton(
                    iconSize: mediaquerywidth(0.08, context),
                    onPressed: () {
                      PageNavigations().pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.whiteColor,
                    )),
              if (!fromBottomNav) const CustomSizedBoxWidth(0.02),
              CustomText(
                  weight: FontWeight.bold,
                  text: heading,
                  fontFamily: CustomFonts.roboto,
                  size: 0.055,
                  color: AppColors.whiteColor)
            ],
          ),
        ]),
      ),
    );
  }
}

//app bar height is mediaqueryheight(0.08, context) in preferred size