import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../model/story_model/story_model.dart';
import '../../services/api/app_apis.dart';
import '../../utils/constants/custom_text.dart';
import '../../utils/constants/mediaquery.dart';
import '../../utils/constants/paths.dart';
import '../../utils/navigations/navigations.dart';
import '../../view/story_display_screen/story_display_screen.dart';

class StoryItem extends StatelessWidget {
  final List<Story> allStories;
  final int currentIndex;

  const StoryItem({
    Key? key,
    required this.allStories,
    required this.currentIndex,
  }) : super(key: key);

  Future<Uint8List?> _getVideoThumbnail(String videoUrl) async {
    log("Generating thumbnail for video URL: $videoUrl");

    try {
      final thumbnail = await VideoThumbnail.thumbnailData(
        video: videoUrl,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 128, // specify the size of the thumbnail
        quality: 75,
      );
      if (thumbnail == null) {
        log("Thumbnail generation returned null. Check the video URL or format.");
      }
      return thumbnail;
    } catch (e) {
      log("Error generating thumbnail: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isVideo = allStories[currentIndex].type == "video";

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            PageNavigations().push(StoryDisplayScreen(
              currentIndex: currentIndex,
              allStories: allStories,
            ));
          },
          child: Container(
            width: mediaquerywidth(0.14, context),
            height: mediaquerywidth(0.14, context),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color.fromRGBO(236, 147, 255, 1),
                width: 3.0,
              ),
            ),
            child: ClipOval(
              child: isVideo
                  ? FutureBuilder<Uint8List?>(
                future: _getVideoThumbnail(API.baseImageUrl + allStories[currentIndex].image),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  }
                  if (snapshot.hasError || snapshot.data == null) {
                    return Image.asset(
                      AppImages.goFriendsGoLogo,
                      fit: BoxFit.cover,
                    );
                  }
                  return Image.memory(
                    snapshot.data!,
                    fit: BoxFit.cover,
                  );
                },
              )
                  : Image.network(
                API.baseImageUrl + allStories[currentIndex].image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(AppImages.goFriendsGoLogo);
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        CustomText(
          text: allStories[currentIndex].title,
          fontFamily: CustomFonts.poppins,
          size: 0.04,
          color: Colors.black,
        ),
      ],
    );
  }
}