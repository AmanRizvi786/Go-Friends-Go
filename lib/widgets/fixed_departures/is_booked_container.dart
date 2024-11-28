import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
class FixedDepartureWithAirfareContainer extends StatelessWidget {
  const FixedDepartureWithAirfareContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: AppColors.fixedDeparturesAmberColor),
        child: Padding(
          padding: EdgeInsets.all(
              mediaqueryheight(0.01, context)),
          child: const CustomText(
              text: "Fixed Departure with Airfare",
              fontFamily: CustomFonts.roboto,
              size: 0.028,
              color: AppColors.whiteColor),
        ),
      );
  }
}