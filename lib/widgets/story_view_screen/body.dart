import 'package:flutter/material.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';

PageView storyViewArea(
    {required PageController pageController,
    required int storyLength,
    required StoryCallBAck callBack,
    required String currentImagePath, required ValueKey<int> key}) {
  return PageView.builder(
    controller: pageController,
    itemCount: storyLength,
    onPageChanged: (index) {
      callBack(index);
    },
    itemBuilder: (context, index) {
      return SizedBox(
        width: double.infinity,
        height: mediaqueryheight(1, context),
        child: /*isVideo
            ? VideoStory(
                controller: videoController, videoURL: currentImagePath)
            : */Image.network(
                API.baseImageUrl + currentImagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(AppImages.goFriendsGoLogo);
                },
              ),
      );
    },
  );
}

typedef StoryCallBAck = void Function(int index);
