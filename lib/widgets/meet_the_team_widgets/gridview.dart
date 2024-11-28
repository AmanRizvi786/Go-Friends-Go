import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/teams_model/teams_model.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';

class GridViewMeetTheTeam extends StatelessWidget {
  final List<Team> teams;
  const GridViewMeetTheTeam(
    this.teams, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: mediaqueryheight(0.19, context),
          mainAxisSpacing: mediaqueryheight(0.025, context),
          crossAxisSpacing: mediaquerywidth(0.05, context),
          crossAxisCount: 3),
      itemBuilder: (context, index) {
        final teamMember = teams[index];
        return Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(8)),
            width: mediaquerywidth(0.24, context),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(90),
                  child: CachedNetworkImage(
                    width: mediaqueryheight(0.08, context),
                    height: mediaqueryheight(0.08, context),
                    imageUrl: API.baseImageUrl + teamMember.image,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                    ),
                    errorWidget: (context, url, error) =>
                        Image.asset(AppImages.goFriendsGoLogo),
                  ),
                ),
                const CustomSizedBoxHeight(0.008),
                SizedBox(
                  height: mediaqueryheight(0.025, context),
                  width: double.infinity,
                  child: CustomText(
                      textAlign: TextAlign.center,
                      textOverflow: TextOverflow.ellipsis,
                      text: teamMember.name,
                      fontFamily: CustomFonts.roboto,
                      size: 0.035,
                      weight: FontWeight.w500,
                      color: const Color.fromRGBO(39, 39, 39, 1)),
                ),
                SizedBox(
                  height: mediaqueryheight(0.02, context),
                  width: double.infinity,
                  child: CustomText(
                      textAlign: TextAlign.center,
                      textOverflow: TextOverflow.ellipsis,
                      text: teamMember.designation,
                      fontFamily: CustomFonts.roboto,
                      size: 0.03,
                      color: const Color.fromRGBO(0, 0, 0, 0.63)),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: teams.length,
    );
  }
}
