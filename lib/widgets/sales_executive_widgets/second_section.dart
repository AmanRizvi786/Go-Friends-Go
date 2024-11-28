import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';

class SecondSection extends StatelessWidget {
  const SecondSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
                text: TextStrings.rateExperience,
                fontFamily: CustomFonts.roboto,
                size: 0.035,
                weight: FontWeight.w500,
                color: Color.fromRGBO(0, 0, 0, 0.8)),
            const CustomSizedBoxHeight(0.01),
            Row(
              children: [
                ...List.generate(
                  5,
                  (index) {
                    return Icon(
                      Icons.star,
                      size: mediaquerywidth(0.14, context),
                      color: const Color.fromRGBO(167, 167, 167, 1),
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
